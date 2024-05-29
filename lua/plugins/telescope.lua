
return {
  {
  'nvim-telescope/telescope.nvim', 
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' }, 

  config = function()
  local builtin = require("telescope.builtin")
    -- KeyMappings ===========================
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
     vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  end
},

  {
 
'nvim-telescope/telescope-ui-select.nvim',
      config = function()
require("telescope").setup ({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})
require("telescope").load_extension("ui-select")

    end
  },

}

