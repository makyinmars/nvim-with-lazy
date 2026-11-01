-- neorex (Rex-native frontend) runs Neovim with --listen $TMPDIR/neorex-PID.nvim.sock and shows each window as an
-- external window in its own Rex pane. Neovim draws no per-window statuslines under laststatus=3, and lualine's
-- per-window mode skips external (float) windows. So keep lualine's global mode, which writes the current window's
-- statusline, and set laststatus back to 2 after lualine's setup forces 3.
local in_neorex = vim.v.servername:match("/neorex%-%d+%.nvim%.sock$") ~= nil

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      if vim.env.HERDR_ENV ~= "1" then
        return
      end

      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local ok, herdr = pcall(require, "herdr-context")
          return ok and herdr.statusline() or ""
        end,
        cond = function()
          return package.loaded["herdr-context"] ~= nil
        end,
      })
    end,
    config = in_neorex and function(_, opts)
      require("lualine").setup(opts)
      vim.o.laststatus = 2
    end or nil,
  },
}
