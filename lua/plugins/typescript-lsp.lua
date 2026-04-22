return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    -- Only use tsgo; disable the default LazyVim TypeScript server.
    opts.servers.vtsls = {
      enabled = false,
    }

    opts.servers.tsgo = opts.servers.tsgo or {}
    opts.servers.tsgo.root_dir = function(bufnr, on_dir)
      local root_markers = {
        "tsconfig.json",
        "tsconfig.base.json",
        "jsconfig.json",
        "package.json",
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "bun.lockb",
        "bun.lock",
        ".git",
      }

      local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
      local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
      local project_root = vim.fs.root(bufnr, root_markers)

      if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
        return
      end

      if deno_root and (not project_root or #deno_root >= #project_root) then
        return
      end

      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fallback_dir = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
      on_dir(project_root or fallback_dir)
    end

    -- htmx-lsp's upstream filetypes include JavaScript/TypeScript, which causes
    -- it to attach to normal TS buffers and compete with tsgo.
    opts.servers.htmx = vim.tbl_deep_extend("force", opts.servers.htmx or {}, {
      filetypes = {
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "clojure",
        "django-html",
        "htmldjango",
        "edge",
        "eelixir",
        "elixir",
        "ejs",
        "erb",
        "eruby",
        "gohtml",
        "gohtmltmpl",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "htmlangular",
        "html-eex",
        "heex",
        "jade",
        "leaf",
        "liquid",
        "markdown",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "slim",
        "templ",
        "twig",
      },
    })
  end,
}
