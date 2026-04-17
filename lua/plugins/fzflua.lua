return{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  opts = {},
  ---@diagnostic enable: missing-fields
  keys = {
    {
      "<leader>ff", function()  require('fzf-lua').files() end,
      desc = "Find files in current working directorys"
    },
-- { -- find files in ~/notes directory 
--   "<leader>fn", function()  require('fzf-lua').files({cwd='~/notes'}) end,
--   desc = "Find files in notes folder"
-- },
--  { -- find files in ~/dotfiles directory 
--    "<leader>fd", function()  require('fzf-lua').files({cwd='~/dotfiles'}) end,
--    desc = "Find files in ~/dotfiles folder"
--  },
    { -- General live grep
      "<leader>fg", function()  require('fzf-lua').live_grep() end,
      desc = "Live grep current working directorys"
    },
--  { -- Grep all files in ~/notes
--    "<leader>fn", function()  require('fzf-lua').live_grep({cwd='~/notes'}) end,
--    desc = "Live grep notes"
--  },
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
    { -- copy current file path
      "<leader>fp",
      function()
        local path = vim.fn.expand("%:p:~")
        vim.fn.setreg("+", path)
        print("Copied: " .. path)
      end,
      desc = "Copy full file path"
    }
  }
}
