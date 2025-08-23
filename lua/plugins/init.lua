return {
  {
    'stevearc/conform.nvim',
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require 'configs.conform',
  },
  {
    'tpope/vim-fugitive', -- Add this line for vim-fugitive
    event = 'VeryLazy',   -- Optionally load this lazily, e.g., when Vim is idle
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- show fold column
      vim.o.foldlevel = 99   -- start unfolded
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup()
    end,
  },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },
  {
    'Djancyp/better-comments.nvim',
    config = function()
      require('better-comment').setup()
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false, -- disables the breadcrumb in the winbar
        },
        ui = {
          -- Define how the saga icons should look
          theme = 'round',
          -- Customize border for floating windows
          border = 'rounded',
          -- Show lines for hover window
          winblend = 0,
          expand = '',
          collapse = '',
        },

        code_action = {
          enable = true,
          keys = {
            -- Mapping to trigger code actions
            quit = 'q',
            exec = '<CR>', -- Enter key to execute the action
          },
        },
        rename = {
          enable = true,
          keys = {
            quit = '<Esc>', -- Mapping to exit the rename prompt
            exec = '<CR>',  -- Enter key to apply the rename
          },
        },
        diagnostic = {
          enable = true,
          keys = {
            -- Mapping to jump to next/prev diagnostic
            next = 'n',
            prev = 'p',
          },
        },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
    opts = {
      default_mappings = true,     -- disable buffer local mapping created by this plugin
      default_commands = true,     -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen',       -- command or function to open the conflicts list
      highlights = {               -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'configs.lspconfig'
    end,
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { 'markdown' },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  }, --nice scrolling animation
  -- {
  --   'folke/snacks.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   ---@type snacks.Config
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = true },
  --     explorer = { enabled = true },
  --     indent = { enabled = true },
  --     input = { enabled = true },
  --     picker = { enabled = true },
  --     notifier = { enabled = true },
  --     quickfile = { enabled = true },
  --     scope = { enabled = true },
  --     scroll = { enabled = true },
  --     statuscolumn = { enabled = true },
  --     words = { enabled = true },
  --   },
  -- },
  {
    'windwp/nvim-ts-autotag',
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = function()
        -- Update this path
        local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb'
        local this_os = vim.uv.os_uname().sysname;

        -- The path is different on Windows
        if this_os:find "Windows" then
          codelldb_path = extension_path .. "adapter\\codelldb.exe"
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        else
          -- The liblldb extension is .so for Linux and .dylib for MacOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end

        local cfg = require('rustaceanvim.config')
        return {
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      end
    end
  },

  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
  },

  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function()
      require('crates').setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require('cmp').setup.buffer {
        sources = { { name = 'crates' } },
      }
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- install without yarn or npm
  -- {
  --     "iamcco/markdown-preview.nvim",
  --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --     ft = { "markdown" },
  --     build = function()
  --         vim.fn["mkdp#util#install"]()
  --     end,
  -- },

  -- install with yarn or npm,
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "gopls",
        "gofmt",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "astro-language-server",
        "intelephense",
        "emmet_language_server",
        "gofumpt",
        "golines",
        "black",
        "mypy",
        "taplo",
        "htmlbeautifier",
        'gopls',
        'pyright',
        'clangd',
      },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      vim.g.mkdp_auto_start = 1     -- Automatically start preview on file open
      vim.g.mkdp_auto_close = 1     -- Automatically close preview on leaving buffer
      vim.g.mkdp_refresh_slow = 1   -- Refresh preview slower for large files
      vim.g.mkdp_port = '8080'      -- Set a fixed port for the preview
      vim.g.mkdp_browser = 'chrome' -- Set the browser to Chrome

      -- Function to open a new Chrome window
      vim.g.mkdp_browserfunc = 'MkdpOpenChrome'

      function MkdpOpenChrome(url)
        local cmd = 'chrome --new-window ' .. url
        vim.fn.jobstart(cmd, { detach = true })
      end
    end,
    ft = { 'markdown' },
  },
}
