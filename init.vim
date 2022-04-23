syntax enable

runtime ./plug.vim

let base16colorspace=256
colorscheme gruvbox

highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey90
highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu

runtime ./maps.vim
runtime ./lspconf.vim
runtime ./completion.vim
runtime ./plugged/nvim-treesitter/config.vim

" NerdTREE config
let NERDTreeShowHidden=1

