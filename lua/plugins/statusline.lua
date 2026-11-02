-- neorex (Rex-native frontend) runs Neovim with --listen $TMPDIR/neorex-PID.nvim.sock and shows each window as an
-- external window in its own Rex pane. Neovim draws no per-window statuslines under laststatus=3, and lualine's
-- per-window mode skips external (float) windows. So keep lualine's global mode, which writes the current window's
-- statusline, and set laststatus back to 2 after lualine's setup forces 3.
local in_neorex = vim.v.servername:match("/neorex%-%d+%.nvim%.sock$") ~= nil

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    config = in_neorex and function(_, opts)
      require("lualine").setup(opts)
      vim.o.laststatus = 2
    end or nil,
  },
}
