return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    -- provider = "copilot",
    -- auto_suggestions_provider = "deepseek",
    provider = "claude",
    providers = {
      copilot = {
        model = "claude-3.5-sonnet",
      },
      ollama = {
        model = "qwq",
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      gemini = {
        model = "gemini-2.5-pro-exp-03-25 ", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "deepseek_api_key",
        endpoint = "https://api.deepseek.com/beta",
        model = "deepseek-chat",

        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },
      deepseek_r1 = {
        __inherited_from = "openai",
        api_key_name = "deepseek_api_key",
        endpoint = "https://api.deepseek.com/beta",
        model = "deepseek-reasoner",
        extra_request_body = { temperature = 0, max_tokens = 8192 },
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "groq_api_key",
        endpoint = "https://api.groq.com/openai/v1/",
        -- model = "deepseek-r1-distill-llama-70b",
        model = "llama-3.3-70b-versatile",
      },
      cerebras = {
        __inherited_from = "openai",
        api_key_name = "cerebras_api_key",
        endpoint = "https://api.cerebras.ai/v1/",
        model = "llama-3.3-70b",
      },
      hyperbolic = {
        __inherited_from = "openai",
        api_key_name = "hyperbolic_api_key",
        endpoint = "https://api.hyperbolic.xyz/v1/",
        model = "deepseek-ai/deepseek-r1",
      },
    },
    cursor_applying_provider = "groq",
    behavior = {
      enable_cursor_applying_mode = true,
      enable_fastapply = true, -- Enable Fast Apply feature
    },
    windows = {
      width = 40,
    },
    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.
    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively.
    --- Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output.
    --- Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = "deepseek",
      second_provider = "groq",
      prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
      timeout = 60000, -- Timeout in milliseconds
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
    "zbirenbaum/copilot.lua", -- for providers='copilot'
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
