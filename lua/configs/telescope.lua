local actions = require "telescope.actions"

-- Open the selected files. Fallback to default file if nothing is selected.
local open_selected_or_default = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        actions.close(prompt_bufnr)
        for _, j in pairs(multi) do
            if j.path ~= nil then
                vim.cmd(string.format("%s %s", "edit", j.path))
            end
        end
    else
        actions.select_default(prompt_bufnr)
    end
end

-- Open the selected files. Fallback to all files if nothing is selected.
local open_selected_or_all = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    actions.close(prompt_bufnr)
    if not vim.tbl_isempty(multi) then
        for _, j in pairs(multi) do
            if j.path ~= nil then
                vim.cmd(string.format("%s %s", "edit", j.path))
            end
        end
    else
        for entry in picker.manager:iter() do
            if entry.path ~= nil then
                print(entry.path)
                vim.cmd(string.format("%s %s", "edit", entry.path))
            end
        end
    end
end

-- Send the selected files to the quickfix list.
-- Fallback to sending all files if nothing is selected.
local send_selected_or_all_to_qflist = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist(prompt_bufnr)
    else
        actions.send_to_qflist(prompt_bufnr)
        actions.open_qflist(prompt_bufnr)
    end
end

-- Based of NVChad config
return {
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = open_selected_or_default, -- New
                ["<C-o>"] = open_selected_or_all, -- New
                ["<C-q>"] = send_selected_or_all_to_qflist, -- New
            },
            n = {
                ["<CR>"] = open_selected_or_default, -- New
                ["<C-o>"] = open_selected_or_all, -- New
                ["<C-q>"] = send_selected_or_all_to_qflist, -- New
                ["q"] = require("telescope.actions").close,
            },
        },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
        },
    },
    pickers = {
        git_status = {
            mappings = {
                i = { ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse }, -- New
                n = { ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse }, -- New
            },
        },
    },

    extensions_list = { "themes", "terms" },
    extensions = {},
}
