local bo = vim.bo
-- local keymap = vim.keymap
local NS = { noremap = true, silent = true }
-- local jdtls, status = pcall(require, "jdtls")
-- if not status then
--   return
-- end

bo.tabstop = 4
bo.shiftwidth = 4
bo.expandtab = false

-- keymap.set("n", "<leader>lo", jdtls.organize_imports(), NS)

-- keymap.set("n", "<leader>lu", jdtls.update_projects_config(), NS)

-- keymap.set("n", "<leader>tc", jdtls.test_class(), NS)

-- keymap.set("n", "<leader>tm", jdtls.test_nearest_method(), NS)
