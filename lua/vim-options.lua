-- Set tab settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable absolute line numbers
vim.cmd("set number")              -- Show absolute line numbers

-- Set leader key
vim.g.mapleader = " "

-- Map the quit without saving command to <Leader>q
vim.cmd('nnoremap <leader>q <Cmd>q!<CR>')

-- Map the kill current buffer command to <Leader>k
vim.cmd('nnoremap <leader>k <Cmd>bd<CR>')

-- Map the write command to <Leader>w
vim.cmd('nnoremap <leader>w <Cmd>w<CR>')

-- Map <Leader>r to compile and run the current Java file
vim.cmd('nnoremap <leader>r <Cmd>!javac % && java %<CR>')
