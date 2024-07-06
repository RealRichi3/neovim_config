return {
{
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
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
    event = {   "BufReadPre", "BufNewFile"},
    config = function()
        local options = require ('plugins.configs.nvim_gitsigns')
        dofile(vim.g.base46_cache .. "git")
        require("gitsigns").setup(options.setup)
        -- Setup on attach
        require("gitsigns").on_attach = options.on_attach
        end,
      },
}
