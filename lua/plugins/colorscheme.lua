return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    -- Set the background to hard for maximum contrast
    vim.g.gruvbox_material_background = "hard"

    -- Configure gruvbox-material options
    vim.g.gruvbox_material_foreground = "material" -- 'material', 'mix', 'original'
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_transparent_background = 0 -- Set to 1 for transparent background
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_ui_contrast = "high" -- 'low', 'high'
    vim.g.gruvbox_material_float_style = "bright" -- 'bright', 'dim'
    vim.g.gruvbox_material_statusline_style = "material" -- 'default', 'mix', 'original', 'material'

    -- Disable vim's background color erase for better terminal compatibility
    vim.g.gruvbox_material_disable_terminal_colors = 0

    -- Apply the colorscheme
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
