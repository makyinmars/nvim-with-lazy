local plugin_dir = vim.fn.expand("~/Development/NVIM/jam.nvim")

return {
  dir = plugin_dir,
  name = "jam.nvim",
  enabled = vim.fn.isdirectory(plugin_dir) == 1,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    { "3rd/image.nvim", opts = {} },
  },
  cmd = "Jam",
  keys = {
    { "<leader>jm", "<cmd>Jam<cr>", desc = "Search YouTube Music" },
  },
  opts = {
    provider = "youtube_music",
    providers = {
      youtube_music = {
        api_key = vim.env.YOUTUBE_API_KEY,
        region_code = "US",
      },
    },
  },
}
