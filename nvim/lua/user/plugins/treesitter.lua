require("nvim-treesitter.configs").setup({
  ignore_install = {},
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "python",
    "php",
    "fsharp",
  },

  modules = {},
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
  },
})
