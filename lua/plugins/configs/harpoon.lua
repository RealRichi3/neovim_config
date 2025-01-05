local function setupmapping(opts)
    local harpoon = require("harpoon")
    harpoon.setup(opts)
    local conf = require('telescope.config').values

    local function toogle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end
        require("telescope.pickers").new({}, {
            prompt_title = "harpoon files",
            finder = require("telescope.finders").new_table {
                results = file_paths,
            },
            sorter = conf.generic_sorter(),
            previewer = conf.file_previewer({}),
        }):find()
    end

    return {
        { "<a-1>",      function() harpoon:list():select(1) end,                     desc = "harpoon  buffer 1" },
        { "<a-2>",      function() harpoon:list():select(2) end,                     desc = "harpoon  buffer 2" },
        { "<a-3>",      function() harpoon:list():select(3) end,                     desc = "harpoon  buffer 3" },
        { "<a-4>",      function() harpoon:list():select(4) end,                     desc = "harpoon  buffer 4" },
        { "<leader>hn", function() harpoon:list():next() end,                        desc = "harpoon next buffer" },
        { "<leader>hp", function() harpoon:list():prev() end,                        desc = "harpoon prev buffer" },
        { "<leader>ha", function() harpoon:list():add() end,                         desc = "harpoon add file" },
        { "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon list" },
        { "<leader>ht", function() toogle_telescope(harpoon:list()) end,             desc = "harpoon telescope" },
    }
end

return {
    setupmapping = setupmapping,
}
