require('gitsigns').setup()

vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('v', 'gs', ":'<,'>Gitsigns stage_hunk<CR>")
