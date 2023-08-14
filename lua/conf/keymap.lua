local options = { noremap = true, silent = true }
local terminal_options = { silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Alt>', '<Nop>', options)
vim.g.mapleader = 'Alt'
vim.g.maplocalleader = 'Alt'

-- -- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- File Navigation
keymap('n', '<C-n>', ':NvimTreeFocus<CR>', options)
keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', options)
keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', options)

-- Normal --
-- Navigate between windows (splitted)
keymap('n', '<C-h>', '<C-w>h', options)
keymap('n', '<C-j>', '<C-w>k', options)
keymap('n', '<C-k>', '<C-w>j', options)
keymap('n', '<C-l>', '<C-w>l', options)

-- Split window verticaly
keymap('n', '<A-S-s>', ':vsplit<CR>', options)

-- Resize splited part with arrow
keymap('n', '<C-j>', ':resize +2<CR>', options)
keymap('n', '<C-k>', ':resize -2<CR>', options)
keymap('n', '<C-h>', ':vertical resize +3<CR>', options)
keymap('n', '<C-l>', ':vertical resize -3<CR>', options)

-- Escape in insert mode
keymap('i', 'jk', '<ESC>', options)

-- Visual --
-- Stay in indent mode (insert tab)
keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

-- Move visual selected block up and down
-- keymap("i", "<A-S-k>", ":m '<-2<CR>gv=gv", options)
-- keymap("i", "<A-S-j>", ":m '<+1<CR>gv=gv", options)
keymap('v', 'p', '"_dP', options)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ':move \'>+1<CR>gv-gv', options)
keymap('x', 'K', ':move \'<-2<CR>gv-gv', options)

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', terminal_options)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', terminal_options)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', terminal_options)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', terminal_options)

-- Telescope --
-- Open Telescope window
keymap(
	'n',
	'<A-f>',
	'<CMD>lua require\'telescope.builtin\'.find_files(require(\'telescope.themes\').get_dropdown({ previewer = false }))<CR>',
	terminal_options
)
keymap(
	'n',
	'<A-S-f>',
	':lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>',
	terminal_options
)

-- Set formatting shortcut keymap
-- keymap("n", "<S-A-l>", ":RustFmt<CR>", { noremap = true, silent = true })

-- Set formatting shortcut keymap
-- keymap("n", "<S-A-l>", ":GoFmt<CR>", { noremap = true, silent = true })
