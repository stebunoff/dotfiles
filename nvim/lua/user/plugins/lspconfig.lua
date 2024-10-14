-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    "volar",
    'intelephense'
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP
require('lspconfig').intelephense.setup({
  commands = {
    IntelephenseIndex = {
      function()
        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
      end,
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities
})

-- Vue, JavaScript, TypeScript
require('lspconfig').volar.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
})

require('lspconfig').ts_ls.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
})

-- Tailwind CSS
require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

 -- null-ls
 local null_ls = require('null-ls')
 local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
 null_ls.setup({
   temp_dir = '/tmp',
   sources = {
     null_ls.builtins.diagnostics.eslint_d.with({
       condition = function(utils)
         return utils.root_has_file({ '.eslintrc.js', 'eslint.config.mjs' })
       end,
     }),
     null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
     null_ls.builtins.formatting.eslint_d.with({
       condition = function(utils)
         return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json', 'eslint.config.mjs' })
       end,
     }),
     null_ls.builtins.formatting.pint.with({
       condition = function(utils)
         return utils.root_has_file({ 'vendor/bin/pint' })
       end,
     }),
     null_ls.builtins.formatting.prettier.with({
       condition = function(utils)
         return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
       end,
     }),
   },
   on_attach = function(client, bufnr)
     if client.supports_method("textDocument/formatting") then
       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
       vim.api.nvim_create_autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function()
           vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
         end,
       })
     end
   end,
 })

-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'fo', '<cmd>lua vim.lsp.buf.format()<CR>')

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
