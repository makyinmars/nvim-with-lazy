return {
  "makyinmars/kznllm.nvim",
  dependencies = {
    { "j-hui/fidget.nvim", "stevearc/dressing.nvim" },
  },
  config = function(self)
    local presets = require("kznllm.presets")
    local Path = require("plenary.path")

    -- Configuration constants
    local TEMPLATE_DIRECTORY = Path:new(vim.fn.expand(self.dir) .. "/templates")
    local SELECTED_PRESET = presets[3] -- Anthropic by default
    local spec = require(("kznllm.specs.%s"):format(SELECTED_PRESET.provider))

    -- Preset switching function
    local function switch_presets()
      local function format_preset_item(item)
        local options = {}
        for k, v in pairs(item.opts.data_params or {}) do
          if type(v) == "number" then
            local k_parts = {}
            local k_split = vim.split(k, "_")
            for i, term in ipairs(k_split) do
              table.insert(k_parts, i > 1 and term:sub(0, 3) or term:sub(0, 4))
            end
            table.insert(options, ("%-5s %-5s"):format(table.concat(k_parts, "_"), v))
          end
        end
        table.sort(options)
        return ("%-20s %10s | %s"):format(item.id, item.provider, table.concat(options, " "))
      end

      vim.ui.select(presets, {
        format_item = format_preset_item,
      }, function(choice)
        if choice then
          spec = require(("kznllm.specs.%s"):format(choice.provider))
          SELECTED_PRESET = choice
          print(("%-15s provider: %-10s"):format(choice.id, choice.provider))
        end
      end)
    end

    -- Common LLM invocation function
    local function invoke_llm_with_options(options)
      presets.invoke_llm(
        SELECTED_PRESET.make_data_fn,
        spec.make_curl_args,
        spec.make_job,
        vim.tbl_extend(
          "keep",
          SELECTED_PRESET.opts,
          vim.tbl_extend("force", {
            template_directory = TEMPLATE_DIRECTORY,
          }, options or {})
        )
      )
    end

    -- Keymapping setup
    local function setup_keymaps()
      local mappings = {
        { { "n", "v" }, "<leader>kdm", switch_presets, { desc = "switch between presets" } },
        {
          { "n", "v" },
          "<leader>kdb",
          function()
            invoke_llm_with_options()
          end,
          { desc = "Send current selection to LLM llm_fill" },
        },
        {
          { "n", "v" },
          "<leader>kdd",
          function()
            invoke_llm_with_options({ debug = true })
          end,
          { desc = "Send current selection to LLM debug" },
        },
      }

      for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], mapping[4])
      end

      vim.api.nvim_set_keymap("n", "<Esc>", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.api.nvim_exec_autocmds("User", { pattern = "LLM_Escape" })
        end,
      })
    end

    -- Initialize keymaps
    setup_keymaps()
  end,
}
