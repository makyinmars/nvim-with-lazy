return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      -- Terminal window settings
      window = {
        split_ratio = 0.3, -- Percentage of screen for the terminal window
        position = "vertical", -- Position: "botright", "topleft", "vertical", "float"
        enter_insert = true, -- Enter insert mode when opening Claude Code
        hide_numbers = true, -- Hide line numbers in terminal window
        hide_signcolumn = true, -- Hide sign column in terminal window

        -- Floating window configuration (when position = "float")
        float = {
          width = "80%", -- Width: number or percentage string
          height = "80%", -- Height: number or percentage string
          row = "center", -- Row position: number, "center", or percentage
          col = "center", -- Column position: number, "center", or percentage
          relative = "editor", -- Relative to: "editor" or "cursor"
          border = "rounded", -- Border: "none", "single", "double", "rounded", "solid", "shadow"
        },
      },
      -- File refresh settings
      refresh = {
        enable = true, -- Enable file change detection
        updatetime = 100, -- updatetime when Claude Code is active (ms)
        timer_interval = 1000, -- How often to check for file changes (ms)
        show_notifications = true, -- Show notification when files are reloaded
      },
      -- Git project settings
      git = {
        use_git_root = true, -- Set CWD to git root when opening Claude Code
      },
      -- Shell-specific settings
      shell = {
        separator = "&&", -- Command separator used in shell commands
        pushd_cmd = "pushd", -- Command to push directory onto stack
        popd_cmd = "popd", -- Command to pop directory from stack
      },
      -- Command settings
      command = "claude", -- Command used to launch Claude Code
      -- Command variants
      command_variants = {
        continue = "--continue", -- Resume the most recent conversation
        resume = "--resume", -- Display interactive conversation picker
        verbose = "--verbose", -- Enable verbose logging
      },
      -- Keymaps (using safe bindings that don't conflict)
      keymaps = {
        toggle = {
          normal = "<leader>ctt", -- Safe: no conflicts found
          terminal = "<leader>ctt", -- Safe: no conflicts found
          variants = {
            continue = "<leader>clc", -- Safe: using 'cl' prefix (claude)
            resume = "<leader>clr", -- Safe: using 'cl' prefix (claude)
            verbose = "<leader>clv", -- Safe: using 'cl' prefix (claude)
          },
        },
        window_navigation = true, -- Disabled to avoid conflicts with <C-h/j/k/l>
        scrolling = true, -- Enable <C-f/b> for scrolling (standard vim)
      },
    })
  end,
}
