-- Default: no spell
vim.opt.spell = false

-- Languages
vim.opt.spelllang = { "en_us" }

-- Custom dictionary
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Enable only for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
