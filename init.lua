vim.o.number = true
vim.o.relativenumber = true
vim.cmd.colorscheme("catppuccin")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.opt.complete = vim.opt.complete + "k" --for path completion
vim.opt.path:append("**")
vim.opt.wildignore:append("*.o,*.obj,*.png,*.jpg,*.gif,node_modules/*")

-- WRITE file
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- QUIT Neovim
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit Neovim" })

-- KILL (close) current buffer
vim.keymap.set("n", "<leader>k", "<cmd>bd<cr>", { desc = "Kill buffer" })


-- Package Manager----------------------------------
vim.pack.add{
	'https://github.com/neovim/nvim-lspconfig.git',
	'https://github.com/stevearc/oil.nvim.git',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	--render markdown plugin
	'https://github.com/nvim-treesitter/nvim-treesitter',
    	'https://github.com/nvim-mini/mini.nvim',            -- if you use the mini.nvim suite
    	-- 'https://github.com/nvim-mini/mini.icons',        -- if you use standalone mini plugins
    	-- 'https://github.com/nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
   	'https://github.com/MeanderingProgrammer/render-markdown.nvim'
}

-- Oil is file explorer. use as :Oil  if you want to go to upper level use -
require("oil").setup()

-- Telescope setup and settings--------------------
require("telescope").setup({})
-- 3. Keymaps (AFTER setup)
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
-- ================================================

-- markdown link add:
local builtin = require("telescope.builtin")

local function insert_markdown_link()
  builtin.find_files({
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function open_and_insert()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not selection then return end

        local path = selection[1]

        -- extract filename for display text
        local name = vim.fn.fnamemodify(path, ":t")

        local md = string.format("[%s](%s)", name, path)

        vim.api.nvim_put({ md }, "c", false, true)
      end

      map("i", "<CR>", open_and_insert)
      map("n", "<CR>", open_and_insert)

      return true
    end,
  })
end

-- Insert markdown style link of file without adding [name](~/name) etc. Just leader ml
vim.keymap.set("n", "<leader>ml", insert_markdown_link, { desc = "Insert markdown link" })

-- go to file while on the link with gx
vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  vim.cmd("edit " .. file)
end, { desc = "Open file under cursor" })
