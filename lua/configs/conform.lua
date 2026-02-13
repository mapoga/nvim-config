local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "fixjson" },
        YAML = { "yamlfix" },
        XML = { "xmlformatter" },
    },

    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        -- Options
        return { timeout_ms = 500, lsp_fallback = true }
    end,
}

--
-- Custom commands to Enable/Disable format_on_save
--
-- FomatToggle
vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
    else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
    end
end, {
    desc = "Toggle autoformat-on-save",
    bang = true,
})

-- FormatDisable
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

-- FormatEnable
vim.api.nvim_create_user_command("FormatEnable", function(args)
    if args.bang then
        -- FormatEnable! will disable formatting just for this buffer
        vim.b.disable_autoformat = false
    else
        vim.g.disable_autoformat = false
    end
end, {
    desc = "Enable autoformat-on-save",
    bang = true,
})

require("conform").setup(options)
