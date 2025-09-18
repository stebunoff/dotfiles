require('neogit').setup({
  integrations = {
    diffview = true,
    telescope = true,
  },
})

-- Open Neogit
vim.keymap.set('n', '<leader>gs', function() require('neogit').open({ kind = 'replace' }) end, { desc = 'Neogit status' })
