return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "python",
        "lua",
        "javascript",
        "java",          -- ✅ Java added here
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

