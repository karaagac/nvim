-- Set tab settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable relative line numbers
vim.cmd("set relativenumber")

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
vim.cmd('nnoremap <leader>r <Cmd>w !java %<CR>')

-- copy full path of current file
vim.api.nvim_set_keymap('n', '<leader>p', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })

-- format the documents
vim.keymap.set("n", "<leader>df", function()
 vim.lsp.buf.format()
end, { noremap = true, silent = true, desc = "Format Code" })

-- Quickfix related

-- Map Ctrl+n to :cnext (next quickfix item)
vim.api.nvim_set_keymap('n', '<C-n>', ':cnext<CR>', { noremap = true, silent = true })

-- Map Ctrl+p to :cprev (previous quickfix item)
vim.api.nvim_set_keymap('n', '<C-p>', ':cprev<CR>', { noremap = true, silent = true })
