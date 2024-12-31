dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    utils.load_mappings("lspconfig", { buffer = bufnr })

    if client.server_capabilities.signatureHelpProvider then
        require("nvchad.signature").setup(client)
    end

    if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({})
lspconfig.jdtls.setup({})
lspconfig.tsserver.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
        typescript = {
            preferences = {
                importModuleSpecifierPreference = "non-relative",
            },
        },
    },

    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),

    flags = {
        debounce_text_changes = 150,
    },


    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", 'scss', 'css' },

}

lspconfig.pyright.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities
})

-- local lspconfig = require('lspconfig')
-- local mason_lspconfig = require('mason-lspconfig')
-- local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = vim.keymap

-- vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Show LSP hover" })
-- vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Show LSP definition" })

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    }
})

return M
