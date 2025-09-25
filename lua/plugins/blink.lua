return {
  "saghen/blink.cmp",
  opts = {
    snippets = {
      expand = function(snippet, _)
        return LazyVim.cmp.expand(snippet)
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    sources = {
      default = { "lsp", "path", "luasnip", "buffer" },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink.compat.source",
        },
      },
    },
    keymap = {
      preset = "none", -- Disable default keymaps to use custom ones
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-l>"] = {
        function(cmp)
          local luasnip = require("luasnip")
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            return cmp.fallback()
          end
        end,
        "fallback",
      },
      ["<C-h>"] = {
        function(cmp)
          local luasnip = require("luasnip")
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            return cmp.fallback()
          end
        end,
        "fallback",
      },
    },
  },
}