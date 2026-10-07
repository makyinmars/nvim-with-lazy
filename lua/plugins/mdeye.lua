local plugin_dir = vim.fn.expand("~/Development/NVIM/mdeye.nvim")

return {
  dir = plugin_dir,
  name = "mdeye.nvim",
  enabled = vim.fn.isdirectory(plugin_dir) == 1,
  dependencies = {
    { "3rd/image.nvim", opts = {} },
  },
  cmd = "MDEye",
  ft = "markdown",
  keys = {
    { "<leader>me", "<cmd>MDEye<cr>", desc = "Toggle Markdown document view" },
    { "<leader>mc", "<cmd>MDEye current<cr>", desc = "Markdown document view in current window" },
    { "<leader>ms", "<cmd>MDEye split<cr>", desc = "Markdown document view in split" },
    { "<leader>mt", "<cmd>MDEye tab<cr>", desc = "Markdown document view in tab" },
    { "<leader>mq", "<cmd>MDEye close<cr>", desc = "Close Markdown document view" },
    { "<leader>my", "<cmd>MDEye copy-code<cr>", desc = "Copy Markdown code block" },
    { "<leader>mo", "<cmd>MDEye open-image<cr>", desc = "Open Mermaid diagram image" },
  },
  opts = {
    open = "split",
    max_width = 1000,
    mermaid = {
      enabled = true,
      layout = "graph",
      image = {
        enabled = "auto",
        timeout_ms = 15000,
        theme = "auto",
        background = "transparent",
        scale = 3,
        width = 1920,
      },
    },
    images = {
      enabled = true,
      max_width = 88,
      max_height = 32,
    },
  },
}
