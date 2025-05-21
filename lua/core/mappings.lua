local M = {}

-- Grep selectd text
function TelescopeGrepSelectedText()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    print(text)
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    print(text)
    if #text > 0 then
        text = text
    else
        text = ''
    end

    require('telescope.builtin').live_grep({ default_text = text })
end

function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
--
-- keymap('n', '<leader>g', ':Telescope current_buffer_fuzzy_find<cr>', opts)
-- keymap('v', '<leader>g', function()
--     local tb = require('telescope.builtin')
-- 	local text = vim.getVisualSelection()
-- 	tb.current_buffer_fuzzy_find({ default_text = text })
-- end, opts)
-- Disable the default behavior of Space
--vim.api.nvim_set_keymap('n', '<Space>', '<Space>', { noremap = true, silent = true })
--
---- Set Shift+Space as the leader key
--vim.api.nvim_set_keymap('', '<S-Space>', '<Nop>', { noremap = true, silent = true })
--
---- Set Shift+Space as the local leader key
--vim.g.maplocalleader = '<S-Space>'
--
--vim.g.mapleader = '<S-Space>'
--

M.general = {
    i = {
        ["JK"] = { "<ESC>", "Exit insert mode with JK" },
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },
        -- navigate within insert mode
        -- ["<S-Space>"] = { "<Nop>", "Leader key in insert mode" },
        ["<A-Left>"] = { "<Left>", "Move left" },
        ["<A-Right>"] = { "<Right>", "Move right" },
        ["<A-Down>"] = { "<Down>", "Move down" },
        ["<A-Up>"] = { "<Up>", "Move up" },
        ["<A-h>"] = { "<Left>", "Move left" },
        ["<A-j>"] = { "<Down>", "Move down" },
        ["<A-k>"] = { "<Up>", "Move up" },
        ["<A-l>"] = { "<Right>", "Move right" },
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
        ["<leader>tv"] = { "<ESC>:ToggleTerm direction=vertical<CR>", "Open terminal in vertical direction" },
        ["<leader>th"] = { "<ESC>:ToggleTerm direction=horizontal<CR>", "Open terminal in horizontal direction" },
    },

    n = {
        -- ["<S-Space>"] = { "<Nop>", "Leader key in insert mode" },
        ["<leader>fdi"] = { "<ESC>:set foldmethod=indent<CR>", "Set fold method to INDENT" },
        ["<leader>fdm"] = { "<ESC>:set foldmethod=manual<CR>", "Set fold method to MANUAL" },
        ["<leader>fdt"] = { "<ESC>:set foldenable!<CR>", "Toggle foldenable on or off" },
        ["<leader>tv"] = { "ToggleTerm direction=vertical<CR>", "Open terminal in vertical direction" },
        ["<leader>th"] = { "ToggleTerm direction=horizontal<CR>", "Open terminal in horizontal direction" },
        ["<leader>fg"] = { ":Telescope current_buffer_fuzzy_find<CR>", "Find word in current buffer" },
        ["<leader>fG"] = { ":Telescope live_grep<CR>", "Find word in all buffers" },
        ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

        -- switch between windows
        ["<A-h>"] = { ":wincmd h<CR>", "Move Left" },
        ["<A-l>"] = { ":wincmd l<CR>", "Move right" },
        ["<A-j>"] = { ":wincmd j<CR>", "Move down" },
        ["<A-k>"] = { ":wincmd k<CR>", "Move up" },

        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

        ['tm'] = { '<ESC><C-a>', 'Tmux mapping' },

        -- Copy all
        -- ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

        -- line numbers
        ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
        ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

        -- Window management
        ["<leader>sv"] = { "<C-w>v", "Split window vertically" },
        ["<leader>sh"] = { "<C-w>s", "Split window horizontally" },
        ["<leader>se"] = { "<C-w>=", "Make splits equal size" },
        ["<leader>sx"] = { "<cmd>close<CR>", "Close current split" },

        ["<leader>to"] = { "<cmd>tabnew<CR>", "Open new tab" },
        ["<leader>tx"] = { "<cmd>tabclose<CR>", "Close current tab" },
        ["<leader>tn"] = { "<cmd>tabn<CR>", "Go to next tab" },
        ["<leader>tp"] = { "<cmd>tabp<CR>", "Go to previous tab" },
        ["<leader>tf"] = { "<cmd>tabnew %<CR>", "Open current buffer in new tab" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

        -- Nulls formatting
        ["<leader>f"] = { ":Format<CR>", "Null format file" },

        -- new buffer
        ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
        ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

        ["<leader>fm"] = {
            function()
                vim.lsp.buf.format { async = true }
            end,
            "LSP formatting",
        },
    },

    t = {
        ["JK"] = { "<ESC>", "Exit terminal mode with JK" },
        -- ["<S-Space>"] = { "<Nop>", "Leader key in insert mode" },
        -- ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    },

    v = {
        ["JK"] = { "<ESC>", "Exit visual mode with JK" },
        -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["C-{"] = { "<gv", "Indent line" },
        ["C-}"] = { ">gv", "Indent line" },
        ["C-S-C"] = { "y<CR>", "Copy line" },
        -- ["<S-Space>"] = { "<Nop>", "Leader key in insert mode" },
    },


    x = {
        -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
        ["<leader>fG"] = {
            function()
                local tb = require('telescope.builtin')
                tb.live_grep({ default_text = vim.getVisualSelection() })
            end,
            "Find selected text",
            opts = { noremap = true, silent = true }

        },
        ["<leader>fg"] = {
            function()
                local tb = require('telescope.builtin')
                tb.current_buffer_fuzzy_find({ default_text = vim.getVisualSelection() })
            end,
            "Find selected text",
            opts = { noremap = true, silent = true }

        }

    },
}

M.tabufline = {
    plugin = true,

    n = {
        -- cycle through buffers
        ["<tab>"] = {
            function()
                require("nvchad.tabufline").tabuflineNext()
            end,
            "Goto next buffer",
        },

        ["<S-tab>"] = {
            function()
                require("nvchad.tabufline").tabuflinePrev()
            end,
            "Goto prev buffer",
        },

        -- close buffer + hide terminal buffer
        ["<leader>x"] = {
            function()
                require("nvchad.tabufline").close_buffer()
            end,
            "Close buffer",
        },
    },
}

M.comment = {
    plugin = true,

    -- toggle comment in both modes
    n = {
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "Toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "Toggle comment",
        },
    },
}

M.lspconfig = {
    plugin = true,

    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "LSP declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "LSP definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "LSP implementation",
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "LSP signature help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "LSP definition type",
        },

        ["<leader>ra"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "LSP rename",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "LSP references",
        },

        ["<leader>lf"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "Floating diagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev { float = { border = "rounded" } }
            end,
            "Goto prev",
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next { float = { border = "rounded" } }
            end,
            "Goto next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "Diagnostic setloclist",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "Add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "Remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
        },
    },

    v = {
        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
        },
    },
}

M.nvimtree = {
    plugin = true,

    n = {
        -- toggle
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

        -- focus
        ["<leader>ee"] = { "<cmd> NvimTreeToggle <CR>", "Toggle file explorer" },
        ["<leader>ef"] = { "<cmd> NvimTreeFindFileToggle<CR>", "Toggle file explorer on current buffer" },
        ["<leader>ec"] = { "<cmd> NvimTreeCollapse<CR>", "Collapse file explorer" },
        ["<leader>er"] = { "<cmd> NvimTreeRefresh<CR>", "Refresh file explorer" },
    },
}

M.telescope = {
    plugin = true,

    n = {
        -- find
        ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
        ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
        ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

        -- Quick fix list
        ["<leader>fq"] = { "<cmd> Telescope quickfix <CR>", "Quickfix list" },

        -- git
        ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

        -- pick a hidden term
        ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

        -- theme switcher
        ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

        ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    },
}

M.nvterm = {
    plugin = true,

    t = {
        -- toggle in terminal mode
        ["<A-i>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "Toggle floating term",
        },

        ["<A-t>h"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "Toggle horizontal term",
        },

        ["<A-t>v"] = {
            function()
                require("nvterm.terminal").toggle "vertical"
            end,
            "Toggle vertical term",
        },
    },

    n = {
        -- toggle in normal mode
        ["<A-i>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "Toggle floating term",
        },

        ["<A-t>h"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "Toggle horizontal term",
        },

        ["<A-t>v"] = {
            function()
                require("nvterm.terminal").toggle "vertical"
            end,
            "Toggle vertical term",
        },

        -- -- new
        -- ["<leader>h"] = {
        --   function()
        --     require("nvterm.terminal").new "horizontal"
        --   end,
        --   "New horizontal term",
        -- },
        --
        -- ["<leader>v"] = {
        --   function()
        --     require("nvterm.terminal").new "vertical"
        --   end,
        --   "New vertical term",
        -- },
    },
}

M.whichkey = {
    plugin = true,

    n = {
        ["<leader>wK"] = {
            function()
                vim.cmd "WhichKey"
            end,
            "Which-key all keymaps",
        },
        ["<leader>wk"] = {
            function()
                local input = vim.fn.input "WhichKey: "
                vim.cmd("WhichKey " .. input)
            end,
            "Which-key query lookup",
        },
    },
}

M.blankline = {
    plugin = true,

    n = {
        ["<leader>cc"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd [[normal! _]]
                end
            end,

            "Jump to current context",
        },
    },
}


return M
