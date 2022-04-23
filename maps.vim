nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> t     <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> ,     <space> :nohlsearch<CR>
nnoremap <silent> <S-l>         :RustFmt<CR>
nnoremap <silent> <S-=>         :NERDTreeRefreshRoot<CR>
map      <silent> <C-n>         :NERDTreeFocus<CR>

