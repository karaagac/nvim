-- map - key to open oil
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", {desc="Open parent directory in Oil"})

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>k", "<cmd>bdelete<CR>", { desc = "Kill current buffer" })
