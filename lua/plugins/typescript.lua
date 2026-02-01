return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    -- Register tsgo since it's not in lspconfig defaults yet
    if not configs.tsgo then
      configs.tsgo = {
        default_config = {
          cmd = { "tsgo", "lsp" },
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
          root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
        },
      }
    end

    -- Disable vtsls, enable tsgo
    opts.servers = opts.servers or {}
    opts.servers.vtsls = { enabled = false }
    opts.servers.tsgo = {}
  end,
}
