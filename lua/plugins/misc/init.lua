local plugins = {
    { 'wakatime/vim-wakatime', lazy = false },
    { "nvim-lua/plenary.nvim" },
    {
        "dapt4/vim-autoSurround",
        lazy = false,
    },
    { "sonjiku/yawnc.nvim" },
    {
        "ThePrimeagen/harpoon",
        enabled = true,
        lazy = false,
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        keys = function(_, opts)
            require('plugins.configs.harpoon').setupmapping(opts)
        end,
        opts = function(_, opts)
            if opts == nil then
                opts = {}
            else
                opts.global_settings = {
                    save_on_toggle = true,
                    save_on_change = true,
                    enter_on_sendcmd = false,
                    tmux_autoclose_windows = false,
                    excluded_filetypes = { "harpoon", "alpha", "dashboard", "NvimTree", "telescope" },
                    mark_branch = false,
                }
                return opts
            end
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "rmagatti/auto-session",
        config = function()
            local auto_session = require("auto-session")

            auto_session.setup({
                auto_restore_enabled = true,
                auto_session_suppress_dirs = { "~/", "~/Downloads/" }
            })
            local keymap = vim.keymap
            keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
            keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for cwd" })
        end,
        lazy = false
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
        'github/copilot.vim',
        -- Should start copilot on startup
        event = 'InsertEnter',
        config = function() vim.cmd "source ~/.config/nvim/init.lua" end,
    },

    -- load luasnips + cmp related in insert mode only
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "textchanged,textchangedi" },
        config = function()
            require("plugins.configs.others").luasnip()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
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
                'rafamadriz/friendly-snippets',
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
        config = function()
            local conform = require('conform')
            conform.setup({
                formatters_by_ft = {
                    javascript = {
                        "prettier"
                    },
                    typescript = { 'prettier' },
                    javascriptreact = { 'prettier' },
                    typescriptreact = { 'prettier' },
                    json = { 'prettier' },
                    css = { 'prettier' },
                    lua = { 'stylua' },
                    python = { "isort", "black" }
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500
                }
            })
            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
                conform.format({
                    lsp_fallback = true,
                    async = true,
                    timeout_ms = 500
                })
            end, { desc = "format file or range" })
        end,
    },
}

return {
    plugins = plugins
}
