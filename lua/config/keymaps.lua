vim.g.have_nerd_font = true

vim.keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<leader>za", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "<leader>zc", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "<leader>zo", "zR", { desc = "Open all folds" })
vim.keymap.set("v", "<leader>zf", "zf", { desc = "Create fold from selection" })
