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

call plug#end()

" set nocompatible
set relativenumber
set cc=100
set nowrap
set smartcase
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set expandtab
set smartindent
set mouse=a
set encoding=utf-8
set noswapfile

filetype plugin indent on


" Configure rust tools
" require('rust-tools').setup({})

" colorscheme gruvbox
" set termguicolors

let base16colorspace=256
colorscheme base16-gruvbox-dark-medium

" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

lua << EOF
local nvim_lsp = require'lspconfig'
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        -- runnables = {
        --    use_telescope = true
        -- },

        -- debuggables = {
        --    use_telescope = true
        -- },

        inlay_hints = {
            only_current_line = false,
            -- only_current_line_autocmd = "CursorHold",

            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",

            max_len_align = false,
            -- max_len_align_padding = 1,
            right_align = false,
            -- right_align_padding = 7,
            highlight = "Comment",
        },

        -- hover_actions = {
        --    border = {
        --        {"╭", "FloatBorder"}, {"─", "FloatBorder"},
        --        {"╮", "FloatBorder"}, {"│", "FloatBorder"},
        --        {"╯", "FloatBorder"}, {"─", "FloatBorder"},
        --        {"╰", "FloatBorder"}, {"│", "FloatBorder"}
        --    },
        --    auto_focus = false
        -- },

        -- crate_graph = {
        --    backend = "x11",
        --    output = nil,
        --    full = true,
        -- }
    },

    server = {
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
                procMacro = {
                    enable = true
                },
                -- disabled = {"unresolved-proc-macro"},
            }
        }
    } -- rust-analyer options
}

require('rust-tools').setup(opts)
EOF

lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF


