-- Comment plugin configuration in Lazy Vim
local M = {}

M.setup = {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
--   on_attach = function (bufrn)
--     local gs = require('gitsigns')
--     local function map(mode, l, r, desc)
--         vim.keymap.set(mode, l, r, { buffer = bufrn, desc = desc })
--     end
--
--     map("n", "<leader>gs", "<cmd>lua gs.stage_hunk()<CR>", "Stage hunk")
--     map("v", "<leader>gs", function ()
--         gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
--     end, "Stage hunk")
--     map("n", "<leader>gu", gs.undo_stage_hunk(), "Undo stage hunk")
--     map("n", "<leader>gr", gs.reset_hunk(), "Reset hunk")
--     map("v", "<leader>gr", function ()
--         gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
--     end, "Reset hunk")
--     map("n", "]h", gs.next_hunk, "Next hunk")
--     map("n", "[h", gs.prev_hunk, "Previous hunk")
--     map("n", "<leader>gb", function ()
--         gs.blame_line({ full = true })
--     end, "Blame line")
--     map("n", "<leader>gB", gs.toggle_current_line_blame,  "Toggle line blame")
--     map("n", "<leader>gd", gs.diffthis,  "Diff this")
--     map("n", "<leader>gD", function ()
--         gs.diffthis("~")
--     end,  "Diff this ~")
--
--     map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Text object hunk")
-- end
on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, desc)
        local opts = { desc = desc, buffer = bufnr }
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>gs', gitsigns.stage_hunk, "Stage hunk")
    map('n', '<leader>gr', gitsigns.reset_hunk , "Reset hunk")
    map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end,  "Stage hunk")
    map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end,  "Reset hunk")
    map('n', '<leader>gS', gitsigns.stage_buffer,  "Stage buffer")
    map('n', '<leader>gu', gitsigns.undo_stage_hunk, "Undo stage hunk")
    map('n', '<leader>gR', gitsigns.reset_buffer, "Reset buffer")
    map('n', '<leader>gp', gitsigns.preview_hunk, "Preview hunk")
    map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, "Blame line")
    map('n', '<leader>gb', gitsigns.toggle_current_line_blame, "Toggle current line blame")
    map('n', '<leader>gd', gitsigns.diffthis, "Diff this")
    map('n', '<leader>gD', function() gitsigns.diffthis('~') end, "Diff this ~")
    map('n', '<leader>gd', gitsigns.toggle_deleted, "Toggle deleted")

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Text object hunk")
  end
}

return M


