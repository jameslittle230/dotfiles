return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffer" },
      { "<leader>d", group = "diagnostics" },
      { "<leader>e", group = "explorer" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>m", group = "marks" },
      { "<leader>t", group = "treesitter" },
      { "<leader>s", group = "search" },
      { "<leader>w", group = "window" },
      { "<leader>z", group = "lazy" },
    },
    preset = "helix",
    sort = { "alphanum", "local", "order", "group", "mod" },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  }
}
