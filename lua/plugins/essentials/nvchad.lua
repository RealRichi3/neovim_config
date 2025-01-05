local config = {

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
}

return config
