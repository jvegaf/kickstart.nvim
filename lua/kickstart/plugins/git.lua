return {
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gwb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local gitsigns = require("gitsigns")
      local map = vim.keymap.set
      gitsigns.setup()

      map('n', '<leader>ghs', gitsigns.stage_hunk,{  desc = "Stage hunk" })
      map('n', '<leader>ghr', gitsigns.reset_hunk, {  desc = "Reset hunk" })
      map('v', '<leader>ghs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {  desc = "Stage hunk" })
      map('v', '<leader>ghr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {  desc = "Reset hunk" })
      map('n', '<leader>ghS', gitsigns.stage_buffer, {  desc = "Stage buffer" })
      map('n', '<leader>ghu', gitsigns.undo_stage_hunk, {  desc = "Undo stage hunk" })
      map('n', '<leader>ghR', gitsigns.reset_buffer,{  desc = "Reset buffer" })
      map('n', '<leader>ghp', gitsigns.preview_hunk, {  desc = "Preview hunk" })
      map('n', '<leader>ghb', function() gitsigns.blame_line{full=true} end, {  desc = "Blame line" })
      map('n', '<leader>ghl', gitsigns.toggle_current_line_blame,{  desc = "Toggle current line blame" })
      map('n', '<leader>ghd', gitsigns.diffthis, {  desc = "Diff this" })
      map('n', '<leader>ghD', function() gitsigns.diffthis('~') end, {desc = "Diff this" })

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = "Select hunk"})
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diff" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diff" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "View file history" },
      { "<leader>gf", ":'<,'>DiffviewFileHistory<cr>", mode = { "v" }, desc = "View selected history" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffText",
          current = "DiffAdd",
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
          vim.keymap.set("n", "cww", function()
            engage.conflict_buster()
            create_buffer_local_mappings()
          end)
        end,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "paopaol/telescope-git-diffs.nvim",
    },
    config = function()
      require("telescope").load_extension("git_diffs")
    end,
    keys = {
      { "<leader>gz", "<cmd>Telescope git_diffs  diff_commits<CR>", desc = "Telescope diff_commits" },
      { "<leader>gb", "<cmd>Telescope git_branches <CR>", desc = "Branches" },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false, -- disable by default, enabled only on keymap
      date_format = "%m/%d/%y %H:%M:%S", -- more concise date format
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<Leader>gm", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    -- See: https://github.com/TimUntersberger/neogit#configuration
    opts = {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    },
  },
}
