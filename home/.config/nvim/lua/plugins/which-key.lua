return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    icons = {
      mappings = false,
      keys = {
        Up = "↑ ",
        Down = "↓ ",
        Left = "← ",
        Right = "→ ",
        C = "C-",
        M = "M-",
        D = "D-",
        S = "S-",
        CR = "↵ ",
        Esc = "⎋ ",
        ScrollWheelDown = "⊝ ", -- wheel down symbol
        ScrollWheelUp = "⊕ ", -- wheel up symbol
        NL = "↵ ",
        BS = "⌫ ",
        Space = "␣ ",
        Tab = "⇥ ",
        F1 = "F1",
        F2 = "F2",
        F3 = "F3",
        F4 = "F4",
        F5 = "F5",
        F6 = "F6",
        F7 = "F7",
        F8 = "F8",
        F9 = "F9",
        F10 = "F10",
        F11 = "F11",
        F12 = "F12",
      },
    }
  },
  keys = {
    { "<leader>s", group = "search" },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  }
}
