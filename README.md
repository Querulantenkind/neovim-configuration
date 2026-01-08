<p align="center">
  <h1 align="center">nvim</h1>
  <p align="center">
    A modern Neovim configuration for NixOS
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

## Features

- **NixOS Native** — No Mason, all LSPs and formatters installed via Nix
- **Modern APIs** — Uses Neovim 0.11+ `vim.lsp.config` and `vim.lsp.enable`
- **Lazy Loading** — Fast startup with [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Writing Mode** — Zen mode, Twilight, and soft wrap for distraction-free prose
- **Full IDE** — LSP, completions, diagnostics, formatting, and more
- **Beautiful** — Nord colorscheme with custom statusline

## Screenshot

<!-- Add your screenshot here -->
<!-- ![Screenshot](./screenshot.png) -->

## Requirements

- **Neovim 0.11+**
- **NixOS** or Nix package manager

### Nix Packages

Install these via your NixOS configuration or home-manager:

```nix
environment.systemPackages = with pkgs; [
  # LSP Servers
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

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone https://github.com/YOUR_USERNAME/nvim.git ~/.config/nvim

# Start Neovim (plugins install automatically)
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua      # Vim options (leader = space)
│   │   ├── keymaps.lua      # Global keybindings
│   │   └── lazy.lua         # Plugin manager bootstrap
│   └── plugins/
│       ├── lsp.lua          # Language servers
│       ├── treesitter.lua   # Syntax highlighting
│       ├── completion.lua   # Autocompletion (nvim-cmp)
│       ├── telescope.lua    # Fuzzy finder
│       ├── formatting.lua   # Code formatting (conform.nvim)
│       ├── editor.lua       # Editing helpers
│       ├── ui.lua           # UI components
│       ├── colorscheme.lua  # Nord theme
│       └── writing.lua      # Prose & markdown tools
└── CLAUDE.md                # AI assistant context
```

## Keybindings

Leader key: `Space`

### Navigation

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>/` | Search in buffer |
| `<leader>n` | Toggle file tree |
| `<S-h>` / `<S-l>` | Previous / Next buffer |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format buffer |

### Git

| Key | Description |
|-----|-------------|
| `]h` / `[h` | Next / Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Writing

| Key | Description |
|-----|-------------|
| `<leader>z` | Toggle Zen Mode |
| `<leader>tw` | Toggle Twilight |
| `<leader>mp` | Markdown Preview |
| `<leader>ss` | Toggle spell check |

## Plugins

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [nord.nvim](https://github.com/shaunsingh/nord.nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | Distraction-free writing |
| [twilight.nvim](https://github.com/folke/twilight.nvim) | Dim inactive code |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |

## Customization

### Adding a Language Server

1. Install the LSP via Nix
2. Add to `lua/plugins/lsp.lua`:
   ```lua
   local servers = {
       your_lsp = {
           settings = { ... },  -- optional
       },
   }
   ```

### Adding a Formatter

1. Install the formatter via Nix
2. Add to `lua/plugins/formatting.lua`:
   ```lua
   formatters_by_ft = {
       your_filetype = { "your_formatter" },
   }
   ```

## License

MIT License

Copyright (c) 2025 Querulantenkind

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
