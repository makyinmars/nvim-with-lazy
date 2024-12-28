return {
  "makyinmars/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim" },
  },
  config = function(_)
    local presets = require("kznllm.presets.basic")

    -- Helper function to create keymaps with common options
    local function create_keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end

    -- Helper function to invoke presets with options
    local function invoke_with_opts(opts)
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
      invoke_with_opts({ debug = true }),
      "Send current selection to LLM debug"
    )
    create_keymap(
      { "n", "v" },
      "<leader>kdb",
      invoke_with_opts({ debug = false }),
      "Send current selection to LLM Fill"
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
