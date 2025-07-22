return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup Mason LSP config
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls" },
        automatic_installation = true,
      })

      -- Manual setup for lua_ls
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- 🔧 Manual setup for jdtls (Java) with platform-agnostic path
      local jdtls_path = vim.fn.exepath("jdtls")
      if jdtls_path == "" then
        vim.notify("jdtls not found in PATH", vim.log.levels.ERROR)
        return
      end

      lspconfig.jdtls.setup({
        cmd = { jdtls_path },
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
        end,
        capabilities = capabilities,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Keymaps for LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "v", vim.lsp.buf.code_action, {})
    end,
  },
}

