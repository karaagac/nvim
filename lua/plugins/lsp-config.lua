return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()  -- Setup Mason (no need for additional options here)
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      -- Setup mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls" },  -- Install the LSP servers we need
      })

      -- Hook Mason with nvim-lspconfig
      require("mason-lspconfig").setup_handlers({
        -- Default handler to configure LSP servers
        function(server_name)
          local lspconfig = require("lspconfig")
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- Setup LSP server (lua_ls)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Custom handler for `jdtls` (Java LSP server)
        ["jdtls"] = function()
          local lspconfig = require("lspconfig")

          -- Manually define capabilities for Java (optional)
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- Setup JDTLS server with the correct cmd and root_dir
          lspconfig.jdtls.setup({
            cmd = { '/run/current-system/sw/bin/jdtls' },  -- Path to jdtls
            root_dir = function(fname)
              return vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
            end,
            capabilities = capabilities,
          })
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Setup Lua LSP (using Mason configuration)
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',  -- or 'Lua 5.1' if you're using that
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          }
        }
      })

      -- You can add keymaps for LSP functions here
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'v', vim.lsp.buf.code_action, {})
    end,
  },

}
