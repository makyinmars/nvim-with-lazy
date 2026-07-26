return {
  "makyinmars/mdeye.nvim",
  cmd = "MDEye",
  ft = "markdown",
  keys = {
    { "<leader>me", "<cmd>MDEye<cr>", desc = "Toggle Markdown document view" },
    { "<leader>mc", "<cmd>MDEye current<cr>", desc = "Markdown document view in current window" },
    { "<leader>ms", "<cmd>MDEye split<cr>", desc = "Markdown document view in split" },
    { "<leader>mt", "<cmd>MDEye tab<cr>", desc = "Markdown document view in tab" },
    { "<leader>mq", "<cmd>MDEye close<cr>", desc = "Close Markdown document view" },
  },
  opts = {},
}
