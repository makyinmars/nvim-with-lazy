return {
  {
    -- Production (uncomment this and comment out `dir` below):
    -- "makyinmars/herdr-context.nvim",

    -- Local development:
    dir = "/Users/franklin/Development/NVIM/herdr-context.nvim",
    name = "herdr-context.nvim",
    cond = vim.env.HERDR_ENV == "1",
    lazy = false,
    opts = {
      submit = false,
      focus_after_send = false,
      max_payload_bytes = 64 * 1024,
      target_scope = "workspace",
      remember_target = "session",
      auto_select = true,
      herdr_bin = nil,
      multiline_strategy = "auto",
      bracketed_paste_agents = {
        claude = true,
        codex = true,
      },
      context_file_dir = nil,
      composer = {
        layout = "float",
        width = 0.92,
        height = 0.8,
        checklist_width = 0.38,
        provider_timeout_ms = 1500,
        hunk_context_lines = 3,
        preview = true,
        defaults = {
          selection = true,
          symbol = true,
          hunk = true,
          diagnostics = true,
          quickfix = false,
          location_list = false,
          trouble = false,
        },
        presets = {
          debug = { "selection", "symbol", "hunk", "diagnostics" },
          review = { "hunk", "diagnostics", "quickfix", "trouble" },
          explain = { "selection", "symbol", "diagnostics" },
        },
      },
      safety = {
        enabled = true,
        confirm_warnings = true,
        exclude_patterns = { ".env", ".env.*", "*.pem", "*.key", "credentials*", "secrets*" },
        secret_patterns = {
          "AKIA[%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d][%u%d]",
          "-----BEGIN .-PRIVATE KEY-----",
          "api[_-]key%s*[:=]%s*%S+",
          "token%s*[:=]%s*%S+",
          "secret%s*[:=]%s*%S+",
          "password%s*[:=]%s*%S+",
        },
      },
      history = {
        enabled = true,
        max_entries = 20,
      },
      providers = {
        symbol = {
          enabled = true,
          lsp = true,
          treesitter_fallback = true,
        },
        hunk = {
          enabled = true,
          backends = { "git" },
        },
        trouble = {
          enabled = true,
          modes = { "diagnostics", "quickfix" },
        },
      },
      presence = {
        enabled = true,
        socket = true,
        poll_interval_ms = 3000,
        reconnect_max_ms = 10000,
        debounce_ms = 100,
        notifications = {
          idle = false,
          done = false,
          blocked = false,
        },
      },
      agents_view = {
        position = "right",
        width = 44,
        preview_lines = 80,
        deep_preview_lines = 300,
        group_by = "workspace",
        side_preview = true,
        preview_width = 64,
        show_cwd = true,
        show_workspace = true,
        show_tab = true,
      },
      statusline = {
        show_target = true,
        show_agent_count = true,
        show_connection = true,
        compact = false,
        icons = {
          herdr = "Herdr",
          target = "▶",
          idle = "●",
          working = "◉",
          blocked = "!",
          done = "✓",
          unknown = "○",
          disconnected = "×",
          separator = "·",
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
        "<leader>ap",
        function()
          require("herdr-context").prompt()
        end,
        mode = { "n", "v" },
        desc = "Prompt Herdr with Code Context",
      },
      {
        "<leader>aD",
        ":HerdrContextDelegate ",
        mode = { "n", "v" },
        desc = "Delegate Context to New Herdr Agent",
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
        "<leader>ae",
        "<cmd>HerdrContextExplainAgent<cr>",
        desc = "Explain Herdr Agent",
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
