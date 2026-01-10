return {
    -- DAP - Debug Adapter Protocol
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        dependencies = {
            -- DAP UI
            {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    "MunifTanjim/nui.nvim",
                    "nvim-neotest/nvim-nio",
                },
            },
            -- Virtual text während Debugging
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- DAP UI Setup
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        position = "left",
                        size = 40,
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        position = "bottom",
                        size = 10,
                    },
                },
            })

            -- Virtual text
            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            -- Automatisch UI öffnen/schließen
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Breakpoint Zeichen
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

            ------------------------------------------------------------------
            -- Debug Adapter Konfigurationen
            -- Hinweis: Adapter müssen über Nix installiert werden!
            ------------------------------------------------------------------

            -- LLDB (Rust, C, C++)
            -- Nix: pkgs.lldb oder pkgs.vscode-extensions.vadimcn.vscode-lldb
            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-dap", -- oder lldb-vscode auf älteren Versionen
                name = "lldb",
            }

            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
            }

            dap.configurations.c = dap.configurations.rust
            dap.configurations.cpp = dap.configurations.rust

            -- Delve (Go)
            -- Nix: pkgs.delve
            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                },
                {
                    type = "delve",
                    name = "Debug Package",
                    request = "launch",
                    program = "${workspaceFolder}",
                },
                {
                    type = "delve",
                    name = "Debug Test",
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                },
            }

            -- Python (debugpy)
            -- Nix: pkgs.python3Packages.debugpy
            dap.adapters.python = {
                type = "executable",
                command = "python",
                args = { "-m", "debugpy.adapter" },
            }

            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        -- Versuche venv zu finden, sonst system python
                        local venv = os.getenv("VIRTUAL_ENV")
                        if venv then
                            return venv .. "/bin/python"
                        end
                        return "python3"
                    end,
                },
            }

            -- Node.js
            -- Nix: pkgs.nodejs (enthält node inspect)
            dap.adapters.node2 = {
                type = "executable",
                command = "node",
                args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/nodeDebug.js" },
            }

            -- Fallback: node --inspect
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = {
                        vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/src/dapDebugServer.js",
                        "${port}",
                    },
                },
            }

            dap.configurations.javascript = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
            }

            dap.configurations.typescript = dap.configurations.javascript

            ------------------------------------------------------------------
            -- Keymaps
            ------------------------------------------------------------------
            local map = vim.keymap.set

            -- Breakpoints
            map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
            map("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Condition: "))
            end, { desc = "DAP: Conditional breakpoint" })
            map("n", "<leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
            end, { desc = "DAP: Log point" })

            -- Debugging steuern
            map("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
            map("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
            map("n", "<leader>do", dap.step_over, { desc = "DAP: Step over" })
            map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step out" })
            map("n", "<leader>dr", dap.restart, { desc = "DAP: Restart" })
            map("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate" })

            -- UI
            map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
            map("n", "<leader>de", dapui.eval, { desc = "DAP: Eval" })
            map("v", "<leader>de", dapui.eval, { desc = "DAP: Eval selection" })

            -- REPL
            map("n", "<leader>dR", dap.repl.toggle, { desc = "DAP: Toggle REPL" })

            -- Zum letzten Breakpoint springen
            map("n", "<leader>dL", dap.run_last, { desc = "DAP: Run last" })

            -- F-Tasten (klassisches Debugging)
            map("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
            map("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
            map("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
            map("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
        end,
    },
}
