local M = {}

-- This is a bit of syntactic sugar for creating highlight groups.
--
-- local colorscheme = require('colorscheme')
-- local hi = colorscheme.highlight
-- hi.Comment = { ctermfg='#ffffff', ctermbg='#000000', gui='italic', guisp=nil }
-- hi.LspDiagnosticsDefaultError = 'DiagnosticError' -- Link to another group
--
-- This is equivalent to the following vimscript
--
-- hi Comment ctermfg=#ffffff ctermbg=#000000 gui=italic
-- hi! link LspDiagnosticsDefaultError DiagnosticError
M.highlight = setmetatable({}, {
	__newindex = function(_, hlgroup, args)
		if "string" == type(args) then
			vim.cmd(("hi! link %s %s"):format(hlgroup, args))
			return
		end

		local ctermfg, ctermbg, cterm = args.ctermfg or nil, args.ctermbg or nil, args.cterm or nil
		local cmd = { "hi", hlgroup }
		if ctermfg then
			table.insert(cmd, "ctermfg=" .. ctermfg)
		end
		if ctermbg then
			table.insert(cmd, "ctermbg=" .. ctermbg)
		end
		if cterm then
			table.insert(cmd, "cterm=" .. cterm)
		end
		vim.cmd(table.concat(cmd, " "))
	end,
})

--- Creates a base16 colorscheme using the colors specified.
--
-- Builtin colorschemes can be found in the M.colorschemes table.
--
-- The default Vim highlight groups (including User[1-9]), highlight groups
-- pertaining to Neovim's builtin LSP, and highlight groups pertaining to
-- Treesitter will be defined.
--
-- It's worth noting that many colorschemes will specify language specific
-- highlight groups like rubyConstant or pythonInclude. However, I don't do
-- that here since these should instead be linked to an existing highlight
-- group.
--
function M.setup(name)
	if "string" == type(name) then
		M.colors = require(string.format("conf.termnative.%s", name))
	else
		print("Default colorscheme")
		M.colors = {
			base00 = "0",
			base01 = "1",
			base02 = "2",
			base03 = "3",
			base04 = "4",
			base05 = "5",
			base06 = "6",
			base07 = "7",
			base08 = "8",
			base09 = "9",
			base0A = "10",
			base0B = "11",
			base0C = "12",
			base0D = "13",
			base0E = "14",
			base0F = "15",
		}
	end

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	M.config = {
		telescope = true,
		indentblankline = true,
		notify = true,
		ts_rainbow = true,
		cmp = true,
		illuminate = true,
		lualine = true,
		nvim_tree = true,
	}

	local hi = M.highlight

	-- Vim editor colors
	hi.Normal = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
	hi.Bold = { ctermfg = nil, ctermbg = nil, cterm = "bold" }
	hi.Debug = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.Directory = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.Error = { ctermfg = M.colors.base00, ctermbg = M.colors.base08, cterm = nil }
	hi.ErrorMsg = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
	hi.Exception = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.FoldColumn = { ctermfg = M.colors.base0C, ctermbg = M.colors.base00, cterm = nil }
	hi.Folded = { ctermfg = M.colors.base03, ctermbg = M.colors.base01, cterm = nil }
	hi.IncSearch = { ctermfg = M.colors.base01, ctermbg = M.colors.base09, cterm = "none" }
	hi.Italic = { ctermfg = nil, ctermbg = nil, cterm = "none" }
	hi.Macro = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.MatchParen = { ctermfg = nil, ctermbg = M.colors.base03, cterm = nil }
	hi.ModeMsg = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = nil }
	hi.MoreMsg = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = nil }
	hi.Question = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.Search = { ctermfg = M.colors.base01, ctermbg = M.colors.base0A, cterm = nil }
	hi.Substitute = { ctermfg = M.colors.base01, ctermbg = M.colors.base0A, cterm = "none" }
	hi.SpecialKey = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.TooLong = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.Underlined = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.Visual = { ctermfg = nil, ctermbg = M.colors.base02, cterm = nil }
	hi.VisualNOS = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.WarningMsg = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.WildMenu = { ctermfg = M.colors.base08, ctermbg = M.colors.base0A, cterm = nil }
	hi.Title = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.Conceal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00, cterm = nil }
	hi.Cursor = { ctermfg = M.colors.base00, ctermbg = M.colors.base05, cterm = nil }
	hi.NonText = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.LineNr = { ctermfg = M.colors.base04, ctermbg = M.colors.base00, cterm = nil }
	hi.SignColumn = { ctermfg = M.colors.base04, ctermbg = M.colors.base00, cterm = nil }
	hi.StatusLine = { ctermfg = M.colors.base05, ctermbg = M.colors.base02, cterm = "none" }
	hi.StatusLineNC = { ctermfg = M.colors.base04, ctermbg = M.colors.base01, cterm = "none" }
	hi.WinBar = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.WinBarNC = { ctermfg = M.colors.base04, ctermbg = nil, cterm = "none" }
	hi.VertSplit = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = "none" }
	hi.ColorColumn = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "none" }
	hi.CursorColumn = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "none" }
	hi.CursorLine = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "none" }
	hi.CursorLineNr = { ctermfg = M.colors.base04, ctermbg = M.colors.base01, cterm = nil }
	hi.QuickFixLine = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "none" }
	hi.PMenu = { ctermfg = M.colors.base05, ctermbg = M.colors.base01, cterm = "none" }
	hi.PMenuSel = { ctermfg = M.colors.base01, ctermbg = M.colors.base05, cterm = nil }
	hi.TabLine = { ctermfg = M.colors.base03, ctermbg = M.colors.base01, cterm = "none" }
	hi.TabLineFill = { ctermfg = M.colors.base03, ctermbg = M.colors.base01, cterm = "none" }
	hi.TabLineSel = { ctermfg = M.colors.base0B, ctermbg = M.colors.base01, cterm = "none" }

	-- Standard syntax highlighting
	hi.Boolean = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
	hi.Character = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.Comment = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.Conditional = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = nil }
	hi.Constant = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
	hi.Define = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.Delimiter = { ctermfg = M.colors.base0F, ctermbg = nil, cterm = nil }
	hi.Float = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
	hi.Function = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.Identifier = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.Include = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.Keyword = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = nil }
	hi.Label = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.Number = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
	hi.Operator = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.PreProc = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.Repeat = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.Special = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = nil }
	hi.SpecialChar = { ctermfg = M.colors.base0F, ctermbg = nil, cterm = nil }
	hi.Statement = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.StorageClass = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.String = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = nil }
	hi.Structure = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = nil }
	hi.Tag = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.Todo = { ctermfg = M.colors.base0A, ctermbg = M.colors.base01, cterm = nil }
	hi.Type = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = "none" }
	hi.Typedef = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }

	-- Diff highlighting
	hi.DiffAdd = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffChange = { ctermfg = M.colors.base03, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffDelete = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffText = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffAdded = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffFile = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffNewFile = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffLine = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00, cterm = nil }
	hi.DiffRemoved = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }

	-- Git highlighting
	hi.gitcommitOverflow = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
	hi.gitcommitSummary = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = nil }
	hi.gitcommitComment = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.gitcommitUntracked = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.gitcommitDiscarded = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.gitcommitSelected = { ctermfg = M.colors.base03, ctermbg = nil, cterm = nil }
	hi.gitcommitHeader = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = nil }
	hi.gitcommitSelectedType = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.gitcommitUnmergedType = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.gitcommitDiscardedType = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
	hi.gitcommitBranch = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "bold" }
	hi.gitcommitUntrackedFile = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
	hi.gitcommitUnmergedFile = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "bold" }
	hi.gitcommitDiscardedFile = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "bold" }
	hi.gitcommitSelectedFile = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = "bold" }

	-- GitGutter highlighting
	hi.GitGutterAdd = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
	hi.GitGutterChange = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00, cterm = nil }
	hi.GitGutterDelete = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
	hi.GitGutterChangeDelete = { ctermfg = M.colors.base0E, ctermbg = M.colors.base00, cterm = nil }

	-- Spelling highlighting
	hi.SpellBad = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.SpellLocal = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.SpellCap = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.SpellRare = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }

	hi.DiagnosticError = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.DiagnosticWarn = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.DiagnosticInfo = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.DiagnosticHint = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
	hi.DiagnosticUnderlineError = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.DiagnosticUnderlineWarning = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.DiagnosticUnderlineWarn = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.DiagnosticUnderlineInformation = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }
	hi.DiagnosticUnderlineHint = { ctermfg = nil, ctermbg = nil, cterm = "undercurl" }

	hi.LspReferenceText = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	hi.LspReferenceRead = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	hi.LspReferenceWrite = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	hi.LspDiagnosticsDefaultError = "DiagnosticError"
	hi.LspDiagnosticsDefaultWarning = "DiagnosticWarn"
	hi.LspDiagnosticsDefaultInformation = "DiagnosticInfo"
	hi.LspDiagnosticsDefaultHint = "DiagnosticHint"
	hi.LspDiagnosticsUnderlineError = "DiagnosticUnderlineError"
	hi.LspDiagnosticsUnderlineWarning = "DiagnosticUnderlineWarning"
	hi.LspDiagnosticsUnderlineInformation = "DiagnosticUnderlineInformation"
	hi.LspDiagnosticsUnderlineHint = "DiagnosticUnderlineHint"

	hi.TSAnnotation = { ctermfg = M.colors.base0F, ctermbg = nil, cterm = "none" }
	hi.TSAttribute = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = "none" }
	hi.TSBoolean = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "none" }
	hi.TSCharacter = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSComment = { ctermfg = M.colors.base03, ctermbg = nil, cterm = "italic" }
	hi.TSConstructor = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.TSConditional = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.TSConstant = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "none" }
	hi.TSConstBuiltin = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "italic" }
	hi.TSConstMacro = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSError = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSException = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSField = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSFloat = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "none" }
	hi.TSFunction = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.TSFuncBuiltin = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "italic" }
	hi.TSFuncMacro = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSInclude = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.TSKeyword = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.TSKeywordFunction = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.TSKeywordOperator = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.TSLabel = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = "none" }
	hi.TSMethod = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.TSNamespace = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSNone = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSNumber = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "none" }
	hi.TSOperator = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSParameter = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSParameterReference = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSProperty = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSPunctDelimiter = { ctermfg = M.colors.base0F, ctermbg = nil, cterm = "none" }
	hi.TSPunctBracket = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSPunctSpecial = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSRepeat = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
	hi.TSString = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = "none" }
	hi.TSStringRegex = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
	hi.TSStringEscape = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
	hi.TSSymbol = { ctermfg = M.colors.base0B, ctermbg = nil, cterm = "none" }
	hi.TSTag = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = "none" }
	hi.TSTagDelimiter = { ctermfg = M.colors.base0F, ctermbg = nil, cterm = "none" }
	hi.TSText = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
	hi.TSStrong = { ctermfg = nil, ctermbg = nil, cterm = "bold" }
	hi.TSEmphasis = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "italic" }
	hi.TSUnderline = { ctermfg = M.colors.base00, ctermbg = nil, cterm = "underline" }
	hi.TSStrike = { ctermfg = M.colors.base00, ctermbg = nil, cterm = "strikethrough" }
	hi.TSTitle = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = "none" }
	hi.TSLiteral = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "none" }
	hi.TSURI = { ctermfg = M.colors.base09, ctermbg = nil, cterm = "underline" }
	-- hi.TSType               = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = 'none' }
	hi.TSTypeBuiltin = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = "italic" }
	hi.TSVariable = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
	hi.TSVariableBuiltin = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "italic" }

	hi.TSDefinition = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	hi.TSDefinitionUsage = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	hi.TSCurrentScope = { ctermfg = nil, ctermbg = nil, cterm = "bold" }

	if M.config.ts_rainbow then
		hi.rainbowcol1 = { ctermfg = M.colors.base06 }
		hi.rainbowcol2 = { ctermfg = M.colors.base09 }
		hi.rainbowcol3 = { ctermfg = M.colors.base0A }
		hi.rainbowcol4 = { ctermfg = M.colors.base07 }
		hi.rainbowcol5 = { ctermfg = M.colors.base0C }
		hi.rainbowcol6 = { ctermfg = M.colors.base0D }
		hi.rainbowcol7 = { ctermfg = M.colors.base0E }
	end

	hi.NvimInternalError = { ctermfg = M.colors.base00, ctermbg = M.colors.base08, cterm = "none" }

	hi.NormalFloat = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
	hi.FloatBorder = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
	hi.NormalNC = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
	hi.TermCursor = { ctermfg = M.colors.base00, ctermbg = M.colors.base05, cterm = "none" }
	hi.TermCursorNC = { ctermfg = M.colors.base00, ctermbg = M.colors.base05, cterm = nil }

	hi.User1 = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = "none" }
	hi.User2 = { ctermfg = M.colors.base0E, ctermbg = M.colors.base02, cterm = "none" }
	hi.User3 = { ctermfg = M.colors.base05, ctermbg = M.colors.base02, cterm = "none" }
	hi.User4 = { ctermfg = M.colors.base0C, ctermbg = M.colors.base02, cterm = "none" }
	hi.User5 = { ctermfg = M.colors.base05, ctermbg = M.colors.base02, cterm = "none" }
	hi.User6 = { ctermfg = M.colors.base05, ctermbg = M.colors.base01, cterm = "none" }
	hi.User7 = { ctermfg = M.colors.base05, ctermbg = M.colors.base02, cterm = "none" }
	hi.User8 = { ctermfg = M.colors.base00, ctermbg = M.colors.base02, cterm = "none" }
	hi.User9 = { ctermfg = M.colors.base00, ctermbg = M.colors.base02, cterm = "none" }

	hi.TreesitterContext = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "italic" }

	if M.config.telescope then
		hi.TelescopeBorder = { ctermfg = M.colors.base00, ctermbg = M.colors.base00, cterm = nil }
		hi.TelescopePromptBorder = { ctermfg = M.colors.base02, ctermbg = M.colors.base02, cterm = nil }
		hi.TelescopePromptNormal = { ctermfg = M.colors.base05, ctermbg = M.colors.base02, cterm = nil }
		hi.TelescopePromptPrefix = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
		hi.TelescopeNormal = { ctermfg = nil, ctermbg = M.colors.base00, cterm = nil }
		hi.TelescopePreviewTitle = { ctermfg = M.colors.base01, ctermbg = M.colors.base0B, cterm = nil }
		hi.TelescopePromptTitle = { ctermfg = M.colors.base01, ctermbg = M.colors.base08, cterm = nil }
		hi.TelescopeResultsTitle = { ctermfg = M.colors.base00, ctermbg = M.colors.base00, cterm = nil }
		hi.TelescopeSelection = { ctermfg = nil, ctermbg = M.colors.base02, cterm = nil }
		hi.TelescopePreviewLine = { ctermfg = nil, ctermbg = M.colors.base01, cterm = "none" }
	end

	if M.config.notify then
		hi.NotifyERRORBorder = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
		hi.NotifyWARNBorder = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
		hi.NotifyINFOBorder = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
		hi.NotifyDEBUGBorder = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyTRACEBorder = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyERRORIcon = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
		hi.NotifyWARNIcon = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
		hi.NotifyINFOIcon = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
		hi.NotifyDEBUGIcon = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyTRACEIcon = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyERRORTitle = { ctermfg = M.colors.base08, ctermbg = nil, cterm = "none" }
		hi.NotifyWARNTitle = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = "none" }
		hi.NotifyINFOTitle = { ctermfg = M.colors.base05, ctermbg = nil, cterm = "none" }
		hi.NotifyDEBUGTitle = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyTRACETitle = { ctermfg = M.colors.base0C, ctermbg = nil, cterm = "none" }
		hi.NotifyERRORBody = "Normal"
		hi.NotifyWARNBody = "Normal"
		hi.NotifyINFOBody = "Normal"
		hi.NotifyDEBUGBody = "Normal"
		hi.NotifyTRACEBody = "Normal"
	end

	if M.config.indentblankline then
		hi.IndentBlanklineChar = { ctermfg = M.colors.base02, cterm = "nocombine" }
		hi.IndentBlanklineContextChar = { ctermfg = M.colors.base04, cterm = "nocombine" }
	end

	if M.config.cmp then
		hi.CmpDocumentationBorder = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
		hi.CmpDocumentation = { ctermfg = M.colors.base05, ctermbg = M.colors.base00, cterm = nil }
		hi.CmpItemAbbr = { ctermfg = M.colors.base05, ctermbg = M.colors.base01, cterm = nil }
		hi.CmpItemAbbrDeprecated = { ctermfg = M.colors.base03, ctermbg = nil, cterm = "strikethrough" }
		hi.CmpItemAbbrMatch = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
		hi.CmpItemAbbrMatchFuzzy = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
		hi.CmpItemKindDefault = { ctermfg = M.colors.base05, ctermbg = nil, cterm = nil }
		hi.CmpItemMenu = { ctermfg = M.colors.base04, ctermbg = nil, cterm = nil }
		hi.CmpItemKindKeyword = { ctermfg = M.colors.base0E, ctermbg = nil, cterm = nil }
		hi.CmpItemKindVariable = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
		hi.CmpItemKindConstant = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
		hi.CmpItemKindReference = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
		hi.CmpItemKindValue = { ctermfg = M.colors.base09, ctermbg = nil, cterm = nil }
		hi.CmpItemKindFunction = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
		hi.CmpItemKindMethod = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
		hi.CmpItemKindConstructor = { ctermfg = M.colors.base0D, ctermbg = nil, cterm = nil }
		hi.CmpItemKindClass = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindInterface = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindStruct = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindEvent = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindEnum = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindUnit = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindModule = { ctermfg = M.colors.base05, ctermbg = nil, cterm = nil }
		hi.CmpItemKindProperty = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
		hi.CmpItemKindField = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }
		hi.CmpItemKindTypeParameter = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindEnumMember = { ctermfg = M.colors.base0A, ctermbg = nil, cterm = nil }
		hi.CmpItemKindOperator = { ctermfg = M.colors.base05, ctermbg = nil, cterm = nil }
		hi.CmpItemKindSnippet = { ctermfg = M.colors.base04, ctermbg = nil, cterm = nil }
	end

	if M.config.illuminate then
		hi.IlluminatedWordText = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
		hi.IlluminatedWordRead = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
		hi.IlluminatedWordWrite = { ctermfg = nil, ctermbg = nil, cterm = "underline" }
	end

	if M.config.lualine then
		hi.lualine_b_terminal = { ctermfg = M.colors.base0C, ctermbg = M.colors.base00 }
		hi.lualine_c_terminal = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_terminal = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base0C }
		hi.lualine_b_command = { ctermfg = M.colors.base0C, ctermbg = M.colors.base00 }
		hi.lualine_c_command = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_command = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base0C }
		hi.lualine_b_replace = { ctermfg = M.colors.base0E, ctermbg = M.colors.base00 }
		hi.lualine_c_replace = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_replace = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base0E }
		hi.lualine_b_visual = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_c_visual = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_visual = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base09 }
		hi.lualine_b_inactive = { ctermfg = M.colors.base04, ctermbg = M.colors.base00 }
		hi.lualine_c_inactive = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_inactive = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base02 }
		hi.lualine_b_normal = { ctermfg = M.colors.base04, ctermbg = M.colors.base00 }
		hi.lualine_c_normal = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_normal = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base02 }
		hi.lualine_b_insert = { ctermfg = M.colors.base0E, ctermbg = M.colors.base00 }
		hi.lualine_c_insert = { ctermfg = M.colors.base02, ctermbg = M.colors.base00 }
		hi.lualine_a_insert = { cterm = "bold", ctermfg = M.colors.base00, ctermbg = M.colors.base0E }
		hi.lualine_b_diff_added_normal = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_insert = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_visual = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_replace = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_command = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_terminal = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_added_inactive = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_normal = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_insert = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_visual = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_replace = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_command = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_terminal = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_modified_inactive = { ctermfg = M.colors.base0A, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_normal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_insert = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_visual = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_replace = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_command = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_terminal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_inactive = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_normal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_insert = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_visual = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_replace = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_command = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_terminal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diff_removed_inactive = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_normal = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_insert = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_visual = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_replace = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_command = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_terminal = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_error_inactive = { ctermfg = M.colors.base09, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_normal = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_insert = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_visual = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_replace = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_command = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_terminal = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_warn_inactive = { ctermfg = M.colors.base0F, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_normal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_insert = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_visual = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_replace = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_command = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_terminal = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_info_inactive = { ctermfg = M.colors.base0D, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_normal = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_insert = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_visual = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_replace = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_command = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_terminal = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_b_diagnostics_hint_inactive = { ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
		hi.lualine_transitional_lualine_a_normal_to_lualine_b_normal =
			{ ctermfg = M.colors.base04, ctermbg = M.colors.base00 }
		hi.lualine_transitional_lualine_a_command_to_lualine_b_command =
			{ ctermfg = M.colors.base07, ctermbg = M.colors.base00 }
	end

	if M.config.nvim_tree then
		hi.NvimTreeBookmark = { ctermfg = M.colors.base07 }
		hi.NvimTreeCursorColumn = "CursorColumn"
		hi.NvimTreeCursorLine = "CursorLine"
		hi.NvimTreeCursorLineNr = "CursorLineNr"
		hi.NvimTreeEmptyFolderName = "Directory"
		hi.NvimTreeEndOfBuffer = "EndOfBuffer"
		hi.NvimTreeExecFile = { cterm = "bold" }
		hi.NvimTreeFileDeleted = "NvimTreeGitDeleted"
		hi.NvimTreeFileDirty = "NvimTreeGitDirty"
		hi.NvimTreeFileIgnored = "NvimTreeGitIgnored"
		hi.NvimTreeFileMerge = "NvimTreeGitMerge"
		hi.NvimTreeFileNew = "NvimTreeGitNew"
		hi.NvimTreeFileRenamed = "NvimTreeGitRenamed"
		hi.NvimTreeFileStaged = "NvimTreeGitStaged"
		hi.NvimTreeFolderIcon = { ctermfg = M.colors.base04 }
		hi.NvimTreeFolderName = "Directory"
		hi.NvimTreeGitDirty = { ctermfg = M.colors.base07 }
		hi.NvimTreeGitIgnored = "Comment"
		hi.NvimTreeGitMerge = { ctermfg = M.colors.base07 }
		hi.NvimTreeGitNew = { ctermfg = M.colors.base07 }
		hi.NvimTreeGitRenamed = { ctermfg = M.colors.base07 }
		hi.NvimTreeGitStaged = { ctermfg = M.colors.base07 }
		hi.NvimTreeImageFile = { cterm = "bold" }
		hi.NvimTreeIndentMarker = { ctermfg = M.colors.base04 }
		hi.NvimTreeLineNr = "LineNr"
		hi.NvimTreeLiveFilterPrefix = { cterm = "bold" }
		hi.NvimTreeLiveFilterValue = { cterm = "bold" }
		hi.NvimTreeLspDiagnosticsError = "DiagnosticError"
		hi.NvimTreeLspDiagnosticsHint = "DiagnosticHint"
		hi.NvimTreeLspDiagnosticsInformation = "DiagnosticInfo"
		hi.NvimTreeLspDiagnosticsWarning = "DiagnosticWarn"
		hi.NvimTreeNormal = "Normal"
		hi.NvimTreeNormalNC = "NvimTreeNormal"
		hi.NvimTreeOpenedFile = { cterm = "bold" }
		hi.NvimTreeOpenedFolderName = "Directory"
		hi.NvimTreePopup = "Normal"
		hi.NvimTreeRootFolder = { ctermfg = M.colors.base07 }
		hi.NvimTreeSignColumn = "NvimTreeNormal"
		hi.NvimTreeSpecialFile = { cterm = "bold,underline" }
		hi.NvimTreeStatusLine = "StatusLine"
		hi.NvimTreeStatusLineNC = "StatusLineNC"
		hi.NvimTreeSymlink = { cterm = "bold" }
		hi.NvimTreeVertSplit = "VertSplit"
		hi.NvimTreeWinSeparator = "NvimTreeVertSplit"
		hi.NvimTreeWindowPicker = { cterm = "bold", ctermbg = M.colors.base01 }

		hi.DevIconAi = { ctermfg = 185, guifg = nil }
		hi.DevIconAwk = { ctermfg = 59, guifg = nil }
		hi.DevIconBabelrc = { ctermfg = 185, guifg = nil }
		hi.DevIconBash = { ctermfg = 113, guifg = nil }
		hi.DevIconBashProfile = { ctermfg = 113, guifg = nil }
		hi.DevIconBashrc = { ctermfg = 113, guifg = nil }
		hi.DevIconBat = { ctermfg = 154, guifg = nil }
		hi.DevIconBinaryGLTF = { ctermfg = 215, guifg = nil }
		hi.DevIconBmp = { ctermfg = 140, guifg = nil }
		hi.DevIconBrewfile = { ctermfg = 52, guifg = nil }
		hi.DevIconC = { ctermfg = 75, guifg = nil }
		hi.DevIconCMake = { ctermfg = 66, guifg = nil }
		hi.DevIconCMakeLists = { ctermfg = 66, guifg = nil }
		hi.DevIconCPlusPlus = { ctermfg = 204, guifg = nil }
		hi.DevIconClojure = { ctermfg = 107, guifg = nil }
		hi.DevIconClojureC = { ctermfg = 107, guifg = nil }
		hi.DevIconClojureDart = { ctermfg = 67, guifg = nil }
		hi.DevIconClojureJS = { ctermfg = 67, guifg = nil }
		hi.DevIconCobol = { ctermfg = 25, guifg = nil }
		hi.DevIconCoffee = { ctermfg = 185, guifg = nil }
		hi.DevIconConf = { ctermfg = 66, guifg = nil }
		hi.DevIconConfigRu = { ctermfg = 52, guifg = nil }
		hi.DevIconConfiguration = { ctermfg = 231, guifg = nil }
		hi.DevIconCp = { ctermfg = 67, guifg = nil }
		hi.DevIconCpp = { ctermfg = 67, guifg = nil }
		hi.DevIconCrystal = { ctermfg = 16, guifg = nil }
		hi.DevIconCs = { ctermfg = 58, guifg = nil }
		hi.DevIconCsh = { ctermfg = 59, guifg = nil }
		hi.DevIconCson = { ctermfg = 185, guifg = nil }
		hi.DevIconCss = { ctermfg = 39, guifg = nil }
		hi.DevIconCsv = { ctermfg = 113, guifg = nil }
		hi.DevIconCxx = { ctermfg = 67, guifg = nil }
		hi.DevIconD = { ctermfg = 64, guifg = nil }
		hi.DevIconDart = { ctermfg = 25, guifg = nil }
		hi.DevIconDb = { ctermfg = 188, guifg = nil }
		hi.DevIconDefault = { ctermfg = 66, guifg = nil }
		hi.DevIconDesktopEntry = { ctermfg = 60, guifg = nil }
		hi.DevIconDiff = { ctermfg = 59, guifg = nil }
		hi.DevIconDoc = { ctermfg = 25, guifg = nil }
		hi.DevIconDockerfile = { ctermfg = 59, guifg = nil }
		hi.DevIconDrools = { ctermfg = 217, guifg = nil }
		hi.DevIconDropbox = { ctermfg = 27, guifg = nil }
		hi.DevIconDsStore = { ctermfg = 59, guifg = nil }
		hi.DevIconDump = { ctermfg = 188, guifg = nil }
		hi.DevIconEdn = { ctermfg = 67, guifg = nil }
		hi.DevIconEex = { ctermfg = 140, guifg = nil }
		hi.DevIconEjs = { ctermfg = 185, guifg = nil }
		hi.DevIconElm = { ctermfg = 67, guifg = nil }
		hi.DevIconEnv = { ctermfg = 226, guifg = nil }
		hi.DevIconEpp = { ctermfg = 214, guifg = nil }
		hi.DevIconErb = { ctermfg = 52, guifg = nil }
		hi.DevIconErl = { ctermfg = 132, guifg = nil }
		hi.DevIconEx = { ctermfg = 140, guifg = nil }
		hi.DevIconExs = { ctermfg = 140, guifg = nil }
		hi.DevIconFavicon = { ctermfg = 185, guifg = nil }
		hi.DevIconFennel = { ctermfg = 230, guifg = nil }
		hi.DevIconFish = { ctermfg = 59, guifg = nil }
		hi.DevIconFs = { ctermfg = 67, guifg = nil }
		hi.DevIconFsharp = { ctermfg = 67, guifg = nil }
		hi.DevIconFsi = { ctermfg = 67, guifg = nil }
		hi.DevIconFsscript = { ctermfg = 67, guifg = nil }
		hi.DevIconFsx = { ctermfg = 67, guifg = nil }
		hi.DevIconGDScript = { ctermfg = 66, guifg = nil }
		hi.DevIconGemfile = { ctermfg = 52, guifg = nil }
		hi.DevIconGemspec = { ctermfg = 52, guifg = nil }
		hi.DevIconGif = { ctermfg = 140, guifg = nil }
		hi.DevIconGitAttributes = { ctermfg = 59, guifg = nil }
		hi.DevIconGitCommit = { ctermfg = 59, guifg = nil }
		hi.DevIconGitConfig = { ctermfg = 59, guifg = nil }
		hi.DevIconGitIgnore = { ctermfg = 59, guifg = nil }
		hi.DevIconGitLogo = { ctermfg = 202, guifg = nil }
		hi.DevIconGitModules = { ctermfg = 59, guifg = nil }
		hi.DevIconGitlabCI = { ctermfg = 166, guifg = nil }
		hi.DevIconGo = { ctermfg = 67, guifg = nil }
		hi.DevIconGodotProject = { ctermfg = 66, guifg = nil }
		hi.DevIconGraphQL = { ctermfg = 199, guifg = nil }
		hi.DevIconGruntfile = { ctermfg = 173, guifg = nil }
		hi.DevIconGulpfile = { ctermfg = 167, guifg = nil }
		hi.DevIconGvimrc = { ctermfg = 29, guifg = nil }
		hi.DevIconH = { ctermfg = 140, guifg = nil }
		hi.DevIconHaml = { ctermfg = 188, guifg = nil }
		hi.DevIconHbs = { ctermfg = 208, guifg = nil }
		hi.DevIconHeex = { ctermfg = 140, guifg = nil }
		hi.DevIconHh = { ctermfg = 140, guifg = nil }
		hi.DevIconHpp = { ctermfg = 140, guifg = nil }
		hi.DevIconHrl = { ctermfg = 132, guifg = nil }
		hi.DevIconHs = { ctermfg = 140, guifg = nil }
		hi.DevIconHtm = { ctermfg = 166, guifg = nil }
		hi.DevIconHtml = { ctermfg = 202, guifg = nil }
		hi.DevIconHxx = { ctermfg = 140, guifg = nil }
		hi.DevIconIco = { ctermfg = 185, guifg = nil }
		hi.DevIconImportConfiguration = { ctermfg = 231, guifg = nil }
		hi.DevIconIni = { ctermfg = 66, guifg = nil }
		hi.DevIconJava = { ctermfg = 167, guifg = nil }
		hi.DevIconJl = { ctermfg = 133, guifg = nil }
		hi.DevIconJpeg = { ctermfg = 140, guifg = nil }
		hi.DevIconJpg = { ctermfg = 140, guifg = nil }
		hi.DevIconJs = { ctermfg = 185, guifg = nil }
		hi.DevIconJson5 = { ctermfg = 185, guifg = nil }
		hi.DevIconJson = { ctermfg = 185, guifg = nil }
		hi.DevIconJsx = { ctermfg = 67, guifg = nil }
		hi.DevIconKotlin = { ctermfg = 208, guifg = nil }
		hi.DevIconKotlinScript = { ctermfg = 208, guifg = nil }
		hi.DevIconKsh = { ctermfg = 59, guifg = nil }
		hi.DevIconLeex = { ctermfg = 140, guifg = nil }
		hi.DevIconLess = { ctermfg = 60, guifg = nil }
		hi.DevIconLhs = { ctermfg = 140, guifg = nil }
		hi.DevIconLicense = { ctermfg = 185, guifg = nil }
		hi.DevIconLock = { ctermfg = 250, guifg = nil }
		hi.DevIconLog = { ctermfg = M.colors.base07, guifg = nil }
		hi.DevIconLua = { ctermfg = 74, guifg = nil }
		hi.DevIconLuau = { ctermfg = 74, guifg = nil }
		hi.DevIconMakefile = { ctermfg = 66, guifg = nil }
		hi.DevIconMarkdown = { ctermfg = 67, guifg = nil }
		hi.DevIconMaterial = { ctermfg = 132, guifg = nil }
		hi.DevIconMd = { ctermfg = M.colors.base07, guifg = nil }
		hi.DevIconMdx = { ctermfg = 67, guifg = nil }
		hi.DevIconMint = { ctermfg = 108, guifg = nil }
		hi.DevIconMixLock = { ctermfg = 140, guifg = nil }
		hi.DevIconMjs = { ctermfg = 221, guifg = nil }
		hi.DevIconMl = { ctermfg = 173, guifg = nil }
		hi.DevIconMli = { ctermfg = 173, guifg = nil }
		hi.DevIconMotoko = { ctermfg = 99, guifg = nil }
		hi.DevIconMustache = { ctermfg = 173, guifg = nil }
		hi.DevIconNPMIgnore = { ctermfg = 161, guifg = nil }
		hi.DevIconNPMrc = { ctermfg = 161, guifg = nil }
		hi.DevIconNim = { ctermfg = 220, guifg = nil }
		hi.DevIconNix = { ctermfg = 110, guifg = nil }
		hi.DevIconNodeModules = { ctermfg = 161, guifg = nil }
		hi.DevIconOPUS = { ctermfg = 208, guifg = nil }
		hi.DevIconOpenTypeFont = { ctermfg = 231, guifg = nil }
		hi.DevIconPackageJson = { ctermfg = 197, guifg = nil }
		hi.DevIconPackageLockJson = { ctermfg = 124, guifg = nil }
		hi.DevIconPackedResource = { ctermfg = 66, guifg = nil }
		hi.DevIconPdf = { ctermfg = 124, guifg = nil }
		hi.DevIconPhp = { ctermfg = 140, guifg = nil }
		hi.DevIconPl = { ctermfg = 67, guifg = nil }
		hi.DevIconPm = { ctermfg = 67, guifg = nil }
		hi.DevIconPng = { ctermfg = 140, guifg = nil }
		hi.DevIconPpt = { ctermfg = 167, guifg = nil }
		hi.DevIconPrisma = { ctermfg = M.colors.base07, guifg = nil }
		hi.DevIconProcfile = { ctermfg = 140, guifg = nil }
		hi.DevIconProlog = { ctermfg = 179, guifg = nil }
		hi.DevIconPromptPs1 = { ctermfg = 59, guifg = nil }
		hi.DevIconPsb = { ctermfg = 67, guifg = nil }
		hi.DevIconPsd = { ctermfg = 67, guifg = nil }
		hi.DevIconPy = { ctermfg = 61, guifg = nil }
		hi.DevIconPyc = { ctermfg = 67, guifg = nil }
		hi.DevIconPyd = { ctermfg = 67, guifg = nil }
		hi.DevIconPyo = { ctermfg = 67, guifg = nil }
		hi.DevIconQuery = { ctermfg = 154, guifg = nil }
		hi.DevIconR = { ctermfg = 65, guifg = nil }
		hi.DevIconRake = { ctermfg = 52, guifg = nil }
		hi.DevIconRakefile = { ctermfg = 52, guifg = nil }
		hi.DevIconRb = { ctermfg = 52, guifg = nil }
		hi.DevIconRlib = { ctermfg = 180, guifg = nil }
		hi.DevIconRmd = { ctermfg = 67, guifg = nil }
		hi.DevIconRproj = { ctermfg = 65, guifg = nil }
		hi.DevIconRs = { ctermfg = 180, guifg = nil }
		hi.DevIconRss = { ctermfg = 215, guifg = nil }
		hi.DevIconSass = { ctermfg = 204, guifg = nil }
		hi.DevIconScala = { ctermfg = 167, guifg = nil }
		hi.DevIconScheme = { ctermfg = 16, guifg = nil }
		hi.DevIconScss = { ctermfg = 204, guifg = nil }
		hi.DevIconSettingsJson = { ctermfg = 98, guifg = nil }
		hi.DevIconSh = { ctermfg = 59, guifg = nil }
		hi.DevIconSig = { ctermfg = 173, guifg = nil }
		hi.DevIconSlim = { ctermfg = 166, guifg = nil }
		hi.DevIconSln = { ctermfg = 98, guifg = nil }
		hi.DevIconSml = { ctermfg = 173, guifg = nil }
		hi.DevIconSolidity = { ctermfg = 67, guifg = nil }
		hi.DevIconSql = { ctermfg = 188, guifg = nil }
		hi.DevIconStyl = { ctermfg = 107, guifg = nil }
		hi.DevIconSuo = { ctermfg = 98, guifg = nil }
		hi.DevIconSvelte = { ctermfg = 202, guifg = nil }
		hi.DevIconSvg = { ctermfg = 215, guifg = nil }
		hi.DevIconSwift = { ctermfg = 173, guifg = nil }
		hi.DevIconSystemVerilog = { ctermfg = 29, guifg = nil }
		hi.DevIconTFVars = { ctermfg = 57, guifg = nil }
		hi.DevIconTcl = { ctermfg = 67, guifg = nil }
		hi.DevIconTerminal = { ctermfg = 71, guifg = nil }
		hi.DevIconTerraform = { ctermfg = 57, guifg = nil }
		hi.DevIconTex = { ctermfg = 58, guifg = nil }
		hi.DevIconTextResource = { ctermfg = 185, guifg = nil }
		hi.DevIconTextScene = { ctermfg = 140, guifg = nil }
		hi.DevIconToml = { ctermfg = 66, guifg = nil }
		hi.DevIconTor = { ctermfg = 67, guifg = nil }
		hi.DevIconTs = { ctermfg = 67, guifg = nil }
		hi.DevIconTsx = { ctermfg = 67, guifg = nil }
		hi.DevIconTwig = { ctermfg = 107, guifg = nil }
		hi.DevIconTxt = { ctermfg = 113, guifg = nil }
		hi.DevIconVHDL = { ctermfg = 29, guifg = nil }
		hi.DevIconVagrantfile = { ctermfg = 27, guifg = nil }
		hi.DevIconVerilog = { ctermfg = 29, guifg = nil }
		hi.DevIconVim = { ctermfg = 29, guifg = nil }
		hi.DevIconVimrc = { ctermfg = 29, guifg = nil }
		hi.DevIconVue = { ctermfg = 107, guifg = nil }
		hi.DevIconWebmanifest = { ctermfg = 221, guifg = nil }
		hi.DevIconWebp = { ctermfg = 140, guifg = nil }
		hi.DevIconWebpack = { ctermfg = 67, guifg = nil }
		hi.DevIconXcPlayground = { ctermfg = 173, guifg = nil }
		hi.DevIconXls = { ctermfg = 23, guifg = nil }
		hi.DevIconXml = { ctermfg = 173, guifg = nil }
		hi.DevIconXul = { ctermfg = 173, guifg = nil }
		hi.DevIconYaml = { ctermfg = 66, guifg = nil }
		hi.DevIconYml = { ctermfg = 66, guifg = nil }
		hi.DevIconZig = { ctermfg = 208, guifg = nil }
		hi.DevIconZsh = { ctermfg = 113, guifg = nil }
		hi.DevIconZshenv = { ctermfg = 113, guifg = nil }
		hi.DevIconZshprofile = { ctermfg = 113, guifg = nil }
		hi.DevIconZshrc = { ctermfg = 113, guifg = nil }
		hi.DevIconsbt = { ctermfg = 167, guifg = nil }
	end

	hi.rustPanic = { ctermfg = M.colors.base08, ctermbg = nil, cterm = nil }

	vim.g.terminal_color_0 = M.colors.base00
	vim.g.terminal_color_1 = M.colors.base08
	vim.g.terminal_color_2 = M.colors.base0B
	vim.g.terminal_color_3 = M.colors.base0A
	vim.g.terminal_color_4 = M.colors.base0D
	vim.g.terminal_color_5 = M.colors.base0E
	vim.g.terminal_color_6 = M.colors.base0C
	vim.g.terminal_color_7 = M.colors.base05
	vim.g.terminal_color_8 = M.colors.base03
	vim.g.terminal_color_9 = M.colors.base08
	vim.g.terminal_color_10 = M.colors.base0B
	vim.g.terminal_color_11 = M.colors.base0A
	vim.g.terminal_color_12 = M.colors.base0D
	vim.g.terminal_color_13 = M.colors.base0E
	vim.g.terminal_color_14 = M.colors.base0C
	vim.g.terminal_color_15 = M.colors.base07
end

return M
