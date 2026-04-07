require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local wk = require "which-key"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--
-- Which-Key ------------------------------------------------------------------
-- Clear NvChad mappings
vim.keymap.del("n", "<leader>wk") -- whichkey query lookup
vim.keymap.del("n", "<leader>wK") -- whichkey all keymaps

--
-- NvimTree -------------------------------------------------------------------
-- Clear NvChad mappings
vim.keymap.del("n", "<C-n>") -- Toggle nvimtree
vim.keymap.del("n", "<leader>e") -- Toggle nvimtree
wk.add {
    {
        "<leader>e",
        "<cmd>NvimTreeToggle<CR>",
        { desc = "nvimtree toggle window" },
    },
}

--
-- Toggle ---------------------------------------------------------------------
wk.add {
    { "<leader>t", group = "Toggle" },
    -- Formatting
    {
        "<leader>tf",
        "<cmd>FormatToggle<CR>",
        desc = "Toggle Format-on-save",
        icon = { icon = "", color = "yellow" },
    },
    -- Line Number
    { "<leader>tl", "<cmd>set nu!<CR>", desc = "Toggle Line number" },
    { "<leader>tr", "<cmd>set rnu!<CR>", desc = "Toggle Relative number" },
    -- NvChad
    { "<leader>tc", "<cmd>NvCheatsheet<CR>", desc = "Toggle Cheatsheet (NvChad)" },
}
-- Clear NvChad mappings
vim.keymap.del("n", "<leader>th") -- Themes (NvChad)
vim.keymap.del("n", "<leader>n") -- Line Number
vim.keymap.del("n", "<leader>rn") -- Relative Number
vim.keymap.del("n", "<leader>ch") -- Cheatsheet (NvChad)

--
-- Terimals -------------------------------------------------------------------
map({ "n", "t" }, "<leader>vt", function()
    require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Vertical Terminal Toggle" })

map({ "n", "t" }, "<leader>ht", function()
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Horizontal Term Toggle" })

map({ "n", "t" }, "<leader>tt", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Term Toggle" })
-- Clear NvChad mappings
vim.keymap.del({ "n" }, "<leader>v") -- Vert Term
vim.keymap.del({ "n" }, "<leader>h") -- Hori Term
vim.keymap.del({ "n", "t" }, "<A-v>") -- Hidden Vert Term
vim.keymap.del({ "n", "t" }, "<A-h>") -- Hidden Hori Term
vim.keymap.del({ "n", "t" }, "<A-i>") -- Hidden Float Term

-- Rez ------------------------------------------------------------------------
map({ "n", "t" }, "<leader>pb", require("configs.rez").rez_build, { desc = "Package Build (rez)" })

--
-- Windows --------------------------------------------------------------------
wk.add {
    { "<C-w>h", "<cmd>split<CR>", desc = "Split window horizontally" },
}

--
-- Find -----------------------------------------------------------------------
wk.add {
    { "<leader>f", group = "Find" },
    -- Files
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find Old" },
    { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find All files" },
    { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find Grep" },
    -- Current Buffer
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search" },
    -- Git
    { "<leader>fg", "<cmd>Telescope git_status<CR>", desc = "Find Git Files" },
    -- Vim
    { "<leader>fk", "<cmd>Telescope marks<CR>", desc = "Find Marks" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
    { "<leader>ft", "<cmd>Telescope terms<CR>", desc = "Find Terminal" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help" },
    {
        "<leader>fs",
        function()
            require("nvchad.themes").open()
        end,
        desc = "Find Style",
    },
}
-- Clear NvChad mappings
vim.keymap.del("n", "<leader>pt") -- Pick Term
vim.keymap.del("n", "<leader>gt") -- Git Status
vim.keymap.del("n", "<leader>cm") -- Git Commits
vim.keymap.del("n", "<leader>ma") -- Pick Marks

--
-- Git ------------------------------------------------------------------------
wk.add {
    { "<leader>g", group = "Git" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
}

--
-- Tmux Navigation ------------------------------------------------------------
wk.add {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "window left" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "window right" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "window down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "window up" },
}

--
-- Formatting -----------------------------------------------------------------
wk.add {
    { "<leader>fm", group = "Format" },
    {
        "<leader>fmf",
        function()
            require("conform").format { lsp_fallback = true }
        end,
        desc = "Format File",
        icon = { icon = " ", color = "cyan" },
    },
    {
        "<leader>fmd",
        '<cmd>args ./**/*.py | argdo execute "normal gg" | update<CR>',
        desc = "Format Directory (Python)",
        icon = { icon = " ", color = "cyan" },
    },
}
-- Clear NvChad mappings
vim.keymap.del("n", "<leader>fm")

--
-- Work Directory -------------------------------------------------------------
wk.add {
    { "<leader>fd", group = "Directory" },
    {
        "<leader>fdr",
        function()
            require("configs/cwd_switcher").glob_picker("/Y/rez/packages/", "*/*/*", {
                prompt_title = "Find Rez Package",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Find Rez",
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
        "<leader>fdt",
        function()
            require("configs/cwd_switcher").glob_picker("~/Documents/", "test*", {
                prompt_title = "Find Tests",
                layout_config = { width = 0.3, height = 0.4, prompt_position = "top" },
            })
        end,
        desc = "Find Test",
    },
}

--
-- Play -----------------------------------------------------------------------
wk.add {
    { "<leader>p", group = "Play" },
}
