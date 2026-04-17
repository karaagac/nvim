-- map - key to open oil
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", {desc="Open parent directory in Oil"})

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>k", "<cmd>bdelete<CR>", { desc = "Kill current buffer" })

vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  vim.cmd("edit " .. file)
end, { desc = "Open file under cursor in nvim" })


-- cd into below folders
vim.keymap.set("n", "gf", function()
  local dirs = {
    vim.fn.expand("~/Documents"),
    vim.fn.expand("~/dotfiles"),
    vim.fn.expand("~/Desktop"),
    vim.fn.expand("~/Downloads"),
    vim.fn.expand("~/.config/nvim"),
    vim.fn.expand("~/notes"),
  }

  require("fzf-lua").fzf_exec(dirs, {
    prompt = "CD to folder> ",
    actions = {
      ["default"] = function(selected)
        local dir = vim.fn.expand(selected[1])
        vim.cmd("cd " .. vim.fn.fnameescape(dir))
        print("cd → " .. dir)
      end,
    },
  })
end, { desc = "Fuzzy cd into predefined folders" })

-- use q to quit in Oil floating window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, desc = "Close Oil float" })
  end,
})
