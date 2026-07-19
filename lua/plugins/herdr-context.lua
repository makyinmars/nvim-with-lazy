return {
  {
    -- Production (uncomment this and comment out `dir` below):
    "makyinmars/herdr-context.nvim",

    -- Local development:
    -- dir = "/Users/franklin/Development/NVIM/herdr-context.nvim",
    name = "herdr-context.nvim",
    cond = vim.env.HERDR_ENV == "1",
    lazy = false,
    opts = {
      submit = false,
      focus_after_send = false,
      target_scope = "workspace",
      composer = {
        provider_timeout_ms = 1500,
        hunk_context_lines = 3,
        preview = true,
      },
      providers = {
        symbol = {
          enabled = true,
          lsp = true,
          treesitter_fallback = true,
        },
        hunk = {
          enabled = true,
          backends = { "mini_diff", "git" },
        },
        trouble = {
          enabled = true,
          modes = { "diagnostics", "quickfix" },
        },
      },
    },
    keys = {
      {
        "<leader>ac",
        function()
          require("herdr-context").compose()
        end,
        mode = { "n", "v" },
        desc = "Compose Herdr Context",
      },
      {
        "<leader>as",
        function()
          require("herdr-context").symbol()
        end,
        desc = "Stage Current Symbol to Herdr",
      },
      {
        "<leader>ah",
        function()
          require("herdr-context").hunk()
        end,
        desc = "Stage Git Hunk to Herdr",
      },
      {
        "<leader>aq",
        function()
          require("herdr-context").quickfix()
        end,
        desc = "Stage Quickfix List to Herdr",
      },
      {
        "<leader>al",
        function()
          require("herdr-context").location_list()
        end,
        desc = "Stage Location List to Herdr",
      },
      {
        "<leader>ay",
        function()
          require("herdr-context").reference()
        end,
        mode = { "n", "v" },
        desc = "Send Reference to Herdr Agent",
      },
      {
        "<leader>aY",
        function()
          require("herdr-context").send()
        end,
        mode = { "n", "v" },
        desc = "Send Context to Herdr Agent",
      },
      {
        "<leader>ad",
        function()
          require("herdr-context").diagnostics()
        end,
        mode = { "n", "v" },
        desc = "Send Diagnostics to Herdr Agent",
      },
      {
        "<leader>at",
        function()
          require("herdr-context").select_target()
        end,
        desc = "Select Herdr Agent",
      },
      {
        "<leader>aa",
        function()
          require("herdr-context").agents()
        end,
        desc = "Toggle Herdr Agents",
      },
      {
        "<leader>aH",
        function()
          require("herdr-context").history()
        end,
        desc = "Toggle Herdr Context History",
      },
      {
        "<leader>ar",
        function()
          require("herdr-context").refresh()
        end,
        desc = "Refresh Herdr Agents",
      },
    },
  },
}
