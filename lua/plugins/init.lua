-- all plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- list of all default plugins & their definitions
local default_plugins = {

    "nvim-lua/plenary.nvim",
    {
      "nvchad/base46",
      branch = "v2.0",
      build = function()
        require("base46").load_all_highlights()
      end,
    },
    {
      "nvchad/ui",
      branch = "v2.0",
      lazy = false,
    },
    {
      "nvchad/nvterm",
      init = function()
        require("core.utils").load_mappings "nvterm"
      end,
      config = function(_, opts)
        require "base46.term"
        require("nvterm").setup(opts)
      end,
    },
    {
      "nvchad/nvim-colorizer.lua",
      init = function()
        require("core.utils").lazy_load "nvim-colorizer.lua"
      end,
      config = function(_, opts)
        require("colorizer").setup(opts)
        -- execute colorizer as soon as possible
        vim.defer_fn(function()
          require("colorizer").attach_to_buffer(0)
        end, 0)
      end,
    },
    {
      "nvim-tree/nvim-web-devicons",
      opts = function()
        return { override = require "nvchad.icons.devicons" }
      end,
      config = function(_, opts)
        dofile(vim.g.base46_cache .. "devicons")
        require("nvim-web-devicons").setup(opts)
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      version = "2.20.7",
      init = function()
        require("core.utils").lazy_load "indent-blankline.nvim"
      end,
      opts = function()
        return require("plugins.configs.others").blankline
      end,
      config = function(_, opts)
        require("core.utils").load_mappings "blankline"
        dofile(vim.g.base46_cache .. "blankline")
        require("indent_blankline").setup(opts)
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      init = function()
        require("core.utils").lazy_load "nvim-treesitter"
      end,
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      opts = function()
        return require "plugins.configs.treesitter"
      end,
      config = function(_, opts)
        dofile(vim.g.base46_cache .. "syntax")
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
    { 'github/copilot.vim',
    -- Should start copilot on startup
    event = 'InsertEnter',
    config = function () vim.cmd "source ~/.config/nvim/init.lua" end,
  },
    -- git stuff
    {
      "lewis6991/gitsigns.nvim",
      lazy = false,
    --   cmd = { "Gitsigns", "Gitsigns toggle_signs", "Gitsigns toggle_numhl", "Gitsigns toggle_linehl", "Gitsigns toggle_word_diff" },

      ft = { "gitcommit", "diff" },
      init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitsignsLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -c " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                if vim.v.shell_error == 0 then
              vim.api.nvim_del_augroup_by_name "GitsignsLazyLoad"
              vim.schedule(function()
                require("lazy").load { plugins = { "gitsigns.nvim" } }
              end)
            end
          end,
        })
      end,
      config = function()
        local options = require ('plugins.configs.nvim_gitsigns')
        dofile(vim.g.base46_cache .. "git")
        require("gitsigns").setup(options.setup)
        end,
      },
    -- lsp stuff
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
      opts = function()
        return require "plugins.configs.mason"
      end,
      config = function(_, opts)
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup(opts)

        dofile(vim.g.base46_cache .. "mason")
        require("mason").setup(opts)
        -- custom nvchad cmd to install all mason binaries listed
        vim.api.nvim_create_user_command("MasonInstallAll", function()
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end, {})
        vim.g.mason_binaries_list = opts.ensure_installed
      end,
    },
    {
      "neovim/nvim-lspconfig",
      init = function()
        require("core.utils").lazy_load "nvim-lspconfig"
      end,
      config = function()
        require "plugins.configs.lspconfig"
      end,
    },
    -- load luasnips + cmp related in insert mode only
    {
      "hrsh7th/nvim-cmp",
     event = "InsertEnter",
      dependencies = {
        {
          -- snippet plugin
          "l3mon4d3/luasnip",
          dependencies = "rafamadriz/friendly-snippets",
          opts = { history = true, updateevents = "textchanged,textchangedi" },
          config = function(_, opts)
            require("plugins.configs.others").luasnip(opts)
          end,
        },
        -- autopairing of (){}[] etc
        {
          "windwp/nvim-autopairs",
          opts = {
            fast_wrap = {},
            disable_filetype = { "telescopeprompt", "vim" },
          },
          config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
          end,
        },
        -- cmp sources plugins
        {
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-nvim-lua",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
        },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "numtostr/comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "comment toggle linewise" },
      { "gc", mode = "x", desc = "comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "comment toggle blockwise" },
      { "gb", mode = "x", desc = "comment toggle blockwise (visual)" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
      require("plugins.configs.comment").config()
    end,
  },

  -- file managing, picker, etc.
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    lazy = false,
    config = function()
      require("plugins.configs.toggleterm")
    end,
  },
  -- only load whichkey after all the GUI
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },
  {
    "stevearc/conform.nvim",
    event = {
      "BufReadPre", "BufNewFile"
     },
    config = function ()
      local conform = require('conform')
      conform.setup({
        formatters_by_ft =  {
          javascript = {
            "prettier"
          },
          typescript = { 'prettier'},
          javascriptreact = { 'prettier'},
          typescriptreact = { 'prettier' },
          json = { 'prettier'},
          css = { 'prettier'},
          lua = { 'stylua'},
          python = {"isort", "black"}
       },
      format_on_save =  {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500
        }
      })
    vim.keymap.set({ "n", "v"}, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 500
      })
    end,{ desc = "format file or range"})
  end,
  },
  }

local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

require("lazy").setup(default_plugins, config.lazy_nvim)
  
