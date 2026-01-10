# Neovim Config

NixOS-basierte Neovim-Konfiguration mit Lazy.nvim. LSPs und Formatter werden über Nix installiert (kein Mason).

## Dateistruktur

```
init.lua                     # Einstiegspunkt
lua/config/
  options.lua                # Vim-Optionen, Leader = Space
  keymaps.lua                # Globale Keymaps
  lazy.lua                   # Plugin-Manager Bootstrap
lua/plugins/
  lsp.lua                    # LSP (vim.lsp.config API, Neovim 0.11+)
  treesitter.lua             # Syntax-Parsing
  completion.lua             # nvim-cmp + LuaSnip
  telescope.lua              # Fuzzy Finder
  formatting.lua             # conform.nvim, Format-on-Save
  editor.lua                 # autopairs, surround, comments, trouble
  ui.lua                     # lualine, gitsigns, nvim-tree, which-key, indent-blankline
  colorscheme.lua            # Catppuccin Theme
  writing.lua                # zen-mode, twilight, pencil, markdown-preview
```

## Konventionen

- **Neovim 0.11+ APIs** verwenden (`vim.lsp.config`, `vim.lsp.enable`)
- **Kein Mason** - LSPs/Formatter über Nix-Pakete installieren
- **Eager Loading** - Alle Plugins werden beim Start geladen (`lazy = false`)
- **Deutsche Kommentare** in config-Dateien erlaubt

## Sprachen

| Sprache    | LSP              | Formatter       | Nix-Paket                    |
|------------|------------------|-----------------|------------------------------|
| TypeScript | ts_ls            | prettierd       | typescript-language-server, prettierd |
| HTML/CSS   | html, cssls      | prettierd       | vscode-langservers-extracted |
| Rust       | rust_analyzer    | rustfmt         | rust-analyzer, rustfmt       |
| Go         | gopls            | gofmt, goimports| gopls                        |
| C/C++      | clangd           | clang-format    | clang-tools                  |
| Python     | pyright, ruff    | ruff_format     | pyright, ruff                |
| Lua        | lua_ls           | stylua          | lua-language-server, stylua  |
| Nix        | (entfernt)       | nixfmt          | nixfmt                       |

## Neuen LSP hinzufügen

1. Nix-Paket installieren (NixOS config oder home-manager)
2. In `lua/plugins/lsp.lua` zur `servers`-Tabelle hinzufügen:
   ```lua
   servers = {
       neuer_lsp = {
           settings = { ... },  -- optional
       },
   }
   ```

## Neuen Formatter hinzufügen

1. Nix-Paket installieren
2. In `lua/plugins/formatting.lua` unter `formatters_by_ft`:
   ```lua
   filetype = { "formatter_name" },
   ```

## Wichtige Keybindings

Leader: `Space`

### Navigation
| Key | Beschreibung |
|-----|--------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>/` | Search in buffer |
| `<leader>n` | Toggle file tree |
| `<S-h>/<S-l>` | Prev/Next buffer |

### LSP
| Key | Beschreibung |
|-----|--------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>cf` | Format buffer |

### Git
| Key | Beschreibung |
|-----|--------------|
| `]h/[h` | Next/Prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |

### Diagnostics
| Key | Beschreibung |
|-----|--------------|
| `]d/[d` | Next/Prev diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>xx` | Trouble diagnostics |

### Writing
| Key | Beschreibung |
|-----|--------------|
| `<leader>z` | Zen Mode |
| `<leader>mp` | Markdown Preview |
| `<leader>ss` | Toggle spell check |
