require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--
-- Custom
local wk = require "which-key"

-- Tmux Navigation
wk.add {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "window left" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "window right" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "window down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "window up" },
}

-- Formatting
wk.add {
    {
        "<leader>fp",
        '<cmd>args ./**/*.py | argdo execute "normal gg" | write<CR>',
        desc = "Format CWD python files",
        -- icon = { icon = "󰊢", color = "orange" },
    },
}

-- Git
wk.add {
    { "<leader>gg", "<cmd>Git<CR>", desc = "git status", icon = { icon = "󰊢", color = "orange" } },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "git commit", icon = { icon = "󰊢", color = "orange" } },
}

-- Custom work directory finder
wk.add {
    { "<leader>fd", group = "Directory" },
    {
        "<leader>fdr",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/", "*/*/*", {
                prompt_title = "Find Released Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Telescope find released package",
    },
    {
        "<leader>fdy",
        function()
            require("configs/cwd_switcher").glob_picker("~/Documents/python_packages/", "*/*", {
                prompt_title = "Find Python Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Telescope find python package",
    },
    {
        "<leader>fdw",
        function()
            require("configs/cwd_switcher").glob_picker("~/Documents/rez_packages/", "*", {
                prompt_title = "Find Work Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Telescope find project",
    },
    {
        "<leader>fdp",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/publish_type/", "*/*", {
                prompt_title = "Find Rez Publish Type",
                layout_config = { width = 0.4, height = 0.8, prompt_position = "top" },
            })
        end,
        desc = "Telescope find rez Publish Type",
    },
    {
        "<leader>fdt",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/tools/", "*/*", {
                prompt_title = "Find Rez Tool",
                layout_config = { width = 0.4, height = 0.8, prompt_position = "top" },
            })
        end,
        desc = "Telescope find rez tool",
    },
}
