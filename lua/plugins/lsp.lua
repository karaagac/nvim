return {
  "neovim/nvim-lspconfig",
  config = function()
    -- 🔥 IMPORTANT: enables nvim-cmp integration
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- JavaScript / TypeScript
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("ts_ls")

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    -- Bash
    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("bashls")

    -- ☕ Java (JDTLS)
    vim.lsp.config("jdtls", {
      capabilities = capabilities,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
        },
      },
    })
    vim.lsp.enable("jdtls")
  end,
}
