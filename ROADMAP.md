# Roadmap

Each phase ends with a working editor. The full design and its reasoning are in
[ADR-0001](docs/decisions/0001-foundational-design.md).

**Who types:** Phase 0 is written by Claude with heavy comments. Phase 1 is
skeletons with `TODO` holes. From Phase 2 on, Steven writes and Claude reviews.

## Phase 0: Prep & bootstrap ✅
- [x] Upgrade Neovim to 0.12.6
- [x] Install `fd`, `lazygit`, `llama.cpp`, Monaspice Nerd Font
- [x] Back up NvChad config/data to `*.nvchad.bak`
- [x] Repo skeleton, `init.lua`, options, keymaps, autocmds, `vim.pack` loader
- [x] Cheatsheet float (`<leader>?`)
- [x] Symlink `~/.config/nvim` → `nvim/`

## Phase 1: Look
- [ ] material.nvim, "darker" style
- [ ] Hand-built kitty theme from material.nvim's palette (`kitty/`)
- [ ] Kitty font: Monaspice Neon, Radon italics, texture healing on, ligatures off
- [ ] Statusline showing the mode (then `showmode = false`)

## Phase 2: Editor core
- [ ] snacks.nvim (picker, notifier, lazygit float)
- [ ] oil.nvim (`-`)
- [ ] which-key with group labels (`f` `g` `G` `l` `a` `t`)

## Phase 3: Languages
- [ ] treesitter
- [ ] Mason + native `vim.lsp.config`: vtsls, gopls, rust-analyzer, basedpyright, ruff
- [ ] conform.nvim, format on save
- [ ] Native `vim.lsp.completion` (blink.cmp only if it hurts)
- [ ] Diagnostics config

## Phase 4: Local git
- [ ] gitsigns
- [ ] diffview
- [ ] lazygit keymaps

## Phase 5: Claude core
- [ ] claudecode.nvim with Claude in a herdr pane (`terminal.provider = "none"`)
- [ ] `claude/pair.json` passed via `claude --settings`: hooks, output style, MCP
- [ ] Senior-engineer output style (persona)
- [ ] Trust levels (Navigator / Pair / Driver): state file, PreToolUse + UserPromptSubmit hooks
- [ ] Statusline trust-level indicator, `<leader>al`
- [ ] `<leader>aa` focus/toggle the Claude pane

## Phase 6: Local ghost text (Tier 1)
- [ ] llama.vim + `llama-server`, started on entering Pair and stopped on leaving
- [ ] Qwen2.5-Coder-7B vs Qwen3-Coder-30B-A3B: log latency + acceptance, decide in an ADR

## Phase 7: Focus marks
- [ ] Lua side: pin regions, persistent highlights, virtual-text notes
- [ ] Go MCP server (`mcp/`): `list_marks`, `add_note`, `resolve_note`

## Phase 8: Deep suggest & challenges (Tiers 2–3)
- [ ] `<leader>as` deep suggest: headless `claude -p` (Sonnet) with read-only tools → ghost text / diff
- [ ] Auto challenge after a changed function in Pair (Sonnet, ≤3 notes, hourly cap)
- [ ] `<leader>ac` manual challenge (Opus)
- [ ] Quota guard in the statusline

## Phase 9: GitLab
- [ ] Issues picker backed by `glab`
- [ ] gitlab.nvim: MR review, pipelines

## Phase 10: Other drivers
- [ ] ACP client (codecompanion.nvim or agentic.nvim) so other / self-hosted models can drive

## Experiments backlog
- Feed pinned focus marks to the local model as `input_extra` context
- Semantic repo context for Tier 1 (VectorCode + minuet). VectorCode looked stalled as of 2026-10
- Sandboxing Bash in Navigator mode, if the honour system leaks
