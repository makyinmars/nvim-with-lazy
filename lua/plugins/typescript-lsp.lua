return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    vim.list_extend(opts.inlay_hints.exclude, { "typescript", "typescriptreact" })
  end,
}
