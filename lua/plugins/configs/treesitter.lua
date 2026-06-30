-- nvim-treesitter `main` branch config (required for Neovim 0.11+/0.12).
-- `main` ships only parsers + queries; Neovim itself provides highlight/fold/indent.
-- See `:h treesitter-highlight`.

local ts = require "nvim-treesitter"

ts.setup {
    -- prepended to runtimepath so installed parsers take priority over bundled ones
    install_dir = vim.fn.stdpath "data" .. "/site",
}

local ensure_installed = {
    "lua",
    "java",
    "javascript",
    "typescript",
    "python",
    "tsx",
    "css",
    "c",
    "cpp",
    "make",
    "c_sharp",
}

-- async; no-op for already-installed parsers
ts.install(ensure_installed)

local function ts_start(buf)
    if vim.api.nvim_buf_is_valid(buf) then
        -- errors when no parser exists for the filetype (or not yet installed)
        pcall(vim.treesitter.start, buf)
    end
end

-- enable highlight for every buffer opened from now on
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("ts_highlight", { clear = true }),
    callback = function(args)
        ts_start(args.buf)
    end,
})

-- buffers already loaded before this config ran (e.g. `nvim file.lua`)
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
        ts_start(buf)
    end
end
