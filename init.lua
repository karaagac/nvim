-- https://www.youtube.com/watch?v=4zyZ3sw_ulc&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts={}

require("vim-options")
require("lazy").setup("plugins")

-- make tab 4 spaces
vim.opt.shiftwidth = 4

-- Enable system clipboard integration
vim.opt.clipboard:append("unnamedplus")

-- Set ignorecase for case-insensitive search
vim.o.ignorecase = true

-- Optionally, disable smartcase for strict case-insensitivity
vim.o.smartcase = false

vim.opt.wrap = true        -- Enable line wrapping
vim.opt.linebreak = true   -- Break lines at word boundaries
vim.opt.list = false       -- Ensure 'list' mode is off

-- Create an augroup for auto-indentation
vim.api.nvim_create_augroup("AutoIndent", { clear = true })

-- =======================================
-- Load the Java runner Lua module (Make sure the path is correct)
local java_runner = require('custom.java_runner')

-- Command to run Java with floating output
vim.api.nvim_create_user_command('RunJavaWithFloatingOutput', java_runner.compile_and_run_java_with_floating_output, {})

-- Keybinding (e.g., <leader>rf to run Java)
vim.api.nvim_set_keymap('n', '<leader>rf', ':lua require("custom.java_runner").compile_and_run_java_with_floating_output()<CR>', { noremap = true, silent = true })

-- search local java doc api files
local java_api_search = require('custom.java_api_search')  -- Adjust to your path

-- Map leader+d to search Java API docs
vim.keymap.set('n', '<leader>d', java_api_search.search_java_api_docs, { desc = "Search Java API Docs" })

-- Quickfix related

-- Map Ctrl+n to :cnext (next quickfix item)
vim.api.nvim_set_keymap('n', '<C-n>', ':cnext<CR>', { noremap = true, silent = true })

-- Map Ctrl+p to :cprev (previous quickfix item)
vim.api.nvim_set_keymap('n', '<C-p>', ':cprev<CR>', { noremap = true, silent = true })

-- ==========================================
-- Auto-indentation on file save with the cursor restored to original position
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "AutoIndent",   -- You can define a group for this autocmd
  pattern = "*",          -- Apply this to all file types
  callback = function()
    -- Restore the cursor to its original position after saving
    local current_cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, current_cursor_pos)
  end
})
-- ==========================================
