return {
  "folke/noice.nvim",
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
