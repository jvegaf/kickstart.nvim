return {
  "akinsho/nvim-toggleterm.lua",
  lazy = false,
  branch = "main",
  keys = {
    { "<M-1>", "<Cmd>1ToggleTerm direction=vertical size=80<Cr>", desc = "Terminal #1", mode = { "t", "n" } },
    { "<M-2>", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2", mode = { "t", "n" } },
    { "<M-3>", "<Cmd>3ToggleTerm direction=horizontal<Cr>", desc = "Terminal #3", mode = { "t", "n" } },
  },
  config = function()
    local is_win = vim.loop.os_uname().sysname == "Windows_NT"

    if is_win then
      local powershell_options = {
        shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end
    end

    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<A-0>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      winbar = {
        enabled = true,
      },
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
  end,
}
