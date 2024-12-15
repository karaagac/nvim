return {
  -- nvim-cmp and its dependencies
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',   -- Required for LSP completion
    'hrsh7th/cmp-buffer',     -- Buffer completion
    'hrsh7th/cmp-path',       -- Path completion
    'hrsh7th/cmp-cmdline',    -- Cmdline completion
    'hrsh7th/cmp-vsnip',      -- For vsnip users (snippets)
    'hrsh7th/vim-vsnip',      -- vsnip plugin (for snippets)
    'onsails/lspkind.nvim',   -- Add this for LSP kind icons
    -- 'L3MON4D3/LuaSnip',     -- Uncomment if using LuaSnip
    -- 'saadparwaiz1/cmp_luasnip', -- Uncomment if using LuaSnip for snippets
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')  -- Optional, if you want to show icons

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)  -- For vsnip users. Replace with `luasnip` if you use LuaSnip
          -- require('luasnip').lsp_expand(args.body) -- For LuaSnip users
        end,
      },
      window = {
        -- Uncomment the following if you want to use bordered windows
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),  -- Manually trigger completion
        ['<C-e>'] = cmp.mapping.abort(),         -- Abort completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm current selection
        ['<Tab>'] = cmp.mapping.select_next_item(),         -- Select next item
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),       -- Select previous item
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },   -- LSP completions
        { name = 'vsnip' },      -- Vsnip for snippets
        -- { name = 'luasnip' },  -- Uncomment for LuaSnip
      }, {
        { name = 'buffer' },     -- Buffer completions
      }),
      -- Optional: show icons for completion items (e.g., symbols, methods, etc.)
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- 'symbol', 'text', 'symbol_text'
          maxwidth = 50,   -- Max width of icons
          ellipsis_char = '...',
        })
      }
    })

    -- Set up LSP integration with nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace with your actual LSP server setups
    require('lspconfig')['lua_ls'].setup {
      capabilities = capabilities
    }
    require('lspconfig')['jdtls'].setup {
      capabilities = capabilities
    }

    -- Set up cmdline completion for `/`, `?`, and `:` (search, command-line, path completion)
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      }
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },      -- Path completion
      }, {
        { name = 'cmdline' },   -- Cmdline completion
      })
    })
  end,
}
