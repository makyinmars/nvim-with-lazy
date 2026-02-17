return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.rust_analyzer = opts.servers.rust_analyzer or {}

    -- rust-analyzer can emit very noisy WARN logs on some workspaces.
    -- Keep diagnostics/completion enabled, but lower server-side log verbosity.
    opts.servers.rust_analyzer.cmd_env = vim.tbl_deep_extend("force", opts.servers.rust_analyzer.cmd_env or {}, {
      RA_LOG = "error",
    })
  end,
}
