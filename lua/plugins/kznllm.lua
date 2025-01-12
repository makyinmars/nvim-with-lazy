return {
  "chottolabs/kznllm.nvim",
  -- dev = true,
  -- dir = os.getenv("HOME") .. "/Development/OpenSource/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim" },
  },
  config = function(_)
    local presets = require("kznllm.presets.basic")

    local function yap_generator()
      math.randomseed(os.time())
      local yap_cycle = {
        "yapped for %ds",
        "...",
      }

      local idx = math.random(1, #yap_cycle)
      return function()
        idx = idx + 1
        if idx > #yap_cycle then
          idx = 1
        end
        return yap_cycle[idx]
      end
    end

    local yap = yap_generator()

    local function progress_fn(state)
      local now = os.time()
      if (now ~= state.last_updated) and ((now - state.start) % 3) == 0 then
        state.last_updated = now
        return yap()
      end
    end

    vim.keymap.set({ "n", "v" }, "<leader>kdm", function()
      presets.switch_presets(presets.options)
    end, { desc = "switch between presets" })

    local function invoke_with_opts(opts)
      return function()
        local preset = presets.load_selected_preset(presets.options)
        preset.invoke(opts)
      end
    end

    vim.keymap.set(
      { "n", "v" },
      "<leader>kdd",
      invoke_with_opts({ debug = false, progress_message_fn = progress_fn }),
      { desc = "Send current selection to LLM Fill" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>kdh",
      invoke_with_opts({ debug = true, progress_message_fn = progress_fn }),
      { desc = "Send current selection to LLM Help" }
    )

    vim.api.nvim_set_keymap("n", "<Esc>", "", {
      noremap = true,
      silent = true,
      callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LLM_Escape" })
      end,
    })
  end,
}
