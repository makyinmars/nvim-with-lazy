return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    provider = "claude",
    windows = {
      width = 40,
    },
    vendors = {
      ---@type AvanteProvider
      ollama = {
        ["local"] = true,
        endpoint = "127.0.0.1:11434/v1",
        model = "llama3.1",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. "/chat/completions",
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
              max_tokens = 8192,
              temperature = 0,
              stream = true,
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
      ---@type AvanteProvider
      deepseek = {
        endpoint = "https://api.deepseek.com/beta/v1/chat/completions",
        model = "deepseek-coder",
        api_key_name = "DEEPSEEK_API_KEY",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = { -- you can make your own message, but this is very advanced
                { role = "system", content = code_opts.system_prompt },
                { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
              },
              temperature = 0,
              max_tokens = 8192,
              stream = true, -- this will be set by default.
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
      ---@type AvanteProvider
      groq = {
        endpoint = "https://api.groq.com/openai/v1/chat/completions",
        model = "llama-3.1-70b-versatile",
        api_key_name = "GROQ_API_KEY",
        --- this function below will be used to parse in cURL arguments.
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").openai.parse_message(code_opts), -- you can make your own message, but this is very advanced
              temperature = 0,
              max_tokens = 2048,
              stream = true, -- this will be set by default.
            },
          }
        end,
        -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
      ---@type AvanteProvider
      cerebras = {
        endpoint = "https://api.cerebras.ai/v1/chat/completions",
        model = "llama3.1-70b",
        api_key_name = "CEREBRAS_API_KEY",
        --- this function below will be used to parse in cURL arguments.
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").openai.parse_message(code_opts), -- you can make your own message, but this is very advanced
              temperature = 0,
              max_tokens = 8192,
              stream = true, -- this will be set by default.
            },
          }
        end,
        -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
  },
  build = "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
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
