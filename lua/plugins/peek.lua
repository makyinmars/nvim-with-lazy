return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  keys = {
    {
      "<leader>xee",
      function()
        require("peek").open()
      end,
      desc = "[P]eek Mark[d]own Open",
    },
    {
      "<leader>xec",
      function()
        require("peek").close()
      end,
      desc = "[P]eek Mark[d]own Close",
    },
  },
  config = function()
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}
