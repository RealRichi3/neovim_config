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
--   on_attach = function(bufnr)
--     local gs = package.loaded.gitsigns
--     local function map(mode, l, r, opts)
--         opts = opts or {}
--         opts.buffer = bufnr
--         vim.keymap.set(mode, l, r, opts)
--     end

--     -- Navigation
--     map('n', ']c', function()
--         if vim.wo.diff then return ']c' end
--         vim.schedule(function() gs.next_hunk() end)
--         return '<Ignore>'
--     end, {expr=true})

--     map('n', '[c', function()
--         if vim.wo.diff then return '[c' end
--         vim.schedule(function() gs.prev_hunk() end)
--         return '<Ignore>'
--     end, {expr=true})

--     -- Actions
--     map('n', '<leader>gghs', gs.stage_hunk)
--     map('n', '<leader>gghr', gs.reset_hunk)
--     map('v', '<leader>gghs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
--     map('v', '<leader>gghr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
--     map('n', '<leader>gghS', gs.stage_buffer)
--     map('n', '<leader>gghu', gs.undo_stage_hunk)
--     map('n', '<leader>gghR', gs.reset_buffer)
--     map('n', '<leader>gghp', gs.preview_hunk)
--     map('n', '<leader>gghb', function() gs.blame_line{full=true} end)
--     map('n', '<leader>ggtb', gs.toggle_current_line_blame)
--     map('n', '<leader>gghd', gs.diffthis)
--     map('n', '<leader>gghD', function() gs.diffthis('~') end)
--     map('n', '<leader>ggtd', gs.toggle_deleted)
--     map('n', '<leader>gghL', gs.toggle_linehl)
--     map('n', '<leader>gghn', gs.toggle_numhl)
--     map('n', '<leader>gghw', gs.toggle_word_diff)
--     map('n', '<leader>ggh[', gs.prev_blame)
--     map('n', '<leader>ggh]', gs.next_blame)
--     map('n', '<leader>ggh?', gs.blame_line)

--     -- Text object
--     map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
--   end
}

return M

