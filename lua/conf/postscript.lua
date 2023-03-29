local function open_nvim_tree()
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Formatting
vim.cmd("autocmd FileType go nnoremap <S-A-l> :GoFmt<CR>")
vim.cmd("autocmd FileType rust nnoremap <S-A-l> :RustFmt<CR>")
vim.cmd("autocmd FileType lua nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType yaml nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType terraform nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType terraform-vars nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType hcl nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType c nnoremap <S-A-l> :FormatWrite<CR>")
vim.cmd("autocmd FileType cpp nnoremap <S-A-l> :FormatWrite<CR>")
