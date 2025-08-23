local options = {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'ruff', 'isort', 'black' },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { 'rustfmt', lsp_format = 'fallback' },
    -- Conform will run the first available formatter
    javascript = { 'prettier', stop_after_first = true },
    typescript = { 'prettier', stop_after_first = true },
    javascriptreact = { 'prettier', stop_after_first = true },
    typescriptreact = { 'prettier', stop_after_first = true },
    json = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    markdown = { 'prettier' },
    yaml = { 'prettier' },
    php = { { 'pint', 'php_cs_fixer' } },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    -- async = true,
    timeout_ms = 3000,
    lsp_fallback = true,
  },

  -- format_after_save = {
  --   lsp_format = 'fallback',
  -- },

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
    prettier = {
      command = 'prettier',
      args = { '--stdin-filepath', '$FILENAME' },
      cwd = require('conform.util').root_file({ '.prettierrc', 'package.json' }),
    },
  },
}

return options
