-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap({ 'n', 'v' }, '<space>', '<nop>', opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--keymap("n", "q", "h", {silent=true})
--keymap("n", "x", "l", {silent=true})
--keymap("v", "x", "l", {silent=true})
--keymap("v", "x", "l", {silent=true})

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Center searches
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Navigate lines
keymap("n", "<S-l>", "$", opts)
keymap("n", "<S-h>", "^", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Clear highlights
keymap("n", "<c-h>", "<cmd>nohlsearch<CR>", opts)

-- Fast switch buffers
keymap("n", "<leader><space>", "<cmd>b#<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>bw<CR>", opts)

-- Reload vim config
keymap("n", "<leader>R", "<cmd>lua ReloadConfig()<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Git
--keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- DAP
--keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
--keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
--keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
--keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
--keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
--keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
--keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
--keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
--keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
