return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    -- LazyVim's TypeScript extra still defaults to vtsls; use the native TS 7 server.
    opts.servers.vtsls = {
      enabled = false,
    }

    -- Keep upstream root detection and the TypeScript 7+ binary version check.
    opts.servers.tsc = {}

    -- htmx-lsp's upstream filetypes include JavaScript/TypeScript, which causes
    -- it to attach to normal TS buffers and compete with tsc.
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
