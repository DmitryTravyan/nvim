require("lualine").setup({
    options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = false,
        ignore_focus = { "NvimTree" },
        sections = {
            lualine_a = {
                {
                    'filetype',
                    colored = false, -- Displays filetype icon in color if set to true
                    icon_only = true, -- Display only an icon for filetype
                    icon = { align = 'right' }, -- Display filetype icon on the right hand side
                }
            }
        }
    },
})
