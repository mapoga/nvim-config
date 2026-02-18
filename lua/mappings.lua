require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--
-- Custom
local wk = require "which-key"

-- Windows
wk.add {
    { "<C-w>h", "<cmd>split<CR>", desc = "Split window horizontally" },
}

-- Telescope Changed Files
wk.add {
    { "<leader>fg", "<cmd>Telescope git_status<CR>", desc = "telescope git status" },
}

-- Tmux Navigation
wk.add {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "window left" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "window right" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "window down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "window up" },
}

-- Gimmicks
wk.add {
    {
        "<leader>pr",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Falling Sand",
        icon = { icon = "󰊗", color = "yellow" },
    },
    {
        "<leader>ps",
        "<cmd>SnakeStart<CR>",
        desc = "Snake Game",
        icon = { icon = "󰊗", color = "yellow" },
    },
}

-- Formatting
wk.add {
    {
        "<leader>fp",
        '<cmd>args ./**/*.py | argdo execute "normal gg" | write<CR>',
        desc = "Format CWD python files",
        -- icon = { icon = "󰊢", color = "orange" },
    },
    {
        "<leader>ft",
        "<cmd>FormatToggle<CR>",
        desc = "Toggle Format-On-Save",
        icon = { icon = "", color = "yellow" },
    },
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
        desc = "Find Released",
    },
    {
        "<leader>fdy",
        function()
            require("configs/cwd_switcher").glob_picker("~/Documents/python_packages/", "*/*", {
                prompt_title = "Find Python Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Find Python",
    },
    {
        "<leader>fdw",
        function()
            require("configs/cwd_switcher").glob_picker("~/Documents/rez_packages/", "*", {
                prompt_title = "Find Work Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Find Work",
    },
    {
        "<leader>fdp",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/publish_type/", "*/*", {
                prompt_title = "Find Rez Publish Type",
                layout_config = { width = 0.4, height = 0.8, prompt_position = "top" },
            })
        end,
        desc = "Find PublishType",
    },
    {
        "<leader>fdt",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/tools/", "*/*", {
                prompt_title = "Find Rez Tool",
                layout_config = { width = 0.4, height = 0.8, prompt_position = "top" },
            })
        end,
        desc = "Find Tool",
    },
}
