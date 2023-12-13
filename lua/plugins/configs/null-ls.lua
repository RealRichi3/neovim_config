local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

local formatting = null_ls.buildtins.formatting
local diagnostics = null_ls.buildtins.diagnostics

null_ls.setup({
  debug = false,
  sources ={
    diagnostics.eslint
    }
})
