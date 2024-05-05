return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- A list of parser names, or "all"
    ensure_installed = {
      'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
      'typescript', 'vim', 'go', 'rust'
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
}
