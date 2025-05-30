return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     capabilities = {
  --       textDocument = {
  --         foldingRange = {
  --           dynamicRegistration = false,
  --           lineFoldingOnly = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      "luukvbaal/statuscol.nvim",
    },
    opts = {},
    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
}
