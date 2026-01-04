-- Snacks.nvim customizations
-- LazyVim handles most config; only override what's unique here
return {
  "folke/snacks.nvim",
  opts = {
    -- Custom dashboard with image and personal shortcuts
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          -- Personal config shortcuts
          { icon = "󰊠 ", key = "t", desc = "Ghostty Config", action = ":e ~/.config/ghostty/config" },
          { icon = " ", key = "a", desc = "Aerospace Config", action = ":e ~/.config/aerospace/aerospace.toml" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/meh-user.png --size 40x35 || echo 'Welcome to Neovim!'",
          height = 20,
          padding = 1,
          ttl = 0,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },

    -- Floating terminal preference
    terminal = {
      win = {
        position = "float",
        border = "rounded",
      },
    },

    -- Zen mode customization
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        diagnostics = false,
      },
    },
  },

  keys = {
    { "<leader>uz", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>uZ", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
  },
}
