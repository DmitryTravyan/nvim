local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
	print('Installing packer close and reopen Neovim...')
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function() return require('packer.util').float({ border = 'rounded' }) end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use('wbthomason/packer.nvim') -- Have packer manage itself
	use('nvim-lua/popup.nvim') -- An implementation of the Popup API from vim in Neovim

	-- visual stuff
	use('nvim-lualine/lualine.nvim')

	-- completion plugins
	use('hrsh7th/nvim-cmp') -- The completion plugin
	use('hrsh7th/cmp-buffer') -- buffer completions
	use('hrsh7th/cmp-path') -- path completions
	use('hrsh7th/cmp-cmdline') -- cmdline completions
	use('hrsh7th/cmp-nvim-lsp') -- lsp completion

	-- snippets
	use({
		'L3MON4D3/LuaSnip',
		run = 'make install_jsregexp',
	})
	use('rafamadriz/friendly-snippets') -- a bunch of snippets to use

	-- LSP
	use('neovim/nvim-lspconfig') -- enable LSP
	use('williamboman/mason.nvim') -- new laguage server installer
	use('williamboman/mason-lspconfig.nvim') -- configuration plugin for mason
	use('https://git.sr.ht/~whynothugo/lsp_lines.nvim') -- ???
	use('WhoIsSethDaniel/mason-tool-installer.nvim') -- automatically install mason tools

	-- Rust
	use('rust-lang/rust.vim') -- Rust language
	use('simrat39/rust-tools.nvim') -- Rust tools

	-- Golang
	use('ray-x/go.nvim') -- Go support

	-- Toml
	use('cespare/vim-toml')

	-- Lua
	use('folke/neodev.nvim')
	use('mhartington/formatter.nvim')

	-- Clang
	use('deoplete-plugins/deoplete-clang')
	use('cdelledonne/vim-cmake')

    -- Yaml
    use('someone-stole-my-name/yaml-companion.nvim')

	-- File navigation
	use('nvim-tree/nvim-web-devicons')
	use('nvim-tree/nvim-tree.lua')

	-- Treesitter and code analysis
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	})
	use('JoosepAlviste/nvim-ts-context-commentstring')
	use('nvim-lua/plenary.nvim') -- Useful lua functions used ny lots of plugins
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-telescope/telescope-live-grep-args.nvim' },
		},
		config = function() require('telescope').load_extension('live_grep_args') end,
	})

	-- Null ls plugin
	use('jose-elias-alvarez/null-ls.nvim')

	-- Neovim Debug Adapter Protocol (DAP) plugin
	use('mfussenegger/nvim-dap')

	-- Ansyncronius linter
	use('mfussenegger/nvim-lint')

	-- Clipboard
	use({
		'AckslD/nvim-neoclip.lua',
		requires = {
			{ 'ibhagwan/fzf-lua' },
		},
	})

	-- Filetype
	use('nathom/filetype.nvim')

	-- Git
	use('f-person/git-blame.nvim')

	-- Colorscheme
	use('RRethy/nvim-base16')

    -- Comments
    use('numToStr/Comment.nvim')

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
