return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-y>",
      },
      ignore_filetypes = { env = true },
      disable_inline_completion = false, -- disables inline completion for use with cmp
    })
  end,
}
