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
    vim.fn.expand("~/snippets"),
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


-- search current file markdown headers
vim.keymap.set("n", "<leader>mh", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local headings = {}

  for i, line in ipairs(lines) do
    local level, title = line:match("^(#+)%s+(.+)")
    if level and title then
      table.insert(headings, {
        text = string.rep("  ", #level - 1) .. title,
        lnum = i,
      })
    end
  end

  require("fzf-lua").fzf_exec(
    vim.tbl_map(function(h)
      return string.format("%s:%d", h.text, h.lnum)
    end, headings),
    {
      prompt = "Markdown headings> ",
      actions = {
        ["default"] = function(selected)
          local item = selected[1]
          local lnum = tonumber(item:match(":(%d+)$"))
          vim.api.nvim_win_set_cursor(0, { lnum, 0 })
        end,
      },
    }
  )
end, { desc = "Search Markdown headings in current file" })


-- search links and open with browser
vim.keymap.set("n", "<leader>gl", function()
  local file = vim.fn.expand("~/snippets/bookmarks")
  local lines = vim.fn.readfile(file)

  require("fzf-lua").fzf_exec(lines, {
    prompt = "Links> ",
    actions = {
      ["default"] = function(selected)
        local line = selected[1]

        -- extract URL before ;;
        local url = line:match("^(.-);;"):gsub("%s+", "")

        if url then
          vim.fn.jobstart({ "open", url }, { detach = true }) -- macOS
        end
      end,
    },
  })
end, { desc = "Search tagged links and open URL" })

-- cd into directories with leader + cd
vim.keymap.set("n", "<leader>cd", function()
  local cwd = vim.fn.getcwd()

  -- recursively list all directories under cwd
  local dirs = vim.fn.systemlist("fd --type d . " .. vim.fn.shellescape(cwd))

  require("fzf-lua").fzf_exec(dirs, {
    prompt = "Dirs> ",
    cwd = cwd,

    actions = {
      ["default"] = function(selected)
        local dir = selected[1]
        if not dir then return end

        vim.cmd("cd " .. vim.fn.fnameescape(dir))
        print("cd -> " .. dir)
      end,
    },
  })
end, { desc = "CD into any subdirectory (fzf)" })

-- edit files directly
vim.keymap.set("n", "<leader>ef", function()
  local files = {
    vim.fn.expand("~/notes/generalnotes/todo"),
    vim.fn.expand("~/snippets/bookmarks"),
    vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
  }

  require("fzf-lua").fzf_exec(files, {
    prompt = "Edit file> ",
    actions = {
      ["default"] = function(selected)
        local file = vim.fn.expand(selected[1])
        vim.cmd("edit " .. vim.fn.fnameescape(file))
      end,
    },
  })
end, { desc = "Open/Edit files directly " })

