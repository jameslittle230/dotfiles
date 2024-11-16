-- Reload neovim when the dotfiles file is saved
-- Yes, this doesn't work with lazy.nvim, but I still like having the behavior
local function reload_config()
  vim.fn.system('cd ~/Code/dotfiles && ./init.sh')
  vim.cmd('source ~/.config/nvim/init.lua')
  vim.notify("Ran init.sh and reloaded config", vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.expand("~/Code/dotfiles/home/.config/nvim/**/*.lua"),
  callback = reload_config,
  group = vim.api.nvim_create_augroup("AutoReloadConfig", { clear = true }),
  desc = "Reload Neovim config and run init script when any lua file in nvim config is saved"
})
