-- all plugins have lazy=true by demault,to load a plugin on startup just lazy=false
-- list of all default plugins & their definitions
local default_plugins = {
}
local essential_plugins = require('plugins.essentials').plugins
local misc_plugins = require('plugins.misc').plugins


local config = require("core.utils").load_config()

 if #config.plugins > 0 then
     table.insert(default_plugins, { import = config.plugins })
 end

local function add_plugins(plugins)
    for _, plugin in ipairs(plugins) do
        table.insert(default_plugins, plugin)
    end
end

add_plugins(misc_plugins)
add_plugins(essential_plugins)
-- add_plugins(default_plugins)

require("lazy").setup(default_plugins, config.lazy_nvim)
