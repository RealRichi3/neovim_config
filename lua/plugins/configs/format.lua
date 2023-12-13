require('format').setup{
  typescript = {{ cmd = { "prettier -w", "./node_modules/.bin/eslint --fix"}}}
}

vim.cmd('autocmd BufWritePost * FormatWrite')

