local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "yaml",
        "haskell",
        "toml",
        "json",
        "hcl",
        "go",
        "gomod",
        "sql",
        "ruby"
    },
    -- install languages synchronously (only applied to `ensure_installed`)
    sync_install = true,
    -- List of parsers to ignore installing
    -- ignore_install = "all",
    autopairs = {
        enable = true,
    },
    highlight = {
        -- false will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
        disable = { "rust", "go", "lua" },
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

