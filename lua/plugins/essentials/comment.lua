return {
    {
        "numtostr/comment.nvim",
        keys = {
            { "gcc", mode = "n",          desc = "comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "comment toggle linewise" },
            { "gc",  mode = "x",          desc = "comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "comment toggle blockwise (visual)" },
        },
        init = function()
            require("core.utils").load_mappings "comment"
            require("plugins.configs.comment").config()
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local todo_comments = require("todo-comments")

            local keymap = vim.keymap

            keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Search for TODOs" })
            keymap.set("n", "]t", function()
                todo_comments.jump_next()
            end, { desc = "Jump to next TODO" })
            keymap.set("n", "[t", function()
                todo_comments.jump_prev()
            end, { desc = "Jump to previous TODO" })

            todo_comments.setup()
        end,
    }
}
