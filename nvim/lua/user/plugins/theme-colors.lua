vim.cmd('colorscheme onedark')
vim.api.nvim_set_hl(0, 'FloatBorder', {
  fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
  bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
})

-- Make the cursor line background invisible
vim.api.nvim_set_hl(0, 'CursorLineBg', {
  fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
})
vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })

vim.api.nvim_set_hl(0, 'StatusLineNonText', {
  fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
  bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
})
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })

-- Neogit
vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = '#A8E2A3', bg = '#364143'})
vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = '#F18CA8', bg = '#443244' })
vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = '#A8E2A3', bg = '#364143'})
vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = '#F18CA8', bg = '#443244' })
vim.api.nvim_set_hl(0, "NeogitBranch", { fg = '#FFC561', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitBranchHead", { fg = '#FFC561', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitChangeAdded", { fg = '#ADDE83', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitChangeModified", { fg = '#FFC561', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitChangeDeleted", { fg = '#CB525D', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitSectionHeader", { fg = '#6BA8FA', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitDiffHeader", { fg = '#6BA8FA', bg = 'NONE' })
vim.api.nvim_set_hl(0, "NeogitDiffHeaderHighlight", { fg = '#6BA8FA', bg = 'NONE' })


