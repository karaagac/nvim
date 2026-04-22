return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp", -- IMPORTANT: LSP bridge
  },

  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- how completion window behaves
      completion = {
        completeopt = "menu,menuone,noselect",
      },

      -- key mappings inside completion menu
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),

        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
      }),

      -- SOURCES (THIS IS THE CRITICAL PART YOU WERE MISSING)
      sources = {
        { name = "nvim_lsp" }, -- 🔥 THIS enables LSP autocomplete
        { name = "buffer" },   -- words from open files
        { name = "path" },     -- filesystem paths
      },
    })
  end,
}
