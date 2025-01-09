require("gitsigns").setup {
    on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal { "]c", bang = true }
            else
                gitsigns.nav_hunk "next"
            end
        end, { desc = "git nav next hunk" })

        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal { "[c", bang = true }
            else
                gitsigns.nav_hunk "prev"
            end
        end, { desc = "git nav prev hunk" })

        -- Custom
        local wk = require "which-key"
        -- Actions
        wk.add {
            { "<leader>gs", gitsigns.stage_hunk, desc = "git stage hunk", icon = { icon = "󰊢", color = "orange" } },
            { "<leader>gr", gitsigns.reset_hunk, desc = "git reset hunk", icon = { icon = "󰊢", color = "orange" } },
            {
                "<leader>gs",
                function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end,
                desc = "git stage hunk",
                mode = "v",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gr",
                function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end,
                desc = "git reset hunk",
                mode = "v",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gS",
                gitsigns.stage_buffer,
                desc = "git stage buffer",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gu",
                gitsigns.undo_stage_hunk,
                desc = "git undo stage hunk",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gR",
                gitsigns.reset_buffer,
                desc = "git reset buffer",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gp",
                gitsigns.preview_hunk,
                desc = "git preview hunk",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>gb",
                function()
                    gitsigns.blame_line { full = true }
                end,
                desc = "git blame line",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>tb",
                gitsigns.toggle_current_line_blame,
                desc = "git toggle current line blame",
                icon = { icon = "󰊢", color = "orange" },
            },
            { "<leader>gd", gitsigns.diffthis, desc = "git diff this", icon = { icon = "󰊢", color = "orange" } },
            {
                "<leader>gD",
                function()
                    gitsigns.diffthis "~"
                end,
                desc = "git diff this ~",
                icon = { icon = "󰊢", color = "orange" },
            },
            {
                "<leader>td",
                gitsigns.toggle_deleted,
                desc = "git toggle deleted",
                icon = { icon = "󰊢", color = "orange" },
            },
            -- Text object
            { "ih", mode = { "o", "x" }, ":<C-U>Gitsigns select_hunk<CR>", icon = { icon = "󰊢", color = "orange" } },
        }
    end,
}
