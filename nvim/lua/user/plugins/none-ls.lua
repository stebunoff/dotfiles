local none_ls = require('null-ls')
local eslint_diag = require("none-ls.diagnostics.eslint_d")
local eslint_fmt  = require("none-ls.formatting.eslint_d")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
none_ls.setup({
    temp_dir = '/tmp',
    sources = {
      eslint_diag.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js', 'eslint.config.mjs' })
          end,
        }),
      none_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
      eslint_fmt.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json', 'eslint.config.mjs' })
          end,
        }),
      none_ls.builtins.formatting.pint.with({
          condition = function(utils)
            return utils.root_has_file({ 'vendor/bin/pint' })
          end,
        }),
      none_ls.builtins.formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
          end,
        }),
    },
    on_attach = function(client, bufnr)
      if client:supports_method("textDocument/formatting") then
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
