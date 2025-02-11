---@see https://github.com/VonHeikemen/lsp-zero.nvim/discussions/419#discussioncomment-11121949

-- local lspconfig = require('lspconfig')
-- 
-- lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
--   'force',
--   lspconfig.util.default_config.capabilities,
--   require('blink-cmp').get_lsp_capabilities()
-- )
-- 
-- --Enable (broadcasting) snippet capability for completion
-- local vscode_capabilities = vim.lsp.protocol.make_client_capabilities()
-- vscode_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- 
-- require'lspconfig'.cssls.setup {
--   capabilities = vscode_capabilities,
-- }
-- require'lspconfig'.html.setup {
--   capabilities = vscode_capabilities,
-- }
-- require'lspconfig'.htmx.setup{}

local lspconfig = require('lspconfig')
local capabilities = require('blink-cmp').get_lsp_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config.capabilities,
  capabilities
)

require'lspconfig'.cssls.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.htmx.setup{
  filetypes = {
    -- "aspnetcorerazor",
    -- "astro",
    -- "astro-markdown",
    -- "blade",
    -- "clojure",
    -- "django-html",
    -- "htmldjango",
    -- "edge",
    -- "eelixir",
    -- "elixir",
    -- "ejs",
    -- "erb",
    -- "eruby",
    -- "gohtml",
    -- "gohtmltmpl",
    -- "haml",
    "handlebars",
    -- "hbs",
    -- "html",
    -- "htmlangular",
    -- "html-eex",
    -- "heex",
    -- "jade",
    -- "leaf",
    -- "liquid",
    "markdown",
    -- "mdx",
    "mustache",
    "njk",
    "nunjucks",
    -- "php",
    -- "razor",
    -- "slim",
    "twig",
    -- "javascript",
    -- "javascriptreact",
    -- "reason",
    -- "rescript",
    -- "typescript",
    -- "typescriptreact",
    -- "templ",
    "vue",
    "svelte",
  },
}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.phpactor.setup{}
require'lspconfig'.pylyzer.setup{}
require'lspconfig'.ts_ls.setup{}
