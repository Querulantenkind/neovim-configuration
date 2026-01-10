return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- Install parsers
            require("nvim-treesitter").install({
                -- Web
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "json",
                "jsonc",
                -- Systems
                "rust",
                "go",
                "c",
                "cpp",
                -- Python
                "python",
                -- Nix
                "nix",
                -- Config/Markup
                "lua",
                "vim",
                "vimdoc",
                "yaml",
                "toml",
                "markdown",
                "markdown_inline",
                "bash",
                "regex",
            })

            -- Incremental selection keymaps
            vim.keymap.set("n", "<C-space>", function()
                require("nvim-treesitter.incremental_selection").init_selection()
            end, { desc = "Init treesitter selection" })
            vim.keymap.set("x", "<C-space>", function()
                require("nvim-treesitter.incremental_selection").node_incremental()
            end, { desc = "Increment treesitter selection" })
            vim.keymap.set("x", "<bs>", function()
                require("nvim-treesitter.incremental_selection").node_decremental()
            end, { desc = "Decrement treesitter selection" })
        end,
    },
}
