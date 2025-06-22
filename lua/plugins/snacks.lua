return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/apple.gif --format symbols --size 60x20",
          height = 20,
          padding = 1,
        },
        {
          section = "keys",
          gap = 1,
          padding = 1,
          -- stylua: ignore
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󰠮 ", key = "o", desc = "Obsidian notes", action = ":e ~/Development/Obsidian/Maky Software Inc/Notes/Daily Notes.md" },
            { icon = "🚬", key = "t", desc = "Ghostty Config", action = ":e ~/.config/ghostty/config" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}