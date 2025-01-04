return {
  'kylechui/nvim-surround',
  -- Load the plugin immediately since it provides keymaps
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        -- Add pipe surround configuration
        ["|"] = {
          add = { "|", "|" },
          delete = "^(.)().-(.)()$",
        },

        ["s"] = {
          add = function()
            local ts_utils = require("nvim-treesitter.ts_utils")
            local cur = ts_utils.get_node_at_cursor(0, true)
            local language = vim.bo.filetype
            local is_jsy = (
              language == "javascript"
              or language == "javascriptreact"
              or language == "typescript"
              or language == "typescriptreact"
            )

            if is_jsy then
              local cur_type = cur:type()
              local interpolation_surround = { { "${" }, { "}" } }
              if cur and (cur_type == "string" or cur_type == "string_fragment") then
                vim.cmd.normal("csq`")
                return interpolation_surround
              elseif cur and cur_type == "template_string" then
                return interpolation_surround
              else
                return { { "`${" }, { "}`" } }
              end
            end
          end,
        },
      }
    })
  end
}
