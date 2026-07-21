return {
  dir = "/Users/franklin/Development/NVIM/jam.nvim",
  name = "jam.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "3rd/image.nvim",
    opts = {},
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
