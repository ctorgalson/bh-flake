---@see https://github.com/VonHeikemen/lsp-zero.nvim/discussions/419#discussioncomment-11121949

local lspconfig = require('lspconfig')
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config.capabilities,
  require('blink-cmp').get_lsp_capabilities()
)

--Enable (broadcasting) snippet capability for completion
local vscode_capabilities = vim.lsp.protocol.make_client_capabilities()
vscode_capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = vscode_capabilities,
}
require'lspconfig'.html.setup {
  capabilities = vscode_capabilities,
}
require'lspconfig'.htmx.setup{}
require'lspconfig'.quick_lint_js.setup{}
