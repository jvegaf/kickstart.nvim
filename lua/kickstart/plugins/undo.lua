return {
  {
    "tzachar/highlight-undo.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      })
      require("telescope").load_extension("undo")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
    keys = {
      { "<leader>cu", "<cmd>Telescope undo<cr>", desc = "Undotree" },
    },
  },
}
