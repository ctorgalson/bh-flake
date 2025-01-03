vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.colorcolumn = '80'
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.shiftwidth = 2
vim.o.signcolumn = 'yes'
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.updatetime = 300
vim.wo.number = true

-- It should be possible to configure these plugins in their own files.
--
-- @todo: get this plugin-specific config out of htere.
--
-- Toggle Neotree.
vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { desc = "Toggle file browser", remap = false })

-- Configure Telescope.
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Search for files" })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search in files" })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search in open buffers" })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search Neovim help" })

-- Move between and resize panes.
--
-- @see https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/config/keymaps.lua#L15
--
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
