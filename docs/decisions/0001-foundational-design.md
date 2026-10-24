# ADR-0001: Foundational design

- **Date:** 2026-10-23
- **Status:** Accepted

## Context

Years of letting AI drive had dulled Steven's coding and thinking skills. The
NvChad config treated Claude as a terminal in a split: it couldn't see the
cursor, selection or diagnostics, and the only real mode was "Claude does it".
Copilot ghost text was always on (and broken, since `copilot-cmp` required
`lazyvim.util`, which wasn't installed).

The goal is a from-scratch editor in which Claude is a **senior-engineer pair**.
It questions, challenges and reviews, and drives only when explicitly handed
the reins.

## Decisions

### How we build
- **No distro.** Neovim 0.12 + `vim.pack`. A plugin is added only after feeling
  the pain it solves.
- **Support fades by phase.** In Phase 0 Claude writes heavily commented code.
  Phase 1 is skeletons with holes. From Phase 2, Steven types and Claude reviews.
- **ADRs** record the *why* (this folder). **CHEATSHEET.md** is updated in the
  same commit as any keymap change.

### Look
- material.nvim "darker". Kitty is themed by hand from the same palette.
- Monaspice Nerd Font: Neon for code, Radon for italics/comments, texture
  healing on, ligatures off.

### Trust levels
Switched from nvim (`<leader>al`) and shown in the statusline:

| Level | Claude may | Ghost text |
|---|---|---|
| **Navigator** (default) | read, comment, question. No edits | off |
| **Pair** | propose edits as nvim diffs you accept or reject | local, as-you-type |
| **Driver** | edit freely. You review in diffview | — |

Enforced by Claude Code hooks, not by restarting with a different permission
mode. nvim writes the level to a state file. A PreToolUse hook denies, asks or
allows Edit/Write based on it, and a UserPromptSubmit hook tells Claude the
level every turn. Bash writes in Navigator rely on the honour system for now.

### Claude wiring
- Claude Code runs in a **herdr pane** next to nvim, so restarting nvim
  doesn't kill it. claudecode.nvim's WebSocket carries selections and
  @-mentions, and `herdr pane send-text` carries free-form prompts.
- Launched as `claude --settings <repo>/claude/pair.json`, so hooks, persona and
  MCP apply **only** to pair sessions. The global `~/.claude` config stays untouched.
- **Persona** (output style): questions before answers ("just tell me" always
  works), direct, states own confidence, picks battles, treats the trust level
  as a hard boundary.

### Focus marks
Pinned regions stay highlighted across files, and Claude can attach
virtual-text notes to them. Claude reads and writes them through a **narrow Go
MCP server** (`list_marks`, `add_note`, `resolve_note`) over nvim's socket.
Rejected: claudecode.nvim custom tools, because Claude Code only exposes two
IDE tools to the model. Also rejected: generic nvim MCP servers, because
`exec_lua` is far broader access than a reviewer needs.

### Three tiers of AI help
| Tier | Engine | Context | Trigger |
|---|---|---|---|
| 1 As-you-type | `llama-server` + llama.vim, Qwen-Coder (local, free) | recent files via repo-level FIM `input_extra` | automatic, Pair only |
| 2 Deep suggest | headless `claude -p`, Sonnet, read-only tools | whole repo | `<leader>as` |
| 3 Heavy hitter | Opus | whole repo | manual: `<leader>ac`, MR reviews, architecture |

Automatic post-function challenges use Sonnet, leave at most 3 notes, and have an
hourly cap shown in the statusline. Silence is allowed. No API keys anywhere:
the subscription runs through the `claude` CLI and Tier 1 is local.

- **Ollama rejected for Tier 1.** It has no equivalent of llama.cpp's
  `/infill` `input_extra`, so it can't do repo-level FIM.
- **The model is chosen by measuring.** Qwen2.5-Coder-7B is the baseline,
  compared against Qwen3-Coder-30B-A3B on latency and acceptance, then
  decided in its own ADR.
- **The server starts on entering Pair and stops on leaving**, keeping 8–18 GB
  free the rest of the time.

### Editor core
snacks.nvim (picker, notifier, lazygit), oil.nvim, which-key, gitsigns, diffview,
lazygit. Mason handles vtsls, gopls, rust-analyzer, basedpyright and ruff.
conform does format-on-save. Completion is native `vim.lsp.completion` first.

### Forges
Work is on GitLab (`git.ops.trddev.io`, tickets as GitLab issues): an issues
picker backed by `glab`, plus gitlab.nvim for MRs and pipelines. GitHub stays
minimal, since only this repo lives there.

### Keymaps
`<space>` leader: `f` find, `g` git, `G` GitLab, `l` LSP, `a` AI, `t` toggles,
`-` oil. `;`→`:` and `jk`→Esc are kept.

## Consequences
- Claude integration only arrives in Phase 5, after four phases of plain editing.
  This is deliberate: vim skills come back first.
- Several pieces are home-grown (trust levels, focus marks, the MCP server,
  challenge reviews), which means more to maintain. That is the point of a
  proving ground, and each feature has its own on/off switch in
  `lua/proving_grounds/init.lua`.
- Self-hosting Claude Code against local models via `ANTHROPIC_BASE_URL` works,
  but Anthropic doesn't support it. The supported plug-and-play path for other
  models is ACP (Phase 10).
