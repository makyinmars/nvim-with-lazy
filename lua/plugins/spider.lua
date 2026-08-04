return {
  "chrisgrieser/nvim-spider",
  keys = {
    { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Next Subword" },
    { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "End of Subword" },
    { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Previous Subword" },
    { "ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = { "n", "o", "x" }, desc = "Previous Subword End" },
  },
  opts = {},
}
