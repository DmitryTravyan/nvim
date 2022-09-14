local tools = {
    "gofumpt",
    "golines",
    "gomodifytags",
    "gotests",
    "go-dap",
}

for _, tool in pairs(tools) do
    local _, err = pcall(vim.cmd, string.format(":MasonInstall %s<CR>", tool))
    if not err then
        vim.log.warn("Error then installing" .. tool)
    end
end
