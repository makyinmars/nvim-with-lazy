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
        transparent_mode = false,
        overrides = {
          CursorLine = { bg = palette.dark0_soft },
          CursorLineNr = { fg = palette.bright_yellow, bold = true },
          NormalFloat = { bg = palette.dark0_soft },
          FloatBorder = { fg = palette.dark3, bg = palette.dark0_soft },
          Pmenu = { bg = palette.dark0_soft },
          PmenuSel = { fg = palette.dark0, bg = palette.bright_blue, bold = true },
          Search = { fg = palette.dark0, bg = palette.bright_yellow, bold = true },
          IncSearch = { fg = palette.dark0, bg = palette.bright_orange, bold = true },
          Visual = { bg = palette.dark2 },
        },
      }
    end,
    config = function(_, opts)
      vim.o.background = "dark"
      require("gruvbox").setup(opts)
    end,
  },
}
