return {
  -- Formatting: Biome (primary) + Prettier (fallback)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        json = { "biome" },
        jsonc = { "biome" },
        css = { "biome", "prettier", stop_after_first = true },
        graphql = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },

  -- LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        graphql = {
          filetypes = { "graphql", "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },
        eslint = {},
      },
    },
  },

  -- Mason: ensure tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "prettier",
        "eslint-lsp",
        "graphql-language-service-cli",
        "css-lsp",
        "tailwindcss-language-server",
      },
    },
  },

  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "json",
        "jsonc",
        "graphql",
        "html",
        "css",
        "sql",
        "lua",
        "markdown",
        "markdown_inline",
        "yaml",
        "bash",
        "regex",
      },
    },
  },
}
