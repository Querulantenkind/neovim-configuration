return {
    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- Integrate with cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- Comments
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = false,
        opts = {},
    },

    -- Better escape
    {
        "max397574/better-escape.nvim",
        lazy = false,
        opts = {
            mapping = { "jk" },
        },
    },

    -- Todo comments
    {
        "folke/todo-comments.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
        },
    },

    -- Trouble (better diagnostics list)
    {
        "folke/trouble.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
        },
        opts = {},
    },
}
