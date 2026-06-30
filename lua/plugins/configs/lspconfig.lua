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

vim.lsp.config('lua_ls', {})
vim.lsp.config('lemminx', {})
vim.lsp.config('jdtls', {})

vim.lsp.config('gopls', {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    cmd = { 'gopls' },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
})

vim.lsp.config('omnisharp', {
    handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
    cmd = { "OmniSharp", "--languageserver" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
})

vim.lsp.config('ts_ls', {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
        typescript = {
            preferences = {
                importModuleSpecifierPreference = "non-relative",
            },
        },
    },

    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },

    flags = {
        debounce_text_changes = 150,
    },

    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", 'scss', 'css' },
})

vim.lsp.config('pyright', {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
})

vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    },
})

vim.lsp.enable({
    'lua_ls',
    'lemminx',
    'jdtls',
    'gopls',
    'omnisharp',
    'ts_ls',
    'pyright',
    'clangd',
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
