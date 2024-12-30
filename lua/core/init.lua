local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()
-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = true

opt.expandtab = true
opt.autoindent = true
opt.smartcase = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true

opt.timeoutlen = 400
opt.undofile = true

opt.wrap = true
-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- Scroll offset
opt.scrolloff = 9000

---- Fold Indenting
--vim.o.foldmethod = 'indent'

-- opt.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
--- Set cursor style



-- Set cursor to horizontal line in insert mode and vertical line in normal mode
-- opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor-blinkwait700-blinkon400-blinkoff250"
-- if vim.fn.has("nvim") == 1 then
--     vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
-- end

-- Set the color of comments
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.opt.guicursor = "n-v-c:block,i-ci-ve:underline,r-cr:hor20,o:hor50"
    end,
})

vim.cmd([[
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
]])

vim.cmd([[
  augroup neovim_cursor_settings
    autocmd!
    " Set cursor to not blink in insert mode and set cursor line highlight
    " Set color of the selected tex
    " autocmd InsertEnter * set guicursor=a:blinkon0 | highlight CursorLine cterm=none ctermbg=darkgrey ctermfg=none guibg=grey15

    "  Set cursor to horizontal line in insert mode and vertical line in normal mode
    " autocmd InsertEnter * set guicursor=a:blinkon0  | set CursorLine

    " Set the color of highlighted/selected texts"
    autocmd InsertEnter * highlight Visual cterm=none ctermbg=darkgrey ctermfg=none guibg=#3a3a3a

    " Set cursor to blink when leaving insert mode
    autocmd InsertLeave * set guicursor=a:blinkwait700-blinkon400-blinkoff250
  augroup END
]])

function Telescope_grep_selected_text()
    local selected_text = vim.fn.getreg(0, 1, 1)
    require('telescope.builtin').grep_string({
        search = selected_text,
        hidden = true,
        layout_config = { prompt_position = 'top' },
    })
end

-- vim.api.nvim_set_keymap('x', '<Leader>g', ":lua Telescope_grep_selected_text()<CR>", { noremap = true, silent = true })


-- Remove the default Ctrl + x mapping
vim.api.nvim_set_keymap('n', '<C-x>', '<Nop>', { noremap = true, silent = true })

-- Set default folding method to 'indent' for text files
vim.api.nvim_exec([[
  autocmd FileType text,markdown,plaintext setlocal foldmethod=indent
]], false)

-- Disable folding when using fzf
vim.api.nvim_exec([[
  autocmd FileType fzf setlocal nofoldenable
]], false)

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
g.mapleader = " ,"

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- reload some chadrc options on-save
autocmd("BufWritePost", {
    pattern = vim.tbl_map(function(path)
        return vim.fs.normalize(vim.loop.fs_realpath(path))
    end, vim.fn.glob(vim.fn.stdpath "config" .. "/lua/custom/**/*.lua", true, true, true)),
    group = vim.api.nvim_create_augroup("ReloadNvChad", {}),

    callback = function(opts)
        local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
        local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
        local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

        require("plenary.reload").reload_module "base46"
        require("plenary.reload").reload_module(module)
        require("plenary.reload").reload_module "custom.chadrc"

        config = require("core.utils").load_config()

        vim.g.nvchad_theme = config.ui.theme
        vim.g.transparency = config.ui.transparency

        -- statusline
        require("plenary.reload").reload_module("nvchad.statusline." .. config.ui.statusline.theme)
        vim.opt.statusline = "%!v:lua.require('nvchad.statusline." .. config.ui.statusline.theme .. "').run()"

        -- tabufline
        if config.ui.tabufline.enabled then
            require("plenary.reload").reload_module "nvchad.tabufline.modules"
            vim.opt.tabline = "%!v:lua.require('nvchad.tabufline.modules').run()"
        end

        require("base46").load_all_highlights()
        vim.cmd("redraw!")
    end,
})

-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("NvChadUpdate", function()
    require "nvchad.updater" ()
end, {})
