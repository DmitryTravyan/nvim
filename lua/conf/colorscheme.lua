vim.g.base16colorspace = 256

local ok, _ = pcall(vim.cmd, "colorscheme base16-gruvbox-dark-hard")
if not ok then
  vim.notify("Err calling base16-colorscheme require!")
  return
end

--vim.g.gui00 = "#303030" -- Base 00 - Black Backgraound
--vim.g.gui01 = "#ff5f5f" -- Base 01 - IndianRed1
--vim.g.gui02 = "#d7d700" -- Base 02 - Yellow3
--vim.g.gui03 = "#d7af5f" -- Base 03 - LightGoldenrod3
--vim.g.gui04 = "#87afaf" -- Base 04 - LightSkyBlue3
--vim.g.gui05 = "#af8787" -- Base 05 - RosyBrown
--vim.g.gui06 = "#afd787" -- Base 06 - DarkSeaGreen3
--vim.g.gui07 = "#d7af87" -- Base 07 - Tan
--vim.g.gui08 = "#878787" -- Base 08 - Grey53
--vim.g.gui09 = "#ff5f5f" -- Base 09 - IndianRed1
--vim.g.gui0A = "#fabd2f" -- Base 10 - Yellow3
--vim.g.gui0B = "#d7af5f" -- Base 11 - LightGoldenrod3
--vim.g.gui0C = "#d7af5f" -- Base 12 - LightSkyBlue3
--vim.g.gui0D = "#af8787" -- Base 13 - RosyBrown
--vim.g.gui0E = "#d7af5f" -- Base 14 - DarkSeaGreen3
--vim.g.gui0F = "#ffffd7" -- Base 15 - Cornsilk1
--
--vim.g.base16_gui00 = "#303030" -- Base 00 - Black Backgraound
--vim.g.base16_gui01 = "#ff5f5f" -- Base 01 - IndianRed1
--vim.g.base16_gui02 = "#d7d700" -- Base 02 - Yellow3
--vim.g.base16_gui03 = "#d7af5f" -- Base 03 - LightGoldenrod3
--vim.g.base16_gui04 = "#87afaf" -- Base 04 - LightSkyBlue3
--vim.g.base16_gui05 = "#af8787" -- Base 05 - RosyBrown
--vim.g.base16_gui06 = "#afd787" -- Base 06 - DarkSeaGreen3
--vim.g.base16_gui07 = "#d7af87" -- Base 07 - Tan
--vim.g.base16_gui08 = "#878787" -- Base 08 - Grey53
--vim.g.base16_gui09 = "#ff5f5f" -- Base 09 - IndianRed1
--vim.g.base16_gui0A = "#fabd2f" -- Base 10 - Yellow3
--vim.g.base16_gui0B = "#d7af5f" -- Base 11 - LightGoldenrod3
--vim.g.base16_gui0C = "#d7af5f" -- Base 12 - LightSkyBlue3
--vim.g.base16_gui0D = "#af8787" -- Base 13 - RosyBrown
--vim.g.base16_gui0E = "#d7af5f" -- Base 14 - DarkSeaGreen3
--vim.g.base16_gui0F = "#ffffd7" -- Base 15 - Cornsilk1
--
--vim.highlight.SignColumn = { guifg = vim.g.gui04, guibg = nil, gui = nil, guisp = nil }
--vim.highlight.DiagnosticError = { guifg = vim.g.gui08, guibg = nil, gui = 'none', guisp = nil }
--vim.highlight.DiagnosticWarn = { guifg = vim.g.gui0E, guibg = nil, gui = 'none', guisp = nil }
--vim.highlight.DiagnosticInfo = { guifg = vim.g.gui05, guibg = nil, gui = 'none', guisp = nil }
--vim.highlight.DiagnosticHint = { guifg = vim.g.gui0C, guibg = nil, gui = 'none', guisp = nil }
--vim.highlight.DiagnosticUnderlineError = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = vim.g.gui08 }
--vim.highlight.DiagnosticUnderlineWarning = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = vim.g.gui0E }
--vim.highlight.DiagnosticUnderlineWarn = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = vim.g.gui0E }
--vim.highlight.DiagnosticUnderlineInformation = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = vim.g.gui0F }
--vim.highlight.DiagnosticUnderlineHint = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = vim.g.gui0C }
--
--vim.highlight.gitcommitComment = { guifg = "ff5f5f", guibg = nil, gui = nil,    guisp = nil }
--vim.highlight.LineNr = { guifg = "ff5f5f", guibg = nil, gui = nil,    guisp = nil }

-- let ok = require("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")

--require("base16-colorscheme").setup({
--    base00 = '#000000', -- Base 00 - Black Backgraound
--    base01 = '#800000', -- Base 01 - Darge Grey
--    base02 = '#008000',
--    base03 = '#808000',
--    base04 = '#000080',
--    base05 = '#800080', -- Base 05 - Purple
--    base06 = '#008080', -- Base 06 - Aqua
--    base07 = '#c0c0c0', -- Base 07 - Gray
--    base08 = '#808080', -- Base 08 - Gray
--    base09 = '#ff0000', -- Base 09 - Red
--    base0A = '#ffff00', -- Base 10 - Green
--    base0B = '#00ff00', -- Base 11 - Yellow
--    base0C = '#0000ff',
--    base0D = '#ff00ff',
--    base0E = '#00ffff',
--    base0F = '#ffffff',
--})

--require("base16-colorscheme").setup({
--    base00 = '#303030', -- Base 00 - Black Backgraound
--    base01 = '#ff5f5f', -- Base 01 - IndianRed1
--    base02 = '#d7d700', -- Base 02 - Yellow3
--    base03 = '#d7af5f', -- Base 03 - LightGoldenrod3
--    base04 = '#87afaf', -- Base 04 - LightSkyBlue3
--    base05 = '#af8787', -- Base 05 - RosyBrown
--    base06 = '#afd787', -- Base 06 - DarkSeaGreen3
--    base07 = '#d7af87', -- Base 07 - Tan
--    base08 = '#878787', -- Base 08 - Grey53
--    base09 = '#ff5f5f', -- Base 09 - IndianRed1
--    base0A = '#fabd2f', -- Base 10 - Yellow3
--    base0B = '#d7af5f', -- Base 11 - LightGoldenrod3
--    base0C = '#d7af5f', -- Base 12 - LightSkyBlue3
--    base0D = '#af8787', -- Base 13 - RosyBrown
--    base0E = '#d7af5f', -- Base 14 - DarkSeaGreen3
--    base0F = '#ffffd7', -- Base 15 - Cornsilk1
--})


