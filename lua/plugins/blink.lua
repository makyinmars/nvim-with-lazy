-- Blink.cmp customizations (LazyVim handles most config via extras.coding.blink)
return {
  {
    "saghen/blink.cmp",
    -- Initialize before the first InsertEnter so manual signature help is ready.
    event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
    opts = {
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },
      sources = {
        providers = {
          buffer = {
            enabled = function()
              return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
            end,
          },
        },
      },
      -- Blink owns signature help; Noice still handles hover and messages.
      signature = { enabled = true },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Let Blink's preset handle this key instead of the built-in popup.
            { "<c-k>", false, mode = "i", desc = "Signature Help" },
          },
        },
      },
    },
  },
}
