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
    },
    keys = {
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
        "<leader>ar",
        function()
          require("herdr-context").refresh()
        end,
        desc = "Refresh Herdr Agents",
      },
    },
  },
}
