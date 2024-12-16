-- lua/custom/java_api_search.lua
local M = {}

-- Define a function to search through local Java API docs and open in Safari
M.search_java_api_docs = function()
  -- Set the directory where your local API documentation is stored
  local doc_dir = '/Users/xalil/Documents/docs/api/'

  -- Ensure the directory exists
  if vim.fn.isdirectory(doc_dir) == 0 then
    print("Error: Directory not found: " .. doc_dir)
    return
  end

  -- Use Telescope's `find_files` to search for HTML files in the API docs directory
  require('telescope.builtin').find_files({
    prompt_title = "Search Java API Docs",
    search_dirs = { doc_dir },  -- Set the directory to search in
    find_command = {'find', '.', '-type', 'f', '-name', '*.html'},  -- Find only HTML files
    attach_mappings = function(prompt_bufnr, map)
      -- Map to open the selected file in Safari
      local actions = require("telescope.actions")
      map("i", "<CR>", function()
        local selection = require("telescope.actions.state").get_selected_entry()
        local file_path = selection.path

        -- Open the selected file in Safari
        vim.fn.jobstart({ "open", "-a", "Firefox", file_path }, {
          detach = true,  -- Don't block Neovim while opening
        })

        -- Close the Telescope window
        actions.close(prompt_bufnr)
      end)

      return true
    end,
  })
end

return M
