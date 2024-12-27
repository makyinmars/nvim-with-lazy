return {
  "chottolabs/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim" },
  },
  config = function(self)
    local presets = require("kznllm.presets.basic")

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
      invoke_with_opts({ debug = true }),
      { desc = "Send current selection to LLM debug" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>kdb",
      invoke_with_opts({ debug = false }),
      { desc = "Send current selection to LLM llm_fill" }
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
