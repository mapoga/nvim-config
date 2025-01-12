local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local plen_path = require "plenary.path"

local cwd_switcher = {}

local directories_glob_finder = function(root, expr)
    local abs_root = plen_path:new(root):expand()
    local paths = vim.split(vim.fn.glob(abs_root .. expr), "\n")

    local entries = {}
    for i, path in pairs(paths) do
        if plen_path:new(path):is_dir() then
            local rel_path = plen_path:new(path):make_relative(abs_root)
            table.insert(entries, { rel_path, path })
        end
    end
    return entries
end

function cwd_switcher.glob_picker(root, expr, opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "Find Working Directories",
            finder = finders.new_table {
                results = directories_glob_finder(root, expr),
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry[1],
                        ordinal = entry[1],
                        path = entry[2],
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.fn.chdir(selection["path"])
                end)
                return true
            end,
        })
        :find()
end

return cwd_switcher
