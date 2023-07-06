if os.getenv("TERM_PROGRAM") == 'Apple_Terminal' then
    -- Possible variants
	-- "gruvbox-dark-hard"
	-- "onedark"
	require("conf.termnative").setup("gruvbox-dark-hard")
else
	vim.opt.termguicolors = true
	vim.cmd("colorscheme base16-gruvbox-dark-hard")
end
