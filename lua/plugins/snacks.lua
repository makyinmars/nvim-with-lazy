-- Snacks.nvim customizations
-- LazyVim handles most config; only override what's unique here
return {
  "folke/snacks.nvim",
  opts = {
    -- Show dotfiles in explorer
    explorer = {
      hidden = true,
    },
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
          cmd = [[paste <(chafa ~/.config/nvim/assets/meh-user-optimized.png --format=symbols --size 35x17 --speed max 2>/dev/null) <(~/.config/nvim/assets/void.sh)]],
          height = 17,
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
    {
      "<leader>uz",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>uZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
}
