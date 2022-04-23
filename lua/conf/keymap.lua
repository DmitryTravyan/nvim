local nr_options = { noremap = true, silent = true }

local terminal_options = { silent = true }

local nr_map = vim.api.nvim_set_nr_map

--Remap space as leader key
-- nr_map("", "<Space>", "<Nop>", nr_options)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "


-- -- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
nr_map("n", "<C-h>", "<C-w>Left", nr_options)
nr_map("n", "<C-j>", "<C-w>Up", nr_options)
nr_map("n", "<C-k>", "<C-w>Down", nr_options)
nr_map("n", "<C-l>", "<C-w>Right", nr_options)

-- Resize with arrows
nr_map("n", "<S-Tab-Up>", ":resize 2<CR>", nr_options)
nr_map("n", "<S-Tab-Down>", ":resize -2<CR>", nr_options)
nr_map("n", "<S-Tab-Right>", ":vertical resize -2<CR>", nr_options)
nr_map("n", "<C-Tab-Left>", ":vertical resize +2<CR>", nr_options)

