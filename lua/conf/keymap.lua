local options = { noremap = true, silent = true }
local terminal_options = { silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Alt>", "<Nop>", options)
vim.g.mapleader = "Alt"
vim.g.maplocalleader = "Alt"


-- -- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- File Navigation
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", options)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", options)
keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", options)

-- Normal --
-- Navigate between windows (splitted)
keymap("n", "<C-h>", "<C-w>Left", options)
keymap("n", "<C-j>", "<C-w>Up", options)
keymap("n", "<C-k>", "<C-w>Down", options)
keymap("n", "<C-l>", "<C-w>Right", options)

-- Resize splited part with arrow
keymap("n", "<C-j>", ":resize +2<CR>", options)
keymap("n", "<C-k>", ":resize -2<CR>", options)
keymap("n", "<C-h>", ":vertical resize +2<CR>", options)
keymap("n", "<C-l>", ":vertical resize -2<CR>", options)

-- Navigate between buffers
keymap("n", "<S-l>", ":bnext<CR>", options)
keymap("n", "<S-h>", ":bprevious<CR>", options)

-- Escape in insert mode
keymap("i", "jk", "<ESC>", options)

-- Visual --
-- Stay in indent mode (insert tab)
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- Move visual selected block up and down
--keymap("v", "<S-Tab-j>", ":m .+1<CR>==", options)
--keymap("v", "<S-Tab-k>", ":m .-2<CR>==", options)
keymap("v", "p", '"_dP', options)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", options)
keymap("x", "K", ":move '<-2<CR>gv-gv", options)
--keymap("x", "<S-Tab-j>", ":move '>+1<CR>gv-gv", options)
--keymap("x", "<S-Tab-k>", ":move '<-2<CR>gv-gv", options)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal_options)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal_options)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal_options)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal_options)

-- Rust
keymap("n", "<S-A-l>", ":RustFmt<CR>", options)

