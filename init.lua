vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46/'
vim.g.mapleader = ' '
vim.opt.relativenumber = true
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require 'configs.lazy'

-- load plugins
require('lazy').setup({
  {
    'NvChad/NvChad',
    lazy = false,
    branch = 'v2.5',
    import = 'nvchad.plugins',
  },

  { import = 'plugins' },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')

require 'options'
require 'nvchad.autocmds'
-- require("git-conflict").setup {
--     default_mappings = {
--         ours = "o",
--         theirs = "t",
--         none = "0",
--         both = "b",
--         next = "n",
--         prev = "p",
--     },
-- }

vim.schedule(function()
  require 'mappings'
end)

require('Comment').setup {
  pre_hook = function(ctx)
    -- Use `ts_context_commentstring` to automatically detect and set correct comment types in JSX/TSX
    if vim.bo.filetype == 'typescriptreact' or vim.bo.filetype == 'javascriptreact' then
      local U = require 'Comment.utils'
      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
      -- Use the correct commentstring based on the location in the file
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end
      return require('ts_context_commentstring.internal').calculate_commentstring {
        key = type,
        location = location,
      }
    end
  end,
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'javascript', 'typescript', 'tsx', 'go', 'java', 'python' },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!node_modules/*',
      '--glob=!venv/*',
    },
  },
}

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ['html'] = {
      enable_close = false,
    },
  },
})
--
-- -- See `:help vim.lsp.start` for an overview of the supported `config` options.
-- local config = {
--   name = 'jdtls',
--
--   -- `cmd` defines the executable to launch eclipse.jdt.ls.
--   -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
--   --
--   -- As alternative you could also avoid the `jdtls` wrapper and launch
--   -- eclipse.jdt.ls via the `java` executable
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = { 'jdtls' },
--
--   -- `root_dir` must point to the root of your project.
--   -- See `:help vim.fs.root`
--   root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),
--
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {},
--   },
--
--   -- This sets the `initializationOptions` sent to the language server
--   -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
--   -- you'll need to set the `bundles`
--   --
--   -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = {},
--   },
-- }
-- require('jdtls').start_or_attach(config)
