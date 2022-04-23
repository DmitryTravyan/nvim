if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('~/.config/nvim/plugged')

" Theme installation
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" Setup lsp comfiguration
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Debugging (needs plenary from above as well)
Plug 'mfussenegger/nvim-dap'

" Git plugin
Plug 'tpope/vim-fugitive'

" Nerd tree plugin
Plug 'preservim/nerdtree'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Tree sitter plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Add toml support
Plug 'cespare/vim-toml'

" Better tabs
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()

