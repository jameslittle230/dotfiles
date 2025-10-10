return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "fade_in_slide_out",
    render = "compact",
    top_down = false,
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
