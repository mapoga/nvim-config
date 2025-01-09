return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require "configs.conform"
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require "configs.mason-conform"
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            require "configs.lint"
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        configs = function()
            require "configs.mason-lint"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            require "configs/treesitter"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require "configs.mason-lspconfig"
        end,
    },

    {
        "danymat/neogen",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter" },
        config = function()
            require "configs.neogen"
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                TODO = {
                    alt = { "Todo", "todo" },
                },
            },
        },
    },

    {
        "tpope/vim-fugitive",
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
        lazy = false,
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup {
                settings = {
                    search = {
                        my_venvs = {
                            command = "$FD python$ $CWD/.venv/bin",
                        },
                    },
                },
            }
        end,
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        config = function()
            require "configs.gitsigns"
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        -- Custom config on top of defaults
        opts = {
            view = { adaptive_size = true },
        },
    },
}
