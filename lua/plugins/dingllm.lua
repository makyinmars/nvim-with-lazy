return {
  "makyinmars/dingllm.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local global_system_prompt =
      "You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks"
    local helpful_prompt = "You are a helpful assistant. What I have sent are my notes so far."
    local dingllm = require("dingllm")

    local function invoke_llm(url, model, api_key_name, system_prompt, replace, make_args, handle_data)
      dingllm.invoke_llm_and_stream_into_editor({
        url = url,
        model = model,
        api_key_name = api_key_name,
        system_prompt = system_prompt,
        replace = replace,
      }, make_args, handle_data)
    end

    local llm_providers = {
      deepseek = {
        url = "https://api.deepseek.com/v1/chat/completions",
        model = "deepseek-chat",
        api_key = "DEEPSEEK_API_KEY",
        spec = {
          make_args = dingllm.make_openai_spec_curl_args,
          handle_data = dingllm.handle_openai_spec_data,
        },
      },
      groq = {
        url = "https://api.groq.com/openai/v1/chat/completions",
        model = "llama-3.1-70b-versatile",
        api_key = "GROQ_API_KEY",
        spec = {
          make_args = dingllm.make_openai_spec_curl_args,
          handle_data = dingllm.handle_openai_spec_data,
        },
      },
      anthropic = {
        url = "https://api.anthropic.com/v1/messages",
        model = "claude-3-5-sonnet-20241022",
        api_key = "ANTHROPIC_API_KEY",
        spec = {
          make_args = dingllm.make_anthropic_spec_curl_args,
          handle_data = dingllm.handle_anthropic_spec_data,
        },
      },
    }

    local function create_llm_functions(provider)
      return {
        replace = function()
          invoke_llm(
            provider.url,
            provider.model,
            provider.api_key,
            global_system_prompt,
            true,
            provider.spec.make_args,
            provider.spec.handle_data
          )
        end,
        help = function()
          invoke_llm(
            provider.url,
            provider.model,
            provider.api_key,
            helpful_prompt,
            false,
            provider.spec.make_args,
            provider.spec.handle_data
          )
        end,
      }
    end

    local keymaps = {
      { mode = { "n", "v" }, key = "<leader>kxdd", provider = "deepseek", type = "replace", desc = "LLM Deepseek" },
      { mode = { "n", "v" }, key = "<leader>kxdh", provider = "deepseek", type = "help", desc = "LLM Deepseek help" },
      { mode = { "n", "v" }, key = "<leader>kxgb", provider = "groq", type = "replace", desc = "LLM Groq" },
      { mode = { "n", "v" }, key = "<leader>kxgd", provider = "groq", type = "help", desc = "LLM Groq help" },
      { mode = { "n", "v" }, key = "<leader>kxab", provider = "anthropic", type = "replace", desc = "LLM Anthropic" },
      { mode = { "n", "v" }, key = "<leader>kxad", provider = "anthropic", type = "help", desc = "LLM Anthropic help" },
    }

    -- Create and register all LLM functions
    local llm_functions = {}
    for provider_name, provider_config in pairs(llm_providers) do
      llm_functions[provider_name] = create_llm_functions(provider_config)
    end

    -- Set up keymaps
    for _, mapping in ipairs(keymaps) do
      vim.keymap.set(mapping.mode, mapping.key, llm_functions[mapping.provider][mapping.type], { desc = mapping.desc })
    end
  end,
}
