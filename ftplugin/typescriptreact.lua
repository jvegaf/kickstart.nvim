local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.add({
  { "<leader>C", group = "TypescriptReact" },
  { "<leader>Ci", "<cmd>VtsExec add_missing_imports<Cr>", "Add Missing Imports" },
  { "<leader>Co", "<cmd>VtsExec organize_imports<Cr>", "Organize Imports" },
  { "<leader>Cu", "<cmd>VtsExec remove_unused<Cr>", "Remove Unused" },
  { "<leader>Cr", "<cmd>VtsExec rename_file<Cr>", "Rename File" },
  { "<leader>Cf", "<cmd>VtsExec fix_all<Cr>", "FixAll" },
  { "<leader>Cg", "<cmd>VtsExec goto_source_definition<Cr>", "GoToSourceDefinition" },
  { "<leader>CR", "<cmd>VtsExec file_references<Cr>", "Find File References" },
}

  -- Automatically end a self-closing tag when pressing /
vim.keymap.set("i", "/", function()
  local node = vim.treesitter.get_node()
  if not node then
    return "/"
  end

  if node:type() == "jsx_opening_element" then
    local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 2), 0, 1)
    local already_have_space = char_at_cursor == " "

    return already_have_space and "/>" or " />"
  end

  return "/"
end, { expr = true, buffer = true }))
