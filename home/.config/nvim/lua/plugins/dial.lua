return {
  {
    'monaqa/dial.nvim',
    keys = {
      { "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end,  desc = "Increment" },
      { "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end,  desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "Decrement" },
      { "<C-a>",  function() require("dial.map").manipulate("increment", "visual") end,  mode = "v",        desc = "Increment" },
      { "<C-x>",  function() require("dial.map").manipulate("decrement", "visual") end,  mode = "v",        desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "v",        desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "v",        desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      }
    end,
  }
}
