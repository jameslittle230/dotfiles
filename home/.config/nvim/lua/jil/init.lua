require("jil.settings")
require("jil.lazy")
require("jil.remaps")

-- Auto-reload config on save
local function reload_config()
  -- Clear cache for jil modules
  for name, _ in pairs(package.loaded) do
    if name:match('^jil') then
      package.loaded[name] = nil
    end
  end

  -- Re-source init
  dofile(vim.env.MYVIMRC)
  vim.notify("Config reloaded", vim.log.levels.INFO)
end

-- Watch for changes to config files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.stdpath("config") .. "/**/*.lua",
  callback = reload_config,
  desc = "Reload Neovim config on save",
})

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end
