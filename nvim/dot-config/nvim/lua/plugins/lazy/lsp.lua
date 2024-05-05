return { {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspzero = require("lsp-zero")
    lspzero.on_attach(function(_, bufnr)
      lspzero.default_keymaps({ buffer = bufnr })
    end)

    local lspconfig = require("lspconfig")
    lspconfig.pyright.setup({})
    lspconfig.gopls.setup({})
    lspconfig.lua_ls.setup({})
  end
}, {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 5000,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" },
        ["_"] = { "trim_whitespace" },
      },
    })
  end,
} }
