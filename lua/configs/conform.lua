local options = {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'ruff', 'isort', 'black' },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { 'rustfmt', lsp_format = 'fallback' },
    -- Conform will run the first available formatter
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    php = { { 'pint', 'php_cs_fixer' } },
    c = { 'clang-format' },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    async = true,
    timeout_ms = 3000,
    lsp_fallback = true,
  },

  formatters = {
    isort = {
      command = 'isort',
      args = {
        '-',
      },
    },
    black = {
      prepend_args = { '--fast' },
    },
  },
}

return options
