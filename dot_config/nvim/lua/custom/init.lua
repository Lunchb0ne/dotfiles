-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

local autocmd = vim.api.nvim_create_autocmd

-- Configure to set the cursor to my initial cursor
autocmd("VimLeave", {
  pattern = "*",
  command = "set guicursor=a:ver25",
})
