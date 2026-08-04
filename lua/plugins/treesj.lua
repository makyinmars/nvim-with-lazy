return {
  "Wansmer/treesj",
  keys = {
    {
      "<leader>cj",
      function()
        require("treesj").toggle()
      end,
      desc = "Split/Join Code Block",
    },
    {
      "<leader>cJ",
      function()
        require("treesj").toggle({ split = { recursive = true } })
      end,
      desc = "Split/Join Code Block Recursively",
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 120,
  },
}
