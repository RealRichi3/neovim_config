---@type ChadrcConfig
local M = {}

M.ui = {
    theme = 'aquarium',

    statusline = {
        -- overriden_modules receives the module list by reference and mutates it.
        -- Index map (see nvchad/statusline/default.lua):
        --   1 mode        2 fileInfo   3 git          4 "%="
        --   5 LSP_progress 6 "%="      7 LSP_Diagnostics
        --   8 LSP_status  9 cwd       10 cursor_position
        overriden_modules = function(modules)
            modules[9] = ""  -- 󰉋 folder name
            modules[10] = "" -- Top / Bot / NN%
        end,
    },
}

return M
