return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enable multiple Snacks features for enhanced experience
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    indent = {
      enabled = true,
      char = "│",
      scope = {
        enabled = true,
        char = "│",
        hl = "SnacksIndentScope",
      },
    },
    scope = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        -- Customize which preset sections to use
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
          {
            icon = "󰠮 ",
            key = "o",
            desc = "Obsidian notes",
            action = ":e ~/Development/Obsidian/Maky Software Inc/Notes/Daily Notes.md",
          },
          { icon = "🚬", key = "t", desc = "Ghostty Config", action = ":e ~/.config/ghostty/config" },
          { icon = "🚀", key = "a", desc = "Aerospace Config", action = ":e ~/.config/aerospace/aerospace.toml" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/apple.gif --size 60x20 --stretch || echo '🍎 Welcome to Neovim!'",
          height = 20,
          padding = 1,
          ttl = 0, -- Cache forever since it's a static image
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    -- Terminal integration
    terminal = {
      enabled = true,
      win = {
        position = "float",
        border = "rounded",
      },
    },
    -- Git integration
    git = {
      enabled = true,
    },
    -- Rename with LSP support
    rename = {
      enabled = true,
    },
    -- Zen mode for focused coding
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        diagnostics = false,
      },
    },
  },
  keys = {
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create toggle commands
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
