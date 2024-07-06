-- additional_plugins/init.lua

local M = {}

-- Function to load all plugin files from the directory
local function load_plugins_from_dir(directory)
    local plugin_files = vim.fn.globpath(directory, "*.lua", true, true)
    local plugins = {}

    for _, file in ipairs(plugin_files) do
        if file ~= directory .. '/init.lua' then
            local plugin_config = dofile(file)
            for _, plugin in ipairs(plugin_config) do
                table.insert(plugins, plugin)
            end
        end
    end

    return plugins
end

print(vim.fn.stdpath('config') .. '/lua/plugins/extra')

-- Load additional plugins from the `additional_plugins` folder
M.plugins = load_plugins_from_dir(vim.fn.stdpath('config') .. '/lua/plugins/extra')

return M
