-- map - key to open oil
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", {desc="Open parent directory in Oil"})

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>k", "<cmd>bdelete<CR>", { desc = "Kill current buffer" })

vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  vim.cmd("edit " .. file)
end, { desc = "Open file under cursor in nvim" })


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


-- search bookmarks file and open links in browser
vim.keymap.set("n", "<leader>ol", function()
  local file = vim.fn.expand("~/snippets/bookmarks")
  local lines = vim.fn.readfile(file)

  require("fzf-lua").fzf_exec(lines, {
    prompt = "Links> ",
    actions = {
      ["default"] = function(selected)
        local line = selected[1]
        local url = line:match("^(.-);;")
        
        if url then
          url = url:gsub("%s+", "")
          local command = nil

          if vim.fn.has("mac") == 1 then
            command = {"open", url}
          elseif vim.fn.executable("xdg-open") == 1 then
            command = {"xdg-open", url}
          else
            print("Error: No opener found (install xdg-utils?)")
            return
          end

          vim.fn.jobstart(command, { detach = true })
        else
          print("No URL found in line")
        end
      end,
    },
  })
end, { desc = "Search tagged links and open URL" })

-- edit files directly
vim.keymap.set("n", "<leader>ef", function()
  local files = {
    vim.fn.expand("~/notes/generalnotes/todo"),
    vim.fn.expand("~/snippets/bookmarks"),
    vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
    vim.fn.expand("~/snippets/.snippetrc"),
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


-- search and yank results from .snippetrc file
vim.keymap.set("n", "<leader>ys", function()
  local file = vim.fn.expand("~/snippets/.snippetrc")

  require("fzf-lua").fzf_exec(
    "rg --no-heading --line-number --column --smart-case {q} "
      .. vim.fn.shellescape(file)
      .. " || cat " .. vim.fn.shellescape(file),
    {
      prompt = "Snippet search> ",
      reload = true,
      actions = {
        ["default"] = function(selected)
          if not selected or #selected == 0 then return end

          local entry = selected[1]

          local text = entry:match("^[^:]+:%d+:%d+:(.*)$") or entry

          local before = text:match("^(.-)%s*;;")
          if not before then
            print("No ';;' found")
            return
          end

          vim.fn.setreg("+", before)
          print("Copied: " .. before)
        end,
      },
    }
  )
end, { desc = "Search snippet and copy before ;; to clipboard" })

vim.keymap.set("n", "<leader>jf", function()
  local target_folders = {
    "~/notes/",
    "~/.config/nvim/",
    "~/PlaywrightAutomation/",
  }

  -- Start with the base command
  local cmd = "printf '%s\n'"
  
  -- Append each path as a separate escaped argument
  for _, path in ipairs(target_folders) do
    cmd = cmd .. " " .. vim.fn.shellescape(vim.fn.expand(path))
  end

  require("fzf-lua").fzf_exec(cmd, {
    prompt = "Jump to folder> ",
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then return end
        local target_dir = selected[1]
        if vim.fn.isdirectory(target_dir) == 1 then
          vim.api.nvim_set_current_dir(target_dir)
          print("Changed directory to: " .. target_dir)
        else
          print("Error: Directory does not exist: " .. target_dir)
        end
      end,
    },
  })
end, { desc = "FZF: Jump to hardcoded project folders" })

