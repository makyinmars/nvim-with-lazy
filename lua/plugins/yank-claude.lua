return {
  "wasabeef/yank-for-claude.nvim",
  config = function()
    require("yank-for-claude").setup()
  end,
  keys = {
    -- Reference only
    {
      "<leader>y",
      function()
        require("yank-for-claude").yank_visual()
      end,
      mode = "v",
      desc = "Yank for Claude",
    },
    {
      "<leader>y",
      function()
        require("yank-for-claude").yank_line()
      end,
      mode = "n",
      desc = "Yank line for Claude",
    },

    -- Reference + Code
    {
      "<leader>Y",
      function()
        require("yank-for-claude").yank_visual_with_content()
      end,
      mode = "v",
      desc = "Yank with content",
    },
    {
      "<leader>Y",
      function()
        require("yank-for-claude").yank_line_with_content()
      end,
      mode = "n",
      desc = "Yank line with content",
    },
  },
}
