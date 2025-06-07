local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.add({
  { "<leader>C", group = "Typescript" },
  { "<leader>Ci", "<cmd>VtsExec add_missing_imports<Cr>", "Add Missing Imports" },
  { "<leader>Co", "<cmd>VtsExec organize_imports<Cr>", "Organize Imports" },
  { "<leader>Cu", "<cmd>VtsExec remove_unused<Cr>", "Remove Unused" },
  { "<leader>Cr", "<cmd>VtsExec rename_file<Cr>", "Rename File" },
  { "<leader>Cf", "<cmd>VtsExec fix_all<Cr>", "FixAll" },
  { "<leader>Cg", "<cmd>VtsExec goto_source_definition<Cr>", "GoToSourceDefinition" },
  { "<leader>CR", "<cmd>VtsExec file_references<Cr>", "Find File References" },
})
