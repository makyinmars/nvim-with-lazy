return {
  "makyinmars/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim" },
  },
  config = function(_)
    local presets = require("kznllm.presets.basic")

    vim.keymap.set("n", "<leader>kdh", function()
      local buffer_manager = require("kznllm.buffer").buffer_manager
      buffer_manager:create_sidebar_buffer()
    end, { desc = "Open LLM History Sidebar" })

    -- Helper function to create keymaps with common options
    local function create_keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
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
      invoke_preset_with_options({ debug = true }),
      "Send current selection to LLM debug"
    )
    create_keymap(
      { "n", "v" },
      "<leader>kdb",
      invoke_preset_with_options({ debug = false }),
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
