return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.sources then
        return
      end

      opts.sources = vim.tbl_filter(function(source)
        local name = source.name or ""
        return name ~= "markdownlint" and name ~= "markdownlint_cli2"
      end, opts.sources)
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettier" }
      opts.formatters_by_ft["markdown.mdx"] = { "prettier" }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.eslint = vim.tbl_deep_extend("force", opts.servers.eslint or {}, {
        settings = {
          rulesCustomizations = {
            { rule = "max-len", severity = "off" },
          },
        },
      })

      opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
        init_options = {
          settings = {
            lint = {
              ignore = { "E501", "W505" },
            },
          },
        },
      })
    end,
  },
}
