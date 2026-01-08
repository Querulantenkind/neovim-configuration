return {
    {
        "shaunsingh/nord.nvim",
        priority = 1000,
        config = function()
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_italic = true
            vim.g.nord_bold = true
            require("nord").set()
        end,
    },
}
