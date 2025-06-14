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
local util = require('lspconfig/util')

lspconfig.lua_ls.setup({})
lspconfig.lemminx.setup({})
lspconfig.jdtls.setup({})
lspconfig.gopls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    cmd = { 'gopls' },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git")
})
lspconfig.omnisharp.setup({
    handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").hander,
    },
    cmd = { "OmniSharp", "--languageserver" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
})
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

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    }
})

-- Add autocmd for Go file formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({async = false})
    end
})


return M
