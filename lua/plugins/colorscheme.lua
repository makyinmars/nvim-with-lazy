return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      local palette = require("gruvbox").palette

      return {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,
        contrast = "hard",
        dim_inactive = false,
        transparent_mode = true,
        overrides = {
          CursorLine = { bg = palette.dark0_soft },
          CursorLineNr = { fg = palette.bright_yellow, bg = "NONE", bold = true },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { fg = palette.dark3, bg = "NONE" },
          FloatTitle = { bg = "NONE" },
          Pmenu = { bg = "NONE" },
          PmenuSbar = { bg = "NONE" },
          PmenuSel = { fg = palette.dark0, bg = palette.bright_blue, bold = true },
          Search = { fg = palette.dark0, bg = palette.bright_yellow, bold = true },
          IncSearch = { fg = palette.dark0, bg = palette.bright_orange, bold = true },
          Visual = { bg = palette.dark2 },
          StatusLine = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          TabLine = { bg = "NONE" },
          TabLineFill = { bg = "NONE" },
          WinBar = { bg = "NONE" },
          WinBarNC = { bg = "NONE" },
          TreesitterContext = { bg = "NONE" },
          TreesitterContextLineNumber = { bg = "NONE" },
        },
      }
    end,
    config = function(_, opts)
      vim.o.background = "dark"
      require("gruvbox").setup(opts)
    end,
  },
}
