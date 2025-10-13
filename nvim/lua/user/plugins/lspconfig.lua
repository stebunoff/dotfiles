-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    "vtsls",
    'intelephense',
    "tailwindcss",
    "jsonls",
    "lua_ls"
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP
vim.lsp.config("intelephense", {
  commands = {
    IntelephenseIndex = {
      function()
        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
      end,
    },
  },
  capabilities = capabilities
})

vim.lsp.config("vtsls", {
    capabilities = capabilities,
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
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
      "vue"
    },
})

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
  })

-- JSON
vim.lsp.config("jsonls", {
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
})

-- Lua
vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        }
      }
    }
  })

vim.lsp.enable({ "vue_ls", "vtsls", "intelephense", "tailwindcss", "jsonls", "lua_ls" })

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
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.INFO]  = '●',
      [vim.diagnostic.severity.HINT]  = '●',
    },
  },
})
