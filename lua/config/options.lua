-- Neovim Options
local opt = vim.opt

-- Zeilennummern
opt.number = true
opt.relativenumber = true

-- Einrückung
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Suche
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Darstellung
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Backup/Swap
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Sonstiges
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menuone,noselect"

-- Globale Leader-Taste
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Rechtschreibprüfung
opt.spelllang = { "de", "en" }
opt.spelloptions = "camel"

-- Prose-Modus für Markdown/Text
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "tex", "plaintex", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})
