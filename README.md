# proving-grounds.nvim

A from-scratch Neovim setup for **pair programming with AI as a senior engineer,
not a driver**. Claude reviews, questions and challenges. It writes code only
when explicitly handed the reins. The editor is also a workbench for prototyping
AI-assisted editing features. Some ideas here will be kept and some won't.

- Design and reasoning: [ADR-0001](docs/decisions/0001-foundational-design.md)
- What's done and what's next: [ROADMAP.md](ROADMAP.md)
- Keys: [CHEATSHEET.md](CHEATSHEET.md), or `Space ?` inside nvim

## Install (macOS)

Requires Neovim ≥ 0.12.

```sh
git clone git@github.com:StevenD2002/proving-grounds.nvim.git ~/fun/proving-grounds.nvim
ln -s ~/fun/proving-grounds.nvim/nvim ~/.config/nvim
ln -s ~/fun/proving-grounds.nvim/herdr/config.toml ~/.config/herdr/config.toml
ln -s ~/fun/proving-grounds.nvim/kitty ~/.config/kitty/proving-grounds
echo 'include proving-grounds/proving-grounds.conf' >> ~/.config/kitty/kitty.conf
brew install --cask font-monaspice-nerd-font
```

## Layout

```
nvim/                    → symlinked to ~/.config/nvim
  init.lua               load order only
  lua/config/            options, keymaps, autocmds, plugin loader
  lua/plugins/           one file per third-party plugin (vim.pack)
  lua/proving_grounds/   home-grown features, each switchable
herdr/config.toml        → symlinked to ~/.config/herdr/config.toml
kitty/                   → symlinked to ~/.config/kitty/proving-grounds (font + theme)
docs/decisions/          ADRs
```

`claude/` and `mcp/` arrive in later phases.
