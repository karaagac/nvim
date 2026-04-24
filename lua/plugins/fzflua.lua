return{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  opts = {
        -- This applies specifically to the 'files' picker
    files = {
      formatter = "path.dirname_first",
    },
    -- If you want it to apply to 'git_files' as well, add it there:
    git_files = {
      formatter = "path.dirname_first",
    },
  },
  keys = {
    {
      "<leader>ff", function()  require('fzf-lua').files() end,
      desc = "Find files in current working directorys"
    },
    { -- find files in ~/notes directory 
      "<leader>fn", function()  require('fzf-lua').files({cwd='~/notes'}) end,
      desc = "Find files in notes folder"
    },
--  { -- find files in ~/dotfiles directory 
--    "<leader>fd", function()  require('fzf-lua').files({cwd='~/dotfiles'}) end,
--    desc = "Find files in ~/dotfiles folder"
--  },
    { -- General live grep
      "<leader>fg", function()  require('fzf-lua').live_grep() end,
      desc = "Live grep current working directorys"
    },
    { -- Grep all files in ~/notes
      "<leader>sn", function()  require('fzf-lua').live_grep({cwd='~/notes'}) end,
      desc = "Live grep notes"
    },
    { -- Grep all files in ~/PlaywrightAutomation
      "<leader>sp", function()  require('fzf-lua').live_grep({cwd='~/PlaywrightAutomation/tests/'}) end,
      desc = "Live grep playwright automation framework"
    },
    -- ===========Other Functions===============================
    { -- Find Keymappings
      "<leader>fk", function()  require('fzf-lua').keymaps()
      end,
      desc = "Find Keymappings"
    },
    { -- Find current word
      "<leader>fw", function()  require('fzf-lua').grep_cword()
      end,
      desc = "Find current word"
    },
    { -- Find current WORD
      "<leader>fW", function()  require('fzf-lua').grep_cWORD()
      end,
      desc = "Find current WORD"
    },
    { -- Resume search
      "<leader>fr", function()  require('fzf-lua').resume()
      end,
      desc = "Resume your search"
    },
    { -- List recently opened files
      "<leader>fo", function()  require('fzf-lua').oldfiles()
      end,
      desc = "List recently opened files"
    },
    { -- open buffers
      "<leader><leader>", function()  require('fzf-lua').buffers()
      end,
      desc = "Open buffered files"
    },
    { -- Search/live grep current file 
      "<leader>/", function()  require('fzf-lua').lgrep_curbuf()
      end,
      desc = "Live grep/search current buffer"
    },
    -- choose file name or path to copy
    {
      "<leader>cc",
      function()
        local parent = vim.fn.expand("%:p:h:t")
        local file = vim.fn.expand("%:t")
        local file_no_ext = vim.fn.expand("%:t:r")

        local items = {
          "parent-folder",
          "filename",
          "filename-no-ext",
          "parent/filename",
          "javac + java command",
        }

        local function get_value(choice)
          if choice == "parent-folder" then
            return parent
          elseif choice == "filename" then
            return file
          elseif choice == "filename-no-ext" then
            return file_no_ext
          elseif choice == "parent/filename" then
            return parent .. "/" .. file
          elseif choice == "javac + java command" then
            return string.format(
              "javac %s/%s.java && java %s.%s",
              parent,
              file_no_ext,
              parent,
              file_no_ext
            )
          end
        end

        require("fzf-lua").fzf_exec(items, {
          prompt = "Copy file info > ",

          -- 👇 preview shows ONLY what will be copied
          preview = function(choice)
            local value = get_value(choice[1])
            return "Will copy:\n\n" .. value
          end,

          actions = {
            ["default"] = function(selected)
              local choice = selected[1]
              local result = get_value(choice)

              vim.fn.setreg("+", result)
              print("Copied: " .. result)
            end,
          },
        })
      end,
      desc = "Copy file info with preview"
    }
  }
}
