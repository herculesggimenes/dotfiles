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
        -- JavaScript / TypeScript
        vtsls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },
        -- Python
        pyright = {},
        -- Markdown structure/links
        marksman = {},
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
        "vtsls",
        "typescript-language-server",
        "pyright",
        "marksman",
        "eslint-lsp",
        "graphql-language-service-cli",
        "css-lsp",
        "tailwindcss-language-server",
      },
    },
  },

  -- Make sure the LSP server entries are installed by Mason.
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "pyright",
        "marksman",
        "eslint",
        "graphql",
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
        "python",
        "markdown",
        "markdown_inline",
        "yaml",
        "bash",
        "regex",
      },
    },
  },
}
