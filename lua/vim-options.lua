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

-- Map <Leader>r to compile and run the current Java file
vim.cmd('nnoremap <leader>r <Cmd>!javac % && java %<CR>')

-- Map <Leader>c to copy the full folder path of the current file
vim.cmd('nnoremap <leader>p :let @+=expand("%:p:h")<CR>')

-- Map <Leader>c to remove extra empty lines, keeping one
-- vim.cmd('nnoremap <leader>c :g/^$/s/\\n\\{2,}/\\r/g<CR>:nohlsearch<CR>') -- delete more than one empty lines and clear search remaining cursor signs
vim.cmd('nnoremap <leader>c :g/^$/s/\\n\\{2,}/\\r/g<CR>:nohlsearch<CR>gg=G<CR>') -- on top of above line, indent code also
