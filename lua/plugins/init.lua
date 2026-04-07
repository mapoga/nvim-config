return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    {
        "vladdoster/remember.nvim",
        lazy = false,
        config = function()
            require "remember"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            return require "configs.telescope"
        end,
    },

    -- Add a new rule for "play".
    -- whichi-key is already loaded by NvChad.
    {
        "folke/which-key.nvim",
        opts = {
            icons = {
                rules = {
                    { pattern = "play", icon = "󰊗", color = "yellow" },
                    { pattern = "pick", icon = "", color = "blue" },
                    { pattern = "git", icon = "󰊢", color = "orange" },
                },
            },
        },
    },

    {
        "mg979/vim-visual-multi",
        branch = "master",
        keys = {
            { "\\\\" }, -- Load the plugin using the plugin's prefix "\\"
        },
    },

    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup {
                max_join_length = 80,
            }
        end,
        keys = { "<space>m", "<space>j", "<space>s" },
    },

    {
        "stevearc/conform.nvim",
        config = function()
            require "configs.conform"
        end,
        event = "BufWritePre",
    },

    {
        "zapling/mason-conform.nvim",
        dependencies = { "conform.nvim" },
        config = function()
            require "configs.mason-conform"
        end,
        event = "VeryLazy",
    },

    {
        "mfussenegger/nvim-lint",
        config = function()
            require "configs.lint"
        end,
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    },

    {
        "rshkarin/mason-nvim-lint",
        dependencies = { "nvim-lint" },
        config = function()
            require "configs.mason-lint"
        end,
        event = "VeryLazy",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require "configs/treesitter"
        end,
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require "configs/nvim-treesitter-textobjects"

            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end,
        lazy = true,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require "configs.mason-lspconfig"
        end,
        event = "VeryLazy",
    },

    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter" },
        config = function()
            require "configs.neogen"
        end,
        event = "VeryLazy",
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                TODO = {
                    alt = { "Todo", "todo" },
                },
            },
        },
        event = "VeryLazy",
    },

    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup {
                settings = {
                    search = {
                        user = {
                            command = "$FD -HI -p '.venv/bin/python$' ~/Documents/venvs/",
                        },
                        project = {
                            command = "$FD python$ $CWD/.venv/bin",
                        },
                    },
                },
            }
        end,
        lazy = false,
        keys = {
            { "<leader>fv", "<cmd>VenvSelect<cr>", desc = "Find Venv (Python)" },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "configs.gitsigns"
        end,
        event = "User FilePost",
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
        event = "VeryLazy",
    },

    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require "configs.nvim-tree"
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            { "<leader>gl", "<cmd>LazyGit<cr>", desc = "Git Lazygit" },
        },
    },

    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>ps", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Play Sand" },
        },
    },
}
