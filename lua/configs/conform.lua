local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- python = { "isort", "black" },
        python = { "ruff_fix", "ruff_format" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "fixjson" },
        YAML = { "yamlfix" },
    },

    formatters = {
        -- python
        black = {
            prepend_args = {
                "--fast",
                -- "--line-length",
                -- "80",
            },
        },
        isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
