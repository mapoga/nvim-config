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

    -- Custom config on top of defaults
    view = { adaptive_size = true },
    update_focused_file = { enable = false },
}
