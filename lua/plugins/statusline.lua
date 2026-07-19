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
  },
}
