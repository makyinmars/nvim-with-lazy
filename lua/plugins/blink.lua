-- Blink.cmp customizations (LazyVim handles most config via extras.coding.blink)
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
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
    -- Enable signature help
    signature = { enabled = true },
    -- Custom keymap overrides
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
      ["<C-n>"] = { "select_next" },
      ["<C-p>"] = { "select_prev" },
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
    },
  },
}
