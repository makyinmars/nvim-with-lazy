return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    -- provider = "copilot",
    -- auto_suggestions_provider = "copilot",
    -- copilot = {
    --   model = "claude-3.5-sonnet",
    -- },
    provider = "claude",
    windows = {
      width = 40,
    },
    vendors = {
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434/v1",
        model = "qwen2.5-coder:32b",
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-chat",
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.1-70b-versatile",
      },
      cerebras = {
        __inherited_from = "openai",
        api_key_name = "CEREBRAS_API_KEY",
        endpoint = "https://api.cerebras.ai/v1/",
        model = "llama-3.3-70b",
      },
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = true,
          prompt_for_file_name = true,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },

    {
      -- Make sure to setup it properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
