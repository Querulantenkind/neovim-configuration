<p align="center">
  <h1 align="center">nixvim</h1>
  <p align="center">
    A modern Neovim configuration built for NixOS
    <br />
    <em>Code fast. Write beautifully.</em>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim 0.11+" />
  <img src="https://img.shields.io/badge/NixOS-Native-5277C3?style=flat-square&logo=nixos&logoColor=white" alt="NixOS Native" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="MIT License" />
</p>

---

## What Makes This Different

Most Neovim configurations follow the same pattern: lspconfig, Mason, and a collection of popular plugins. This one takes a different approach.

### Native Neovim 0.11+ APIs

While most configs still use `require("lspconfig").server.setup()`, this configuration embraces the new built-in LSP API introduced in Neovim 0.11:

```lua
-- Old way (lspconfig)
require("lspconfig").lua_ls.setup({ settings = { ... } })

-- This config (native)
vim.lsp.config.lua_ls = { settings = { ... } }
vim.lsp.enable("lua_ls")
```

Cleaner. Fewer dependencies. Future-proof.

### No Mason — Pure Nix

Mason is great for portability, but it creates a parallel package ecosystem inside Neovim. On NixOS, this is redundant at best, problematic at worst.

This config expects all LSPs and formatters to be installed via Nix — declaratively, reproducibly, and managed alongside the rest of your system. No imperative tool managers fighting your package manager.

```nix
# Everything in one place
environment.systemPackages = with pkgs; [
  rust-analyzer
  typescript-language-server
  prettierd
  stylua
];
```

### Built for Writing, Not Just Coding

Most developer configs ignore prose. This one includes a complete writing environment:

| Feature | Purpose |
|---------|---------|
| **Zen Mode** | Distraction-free fullscreen editing |
| **Twilight** | Dims inactive code blocks |
| **Pencil** | Soft line wraps for prose |
| **Markdown Preview** | Live browser preview |
| **Spell Check** | Toggle with `<leader>ss` |

Perfect for documentation, notes, or long-form writing.

### Aggressive Lazy Loading

Every plugin loads on demand — by event, command, keymap, or filetype. Startup stays fast regardless of how many plugins are installed.

---

## Requirements

- **Neovim 0.11+**
- **NixOS** or Nix package manager

### Required Nix Packages

```nix
environment.systemPackages = with pkgs; [
  # Language Servers
  typescript-language-server
  vscode-langservers-extracted  # html, css, eslint, json
  rust-analyzer
  gopls
  clang-tools                   # clangd
  pyright
  ruff
  lua-language-server

  # Formatters
  prettierd
  rustfmt
  stylua
  nixfmt-rfc-style
];
```

---

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://codeberg.org/querulantenkind/nixvim.git ~/.config/nvim

# Launch — plugins install automatically
nvim
```

---

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua      # Core settings, leader = space
│   │   ├── keymaps.lua      # Global keybindings
│   │   └── lazy.lua         # Plugin manager bootstrap
│   └── plugins/
│       ├── lsp.lua          # Language server configuration
│       ├── treesitter.lua   # Syntax parsing
│       ├── completion.lua   # Autocompletion engine
│       ├── telescope.lua    # Fuzzy finder
│       ├── formatting.lua   # Code formatting
│       ├── editor.lua       # Editing utilities
│       ├── ui.lua           # Interface components
│       ├── colorscheme.lua  # Nord theme
│       └── writing.lua      # Prose and markdown tools
└── CLAUDE.md                # AI assistant context
```

---

## Keybindings

Leader key: **Space**

### Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>/` | Search in current buffer |
| `<leader>n` | Toggle file tree |
| `S-h` / `S-l` | Previous / next buffer |

### Language Server

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format buffer |

### Git Integration

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |

### Writing

| Key | Action |
|-----|--------|
| `<leader>z` | Toggle Zen Mode |
| `<leader>tw` | Toggle Twilight |
| `<leader>mp` | Markdown preview |
| `<leader>ss` | Toggle spell check |

---

## Supported Languages

| Language | Server | Formatter |
|----------|--------|-----------|
| TypeScript / JavaScript | ts_ls | prettierd |
| HTML / CSS | html, cssls | prettierd |
| Rust | rust_analyzer | rustfmt |
| Go | gopls | gofmt, goimports |
| C / C++ | clangd | clang-format |
| Python | pyright, ruff | ruff_format |
| Lua | lua_ls | stylua |
| Nix | — | nixfmt |

---

## Extending

### Add a Language Server

1. Install via Nix
2. Configure in `lua/plugins/lsp.lua`:

```lua
local servers = {
    your_server = {
        settings = { ... },
    },
}
```

### Add a Formatter

1. Install via Nix
2. Configure in `lua/plugins/formatting.lua`:

```lua
formatters_by_ft = {
    your_filetype = { "your_formatter" },
}
```

---

## Plugins

| Plugin | Role |
|--------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [nord.nvim](https://github.com/shaunsingh/nord.nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | Distraction-free editing |
| [twilight.nvim](https://github.com/folke/twilight.nvim) | Focus mode |

---

## Non-NixOS Usage

This config works on any distribution. The Lua configuration is distro-agnostic — it simply expects the language servers and formatters to exist in your `$PATH`.

Install them via your package manager, npm, pip, or cargo:

```bash
# Arch
pacman -S typescript-language-server rust-analyzer gopls lua-language-server stylua

# npm
npm i -g typescript-language-server prettierd

# pip
pip install ruff

# cargo
cargo install stylua
```

Alternatively, add Mason back for automatic tool management.

---

## License

MIT License — Luca Gabriel Oelfke, 2025
