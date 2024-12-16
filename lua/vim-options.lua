-- Set tab settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable relative line numbers
vim.cmd("set relativenumber")

-- Set leader key
vim.g.mapleader = " "

-- Map the quit without saving command to <Leader>q
vim.cmd('nnoremap <leader>q <Cmd>q!<CR>')

-- Map the kill current buffer command to <Leader>k
vim.cmd('nnoremap <leader>k <Cmd>bd<CR>')

-- Map the write command to <Leader>w
vim.cmd('nnoremap <leader>w <Cmd>w<CR>')

-- Map the open current buffer in Eclipse command to <Leader>o
vim.cmd('nnoremap <leader>o <Cmd>!open -a "Eclipse Java" %<CR>')

-- Compile the current Java file
vim.cmd('nnoremap <leader>c <Cmd>w !javac %<CR>')

-- Run the current Java file
vim.cmd('nnoremap <leader>r <Cmd>w !java %:r<CR>')

-- copy full path of current file
vim.api.nvim_set_keymap('n', '<leader>p', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })
