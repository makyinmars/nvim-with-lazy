return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  keys = {
    { "<leader>nnpt", ":NoNeckPain<CR>", desc = "Toggle NoNeckPain" },
    { "<leader>nnpz", ":NoNeckPainResize <C-r>=vim.fn.input('Width: ')<CR>", desc = "Resize NoNeckPain" },
    { "<leader>nnpl", ":NoNeckPainToggleLeftSide<CR>", desc = "Toggle Left Side" },
    { "<leader>nnpr", ":NoNeckPainToggleRightSide<CR>", desc = "Toggle Right Side" },
    { "<leader>nnpu", ":NoNeckPainWidthUp<CR>", desc = "Increase Width" },
    { "<leader>nnpd", ":NoNeckPainWidthDown<CR>", desc = "Decrease Width" },
    { "<leader>nnps", ":NoNeckPainScratchPad<CR>", desc = "Toggle Scratch Pad" },
  },
}
