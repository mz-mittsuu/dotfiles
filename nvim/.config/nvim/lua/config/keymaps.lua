-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ==================================================
-- @file keymaps.lua
-- @brief Neovim keymaps
-- ==================================================

local keymap = vim.keymap.set

-- --------------------------------------------------
-- search
-- --------------------------------------------------
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- --------------------------------------------------
-- insert mode
-- --------------------------------------------------
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
keymap("i", "kj", "<Esc>", { desc = "Exit insert mode with kj" })

-- --------------------------------------------------
-- wrapped line movement
-- --------------------------------------------------
keymap("n", "j", "gj", { noremap = true, silent = true, desc = "Down visual line" })
keymap("n", "k", "gk", { noremap = true, silent = true, desc = "Up visual line" })

-- --------------------------------------------------
-- line movement
-- --------------------------------------------------
keymap({ "n", "x" }, "H", "g0", { noremap = true, silent = true, desc = "Start of visual line" })
keymap({ "n", "x" }, "L", "g$", { noremap = true, silent = true, desc = "End of visual line" })
