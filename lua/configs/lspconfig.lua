-- load defaults i.e lua_lsp
require('nvchad.configs.lspconfig').defaults()

local lspconfig = require 'lspconfig'
local utils = require 'lspconfig.util'

local servers = {
  'html',
  'cssls',
  'pylsp',
  'ruff',
  'ts_ls', -- fixed name
  'gopls',
  'rust_analyzer',
  'tailwindcss',
  'phpactor',
  'clangd',
  -- 'jdtls ',
}
local nvlsp = require 'nvchad.configs.lspconfig'

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- pyright (custom config)
lspconfig.pyright.setup {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' },
      },
    },
  },
}

-- gopls (custom config)
lspconfig.gopls.setup {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = utils.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
