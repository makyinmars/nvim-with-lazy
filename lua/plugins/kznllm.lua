return {
  "chottolabs/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim" },
  },
  config = function(_)
    local presets = require("kznllm.presets.basic")

    -- Helper function to create keymaps with common options
    local function create_keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end

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

    -- Helper function to invoke presets with options
    local function invoke_preset_with_options(opts)
      return function()
        local preset = presets.load_selected_preset(presets.options)
        preset.invoke(opts)
      end
    end

    -- Keymaps for switching presets and invoking LLM
    create_keymap({ "n", "v" }, "<leader>kdm", function()
      presets.switch_presets(presets.options)
    end, "Switch between presets")

    create_keymap(
      { "n", "v" },
      "<leader>kdd",
      invoke_preset_with_options({ debug = true, progress_message_fn = progress_fn }),
      "Send current selection to LLM debug"
    )
    create_keymap(
      { "n", "v" },
      "<leader>kdb",
      invoke_preset_with_options({ debug = false, progress_message_fn = progress_fn }),
      "Send current selection to LLM llm_fill"
    )

    -- Escape keymap with autocmd
    vim.api.nvim_set_keymap("n", "<Esc>", "", {
      noremap = true,
      silent = true,
      callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LLM_Escape" })
      end,
    })
  end,
}
