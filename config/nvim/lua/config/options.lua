-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local spell_dir = vim.fn.stdpath("data") .. "/site/spell"
vim.opt.spellfile = {
  spell_dir .. "/en.utf-8.add",
  spell_dir .. "/pt.utf-8.add",
}

-- Right-click popup menu for mouse users.
vim.opt.mousemodel = "popup_setpos"
