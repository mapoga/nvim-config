require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--
-- Custom
local wk = require "which-key"

-- Git
wk.add {
    { "<leader>gg", "<cmd>Git<CR>", desc = "git status", icon = { icon = "󰊢", color = "orange" } },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "git commit", icon = { icon = "󰊢", color = "orange" } },
}
