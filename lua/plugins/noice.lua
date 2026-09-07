return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      -- Tailwind can return an empty hover while TypeScript returns useful docs.
      hover = { silent = true },
      signature = { enabled = false },
    },
  },
  keys = {
    {
      "<leader>sne",
      function()
        require("noice").cmd("errors")
      end,
      desc = "Noice Errors",
    },
  },
}
