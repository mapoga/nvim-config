local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    -- Default mappings are applied by default, but you can explicitly call them if needed
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set("n", "=", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
end

require("nvim-tree").setup {
    on_attach = my_on_attach,

    -- NVCHAD config
    filters = { dotfiles = false },
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        update_root = false,
        enable = false, -- overwrite
    },
    view = {
        width = 30,
        preserve_window_proportions = true,
        adaptive_size = true, -- new
    },
    renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
            glyphs = {
                default = "󰈚",
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                },
                git = { unmerged = "" },
            },
        },
    },
    actions = {
        change_dir = {
            enable = true,
            global = true, -- new
        },
    },
}
