return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    local function enable()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-y>",
        },
        ignore_filetypes = { env = true },
        disable_inline_completion = false, -- disables inline completion for use with cmp
      })
    end
    vim.keymap.set("n", "<leader>ct", enable, { desc = "Supermaven Enable" })
  end,
}
