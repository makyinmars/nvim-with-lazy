return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxlint = {
          settings = { fixKind = "safe" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Use the project's Oxfmt config and binary, without formatting unrelated projects.
      opts.formatters.oxfmt = vim.tbl_deep_extend("force", opts.formatters.oxfmt or {}, {
        require_cwd = true,
        cwd = require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
      })

      local filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "json5",
        "css",
        "scss",
        "less",
        "html",
        "vue",
        "svelte",
        "astro",
        "graphql",
        "markdown",
        "markdown.mdx",
        "yaml",
        "toml",
      }

      for _, filetype in ipairs(filetypes) do
        local fallback = opts.formatters_by_ft[filetype] or {}
        opts.formatters_by_ft[filetype] = function(bufnr)
          -- A configured Oxfmt project gets one formatter, even when other extras are enabled.
          if require("conform").get_formatter_info("oxfmt", bufnr).available then
            return { "oxfmt" }
          end
          return type(fallback) == "function" and fallback(bufnr) or fallback
        end
      end
    end,
  },
}
