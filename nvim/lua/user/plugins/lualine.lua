local separator = { '"▏"', color = 'StatusLineNonText' }

local filetype_names = {
  fsharp = "F#",
}

local function format_filetype(name)
  return filetype_names[name] or name
end

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = {
      normal = {
        a = 'StatusLine',
        b = 'StatusLine',
        c = 'StatusLine',
      },
    },
  },
  sections = {
    lualine_a = {
      'mode',
      separator,
    },
    lualine_b = {
      'branch',
      'diff',
      separator,
      '"\u{f1b3}  " .. tostring(#vim.tbl_keys(vim.lsp.get_clients()))',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
      separator,
    },
    lualine_c = {
      'filename'
    },
    lualine_x = {
      {
        "filetype",
        fmt = format_filetype,
      },
      'encoding',
      'fileformat',
    },
    lualine_y = {
      separator,
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
      separator,
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})
