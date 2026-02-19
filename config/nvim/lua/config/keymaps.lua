-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function word_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local left = line:sub(1, col):match("[%w_%-]+$") or ""
  local right = line:sub(col + 1):match("^[%w_%-]+") or ""
  local word = left .. right

  if word == "" then
    word = vim.fn.expand("<cword>")
  end
  return word
end

local function add_word_to_ltex(word)
  local changed_any = false
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.name == "ltex" then
      local settings = vim.deepcopy(client.config.settings or {})
      settings.ltex = settings.ltex or {}
      settings.ltex.dictionary = settings.ltex.dictionary or {}

      local changed = false
      for _, lang in ipairs({ "en-US", "pt-BR" }) do
        settings.ltex.dictionary[lang] = settings.ltex.dictionary[lang] or {}
        if not vim.tbl_contains(settings.ltex.dictionary[lang], word) then
          table.insert(settings.ltex.dictionary[lang], word)
          changed = true
        end
      end

      if changed then
        client.config.settings = settings
        client.notify("workspace/didChangeConfiguration", { settings = settings })
        changed_any = true
      end
    end
  end
  return changed_any
end

vim.api.nvim_create_user_command("SpellAddWord", function()
  local m = vim.fn.getmousepos()
  if m and m.winid and m.winid ~= 0 and vim.api.nvim_win_is_valid(m.winid) then
    vim.api.nvim_set_current_win(m.winid)
    local row = math.max(m.line or 1, 1)
    local col = math.max((m.column or 1) - 1, 0)
    pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
  end

  local word = word_under_cursor()
  if not word or word == "" then
    vim.notify("No word found under cursor", vim.log.levels.WARN)
    return
  end

  vim.cmd("silent! spellgood " .. vim.fn.fnameescape(word))
  local ltex_updated = add_word_to_ltex(word)
  local suffix = ltex_updated and " (LTeX updated)" or ""
  vim.notify(('Added "%s" to dictionary%s'):format(word, suffix))
end, { desc = "Add word under cursor to spell dictionary" })

vim.keymap.set("n", "<leader>ua", "<cmd>SpellAddWord<cr>", { desc = "Add word to dictionary" })

-- Right-click popup menu entry.
vim.cmd([[silent! aunmenu PopUp.Add\ to\ dictionary]])
vim.cmd([[nnoremenu 10.500 PopUp.Add\ to\ dictionary :SpellAddWord<CR>]])
vim.cmd([[inoremenu 10.500 PopUp.Add\ to\ dictionary <C-o>:SpellAddWord<CR>]])
vim.cmd([[vnoremenu 10.500 PopUp.Add\ to\ dictionary <Esc>:SpellAddWord<CR>]])
