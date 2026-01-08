return {
    -- Zen Mode für ablenkungsfreies Schreiben
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
        },
        opts = {
            window = {
                backdrop = 0.95,
                width = 80,
                height = 1,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    foldcolumn = "0",
                },
            },
            plugins = {
                twilight = { enabled = true },
                gitsigns = { enabled = false },
            },
        },
    },

    -- Twilight - dimmt inaktive Absätze
    {
        "folke/twilight.nvim",
        cmd = "Twilight",
        keys = {
            { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
        },
        opts = {
            dimming = { alpha = 0.25 },
            context = 10,
            expand = {
                "function",
                "method",
                "paragraph",
            },
        },
    },

    -- Pencil - optimierte Einstellungen für Prosa
    {
        "preservim/vim-pencil",
        ft = { "markdown", "text", "tex" },
        init = function()
            vim.g["pencil#wrapModeDefault"] = "soft"
            vim.g["pencil#autoformat"] = 1
        end,
    },

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
        },
    },
}
