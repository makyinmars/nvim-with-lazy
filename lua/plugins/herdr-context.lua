local plugin_dir = vim.fn.expand("~/Development/NVIM/herdr-context.nvim")

return {
  {
    dir = plugin_dir,
    name = "herdr-context.nvim",
    enabled = vim.fn.isdirectory(plugin_dir) == 1,
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
      min_herdr_version = "0.9.1",
      multiline_strategy = "auto",
      bracketed_paste_agents = {
        claude = true,
        codex = true,
        grok = true,
        opencode = true,
      },
      context_file_dir = nil,
      composer = {
        layout = "float",
        width = 0.92,
        height = 0.8,
        include = "reference",
        hide_empty = true,
        attach_empty_diagnostics = false,
        agent_picker = "inline",
        embed_unsaved = "ask",
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
          "gh[pousr]_%w+",
          "github_pat_[%w_]+",
          "xox[baprs]%-[%w%-]+",
          '"type"%s*:%s*"service_account"',
          "eyJ[%w_%-]+%.eyJ[%w_%-]+%.[%w_%-]+",
        },
        entropy_enabled = true,
        entropy_threshold = 4.5,
        entropy_min_length = 20,
        entropy_keywords = { "key", "secret", "token", "password", "credential" },
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
          backends = { "mini_diff", "git" },
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
      { "<leader>a", desc = "+herdr", mode = { "n", "v" } },
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
        desc = "Prompt Herdr with Line or Selection",
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
        desc = "Stage @path#L Reference to Herdr",
      },
      {
        "<leader>aY",
        function()
          require("herdr-context").send()
        end,
        mode = { "n", "v" },
        desc = "Stage Reference and Code to Herdr",
      },
      {
        "<leader>ad",
        function()
          require("herdr-context").diagnostics()
        end,
        mode = { "n", "v" },
        desc = "Stage Diagnostics to Herdr",
      },
      {
        "<leader>at",
        function()
          require("herdr-context").select_target()
        end,
        desc = "Pick Herdr Target",
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
