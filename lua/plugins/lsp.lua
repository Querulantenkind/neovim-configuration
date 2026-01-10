return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- LSP Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("gr", vim.lsp.buf.references, "Go to references")
                    map("gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("K", vim.lsp.buf.hover, "Hover documentation")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename")
                    map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
                    map("<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
                    map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
                end,
            })

            -- Capabilities for nvim-cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Server configurations (Neovim 0.11+ vim.lsp.config API)
            local servers = {
                -- Web
                ts_ls = {},
                html = {},
                cssls = {},
                eslint = {},
                -- Systems
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = { command = "clippy" },
                        },
                    },
                },
                gopls = {},
                clangd = {},
                -- Python
                pyright = {},
                ruff = {},
                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
            }

            -- Setup servers using vim.lsp.config (Neovim 0.11+)
            for server, config in pairs(servers) do
                config.capabilities = capabilities
                vim.lsp.config[server] = config
            end
            vim.lsp.enable(vim.tbl_keys(servers))
        end,
    },
}
