function ColorMyPencils(color)
    -- color = "gruvbox-material"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    -- {
    --     "sainnhe/gruvbox-material",
    --     -- lazy = false,
    --     priority = 1000,
    --     -- event = { 'InsertEnter', 'VeryLazy' },
    --     config = function()
    --         vim.g.gruvbox_material_background = 'hard'
    --         vim.g.gruvbox_material_better_performance = 1
    --         vim.g.gruvbox_material_enable_italic = 0
    --         vim.g.gruvbox_material_enable_bold = 1
    --         vim.g.gruvbox_material_transparent_background = 0 -- Disable transparent background
    --         vim.g.gruvbox_material_disable_italic_comment = 0
    --         vim.g.gruvbox_material_enable_undercurl = 1
    --         vim.g.gruvbox_material_visual = 'grey background'
    --         vim.g.gruvbox_material_menu_selection_background = 'grey'
    --         vim.g.gruvbox_material_sign_column_background = 'none'
    --         vim.g.gruvbox_material_statusline_style = 'default'
    --         vim.g.gruvbox_material_diagnostic_text_highlight = 1
    --         vim.g.gruvbox_material_diagnostic_line_highlight = 1
    --         -- vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    --         vim.g.gruvbox_material_dim_inactive_windows = 0 -- Disable dimming inactive windows
    --         vim.g.gruvbox_material_ui_contrast = 'high'     -- Use high contrast UI
    --         -- vim.cmd.colorscheme('gruvbox-material')
    --         -- vim.cmd('colorscheme gruvbox-material')
    --     end,
    -- },
    {
        "vague2k/vague.nvim",
        event = { 'InsertEnter', 'VeryLazy' },
        -- event = 'VeryLazy',
        config = function()
            require("vague").setup({
                transparent = true, -- don't set background
                style = {
                    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
                    boolean = "bold",
                    number = "none",
                    float = "none",
                    error = "bold",
                    comments = "none",
                    conditionals = "none",
                    functions = "none",
                    headings = "bold",
                    operators = "none",
                    strings = "none",
                    variables = "none",

                    -- keywords
                    keywords = "none",
                    keyword_return = "none",
                    keywords_loop = "none",
                    keywords_label = "none",
                    keywords_exception = "none",

                    -- builtin
                    builtin_constants = "bold",
                    builtin_functions = "none",
                    builtin_types = "bold",
                    builtin_variables = "none",
                },
                -- plugin styles where applicable
                -- make an issue/pr if you'd like to see more styling options!
                plugins = {
                    cmp = {
                        match = "bold",
                        match_fuzzy = "bold",
                    },
                    dashboard = {
                        footer = "italic",
                    },
                    lsp = {
                        diagnostic_error = "bold",
                        diagnostic_hint = "none",
                        diagnostic_info = "italic",
                        diagnostic_warn = "bold",
                    },
                    neotest = {
                        focused = "bold",
                        adapter_name = "bold",
                    },
                    telescope = {
                        match = "bold",
                    },
                },
                -- Override colors
                --
                colors = {
                    bg = "#141415",
                    -- fg = "#cdcdcd",
                    fg = "#606079",
                    floatBorder = "#878787",
                    line = "#252530",
                    comment = "#606079",
                    builtin = "#b4d4cf",
                    func = "#c48282",
                    string = "#e8b589",
                    number = "#e0a363",
                    property = "#c3c3d5",
                    constant = "#aeaed1",
                    parameter = "#bb9dbd",
                    visual = "#333738",
                    error = "#df6882",
                    warning = "#f3be7c",
                    hint = "#7e98e8",
                    operator = "#90a0b5",
                    keyword = "#6e94b2",
                    type = "#9bb4bc",
                    search = "#405065",
                    plus = "#8cb66d",
                    delta = "#f3be7c",
                },
            })

            vim.cmd.colorscheme('vague')
        end
    },
    -- { "savq/melange-nvim" },
    -- {
    --     "erikbackman/brightburn.vim",
    -- },
    -- {
    --     "sainnhe/gruvbox-material",
    --     event = "VeryLazy",
    --     -- lazy = false,
    --     -- priority = 1000,
    --     config = function()
    --         -- vim.g.gruvbox_material_background = 'hard'
    --         -- vim.g.gruvbox_material_better_performance = 1
    --         -- vim.g.gruvbox_material_enable_italic = 1
    --         -- vim.g.gruvbox_material_enable_bold = 1
    --         -- vim.g.gruvbox_material_transparent_background = 1
    --         -- vim.g.gruvbox_material_disable_italic_comment = 1
    --         -- vim.g.gruvbox_material_enable_undercurl = 1
    --         -- vim.g.gruvbox_material_visual = 'grey background'
    --         -- vim.g.gruvbox_material_menu_selection_background = 'grey'
    --         -- vim.g.gruvbox_material_sign_column_background = 'none'
    --         -- vim.g.gruvbox_material_statusline_style = 'default'
    --         -- vim.g.gruvbox_material_diagnostic_text_highlight = 1
    --         -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
    --         -- vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    --         vim.cmd('colorscheme gruvbox-material')
    --     end,
    -- },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     opts = {},
    --     config = function()
    --         ColorMyPencils()
    --     end
    -- },
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     name = "gruvbox",
    --     config = function()
    --         require("gruvbox").setup({
    --             terminal_colors = true, -- add neovim terminal colors
    --             undercurl = true,
    --             underline = true,
    --             bold = true,
    --             italic = {
    --                 strings = true,
    --                 emphasis = true,
    --                 comments = true,
    --                 operators = false,
    --                 folds = true,
    --             },
    --             strikethrough = true,
    --             invert_selection = false,
    --             invert_signs = false,
    --             invert_tabline = false,
    --             invert_intend_guides = false,
    --             inverse = true, -- invert background for search, diffs, statuslines and errors
    --             contrast = "",  -- can be "hard", "soft" or empty string
    --             palette_overrides = {},
    --             overrides = {},
    --             dim_inactive = false,
    --             transparent_mode = false,
    --         })
    --     end,
    -- },
    -- {
    --     "folke/tokyonight.nvim",
    --     config = function()
    --         require("tokyonight").setup({
    --             on_colorscheme = function(colors, vim_mode)
    --                 if vim_mode then
    --                     colors.bg_statusline = colors.bg_highlight
    --                     colors.fg_statusline = colors.fg_highlight
    --                 end
    --             end,
    --             on_highlights = function(hl)
    --                 hl.TSFunction = { fg = "#FF007C" }
    --             end,
    --             on_colors = function(colors)
    --                 colors.bg_sidebar = colors.bg_statusline
    --                 colors.bg_float = colors.bg_statusline
    --             end,
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    --             transparent = true,     -- Enable this to disable setting the background color
    --             terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    --             styles = {
    --                 -- Style to be applied to different syntax groups
    --                 -- Value is any valid attr-list value for `:help nvim_set_hl`
    --                 comments = { italic = false },
    --                 keywords = { italic = false },
    --                 -- Background styles. Can be "dark", "transparent" or "normal"
    --                 sidebars = "dark", -- style for sidebars, see below
    --                 floats = "dark",   -- style for floating windows
    --             },
    --         })
    --     end
    -- },

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         require('rose-pine').setup({
    --             disable_background = true,
    --             styles = {
    --                 italic = true,
    --             },
    --         })
    --     end
    -- },

}
