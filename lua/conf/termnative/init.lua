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
        airline = true,
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

    hi["@comment"] = "TSComment"
    hi["@error"] = "TSError"
    hi["@none"] = "TSNone"
    hi["@preproc"] = "PreProc"
    hi["@define"] = "Define"
    hi["@operator"] = "TSOperator"
    hi["@punctuation.delimiter"] = "TSPunctDelimiter"
    hi["@punctuation.bracket"] = "TSPunctBracket"
    hi["@punctuation.special"] = "TSPunctSpecial"
    hi["@string"] = "TSString"
    hi["@string.regex"] = "TSStringRegex"
    hi["@string.escape"] = "TSStringEscape"
    hi["@string.special"] = "SpecialChar"
    hi["@character"] = "TSCharacter"
    hi["@character.special"] = "SpecialChar"
    hi["@boolean"] = "TSBoolean"
    hi["@number"] = "TSNumber"
    hi["@float"] = "TSFloat"
    hi["@function"] = "TSFunction"
    hi["@function.call"] = "TSFunction"
    hi["@function.builtin"] = "TSFuncBuiltin"
    hi["@function.macro"] = "TSFuncMacro"
    hi["@method"] = "TSMethod"
    hi["@method.call"] = "TSMethod"
    hi["@constructor"] = "TSConstructor"
    hi["@parameter"] = "TSParameter"
    hi["@keyword"] = "TSKeyword"
    hi["@keyword.function"] = "TSKeywordFunction"
    hi["@keyword.operator"] = "TSKeywordOperator"
    hi["@keyword.return"] = "TSKeyword"
    hi["@conditional"] = "TSConditional"
    hi["@repeat"] = "TSRepeat"
    hi["@debug"] = "Debug"
    hi["@label"] = "TSLabel"
    hi["@include"] = "TSInclude"
    hi["@exception"] = "TSException"
    hi["@type"] = "TSType"
    hi["@type.builtin"] = "TSTypeBuiltin"
    hi["@type.qualifier"] = "TSType"
    hi["@type.definition"] = "TSType"
    hi["@storageclass"] = "StorageClass"
    hi["@attribute"] = "TSAttribute"
    hi["@field"] = "TSField"
    hi["@property"] = "TSProperty"
    hi["@variable"] = "TSVariable"
    hi["@variable.builtin"] = "TSVariableBuiltin"
    hi["@constant"] = "TSConstant"
    hi["@constant.builtin"] = "TSConstant"
    hi["@constant.macro"] = "TSConstant"
    hi["@namespace"] = "TSNamespace"
    hi["@symbol"] = "TSSymbol"
    hi["@text"] = "TSText"
    hi["@text.strong"] = "TSStrong"
    hi["@text.emphasis"] = "TSEmphasis"
    hi["@text.underline"] = "TSUnderline"
    hi["@text.strike"] = "TSStrike"
    hi["@text.title"] = "TSTitle"
    hi["@text.literal"] = "TSLiteral"
    hi["@text.uri"] = "TSUri"
    hi["@text.math"] = "Number"
    hi["@text.environment"] = "Macro"
    hi["@text.environment.name"] = "Type"
    hi["@text.reference"] = "TSParameterReference"
    hi["@text.todo"] = "Todo"
    hi["@text.note"] = "Tag"
    hi["@text.warning"] = "DiagnosticWarn"
    hi["@text.danger"] = "DiagnosticError"
    hi["@tag"] = "TSTag"
    hi["@tag.attribute"] = "TSAttribute"
    hi["@tag.delimiter"] = "TSTagDelimiter"

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

    if M.config.airline then
        hi.airline_x_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_x_inactive_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_x_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_y_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_y_inactive_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_y_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_z_inactive = { ctermfg = M.colors.base01, ctermbg = M.colors.base03, cterm = nil }
        hi.airline_z_inactive_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base03, cterm = "bold" }
        hi.airline_z_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base03, cterm = nil }
        hi.airline_term_inactive = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
        hi.airline_term_inactive_bold = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = "bold" }
        hi.airline_term_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
        hi.airline_error_inactive = { ctermfg = M.colors.base00, ctermbg = 160, cterm = nil }
        hi.airline_error_inactive_bold = { ctermfg = M.colors.base00, ctermbg = 160, cterm = "bold" }
        hi.airline_error_inactive_red = { ctermfg = M.colors.base08, ctermbg = 160, cterm = nil }
        hi.airline_a_inactive = { ctermfg = M.colors.base01, ctermbg = M.colors.base03, cterm = nil }
        hi.airline_a_inactive_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base03, cterm = "bold" }
        hi.airline_a_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base03, cterm = nil }
        hi.airline_b_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_b_inactive_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_b_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c_inactive_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_c_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_warning_inactive = { ctermfg = M.colors.base00, ctermbg = 166, cterm = nil }
        hi.airline_warning_inactive_bold = { ctermfg = M.colors.base00, ctermbg = 166, cterm = "bold" }
        hi.airline_warning_inactive_red = { ctermfg = M.colors.base08, ctermbg = 166, cterm = nil }
        hi.airline_x = { ctermfg = M.colors.base0C, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_x_bold = { ctermfg = M.colors.base0C, ctermbg = M.colors.base01, cterm = "bold" }
        hi.airline_x_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_y = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_y_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_y_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_z = { ctermfg = M.colors.base01, ctermbg = M.colors.base0C, cterm = nil }
        hi.airline_z_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base0C, cterm = "bold" }
        hi.airline_z_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base0C, cterm = nil }
        hi.airline_term = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = nil }
        hi.airline_term_bold = { ctermfg = M.colors.base0B, ctermbg = M.colors.base00, cterm = "bold" }
        hi.airline_term_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base00, cterm = nil }
        hi.airline_error = { ctermfg = M.colors.base01, ctermbg = M.colors.base08, cterm = nil }
        hi.airline_error_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base08, cterm = "bold" }
        hi.airline_error_red = { ctermfg = M.colors.base08, ctermbg = 204, cterm = nil }
        hi.airline_a = { ctermfg = M.colors.base01, ctermbg = M.colors.base0C, cterm = nil }
        hi.airline_a_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base0C, cterm = "bold" }
        hi.airline_a_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base0C, cterm = nil }
        hi.airline_b = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_b_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_b_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c = { ctermfg = M.colors.base0C, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_c_bold = { ctermfg = M.colors.base0C, ctermbg = M.colors.base01, cterm = "bold" }
        hi.airline_c_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_warning = { ctermfg = M.colors.base01, ctermbg = M.colors.base0A, cterm = nil }
        hi.airline_warning_bold = { ctermfg = M.colors.base01, ctermbg = M.colors.base0A, cterm = "bold" }
        hi.airline_warning_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base0A, cterm = nil }
        hi.airline_a_to_airline_b = { ctermfg = M.colors.base0C, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_b_to_airline_c = { ctermfg = M.colors.base02, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_c_to_airline_x = { ctermfg = M.colors.base01, ctermbg = 236, cterm = nil }
        hi.airline_x_to_airline_y = { ctermfg = M.colors.base02, ctermbg = M.colors.base01, cterm = nil }
        hi.airline_y_to_airline_z = { ctermfg = M.colors.base0C, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_z_to_airline_warning = { ctermfg = M.colors.base0A, ctermbg = M.colors.base0C, cterm = nil }
        hi.airline_warning_to_airline_error = { ctermfg = M.colors.base08, ctermbg = M.colors.base0A, cterm = nil }
        hi.airline_c1_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c1_to_airline_x = { ctermfg = M.colors.base01, ctermbg = M.colors.base00, cterm = nil }
        hi.airline_c3_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c1_inactive_bold = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = "bold" }
        hi.airline_c1_inactive_red = { ctermfg = M.colors.base08, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_x_to_airline_y_inactive = { ctermfg = M.colors.base02, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_z_to_airline_warning_inactive = { ctermfg = 166, ctermbg = M.colors.base03, cterm = nil }
        hi.airline_c1_to_airline_x_inactive = { ctermfg = M.colors.base02, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c_to_airline_x_inactive = { ctermfg = M.colors.base02, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_a_to_airline_b_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_warning_to_airline_error_inactive = { ctermfg = 160, ctermbg = 166, cterm = nil }
        hi.airline_y_to_airline_z_inactive = { ctermfg = M.colors.base03, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_b_to_airline_c_inactive = { ctermfg = M.colors.base02, ctermbg = M.colors.base02, cterm = nil }
        hi.airline_c3_to_airline_x = { ctermfg = M.colors.base01, ctermbg = M.colors.base00, cterm = nil }
    end

    if M.config.nvim_tree then
        hi.NvimTreeLiveFilterPrefix = { cterm = "bold" }
        hi.NvimTreeLiveFilterValue = { cterm = "bold" }
        hi.NvimTreeIndentMarker = { ctermfg = M.colors.base04 }
        hi.NvimTreeSymlink = { cterm = "bold" }
        hi.NvimTreeFolderIcon = { ctermfg = M.colors.base04 }
        hi.NvimTreeExecFile = { cterm = "bold" }
        hi.NvimTreeSpecialFile = { cterm = "bold,underline" }
        hi.NvimTreeWindowPicker = { cterm = "bold", ctermbg = M.colors.base04 }
        hi.NvimTreeStatusLine = "StatusLine"
        hi.NvimTreeStatusLineNC = "StatusLineNC"
        hi.NvimTreeVertSplit = "VertSplit"
        hi.NvimTreeFolderName = "Directory"
        hi.NvimTreeEmptyFolderName = "Directory"
        hi.NvimTreeOpenedFolderName = "Directory"
        hi.NvimTreeCursorColumn = "CursorColumn"
        hi.NvimTreeGitIgnored = "Comment"
        hi.NvimTreeCursorLine = "CursorLine"
        hi.NvimTreeFileIgnored = "NvimTreeGitIgnored"
        hi.NvimTreeNormal = "Normal"
        hi.NvimTreeEndOfBuffer = "EndOfBuffer"
        hi.NvimTreeWinSeparator = "NvimTreeVertSplit"
        hi.NvimTreeCursorLineNr = "CursorLineNr"
        hi.NvimTreeFileDirty = "NvimTreeGitDirty"
        hi.NvimTreeFileNew = "NvimTreeGitNew"
        hi.NvimTreeFileRenamed = "NvimTreeGitRenamed"
        hi.NvimTreeFileMerge = "NvimTreeGitMerge"
        hi.NvimTreeFileStaged = "NvimTreeGitStaged"
        hi.NvimTreeFileDeleted = "NvimTreeGitDeleted"
        hi.NvimTreeNormalNC = "NvimTreeNormal"
        hi.NvimTreePopup = "Normal"
        hi.NvimTreeLineNr = "LineNr"
        hi.NvimTreeSignColumn = "NvimTreeNormal"
        hi.NvimTreeLspDiagnosticsError = "DiagnosticError"
        hi.NvimTreeLspDiagnosticsWarning = "DiagnosticWarn"
        hi.NvimTreeLspDiagnosticsInformation = "DiagnosticInfo"
        hi.NvimTreeLspDiagnosticsHint = "DiagnosticHint"

        hi.DevIconCPlusPlus = { ctermfg = M.colors.base05 }
        hi.DevIconFennel = { ctermfg = M.colors.base05 }
        hi.DevIconSig = { ctermfg = M.colors.base01 }
        hi.DevIconSlim = { ctermfg = M.colors.base05 }
        hi.DevIconFish = { ctermfg = M.colors.base08 }
        hi.DevIconSln = { ctermfg = M.colors.base05 }
        hi.DevIconFsi = { ctermfg = M.colors.base04 }
        hi.DevIconFsscript = { ctermfg = M.colors.base04 }
        hi.DevIconFsx = { ctermfg = M.colors.base04 }
        hi.DevIconSql = { ctermfg = M.colors.base05 }
        hi.DevIconStyl = { ctermfg = M.colors.base02 }
        hi.DevIconGemspec = { ctermfg = M.colors.base09 }
        hi.DevIconNPMrc = { ctermfg = M.colors.base09 }
        hi.DevIconSuo = { ctermfg = M.colors.base05 }
        hi.DevIconBinaryGLTF = { ctermfg = M.colors.base09 }
        hi.DevIconNodeModules = { ctermfg = M.colors.base09 }
        hi.DevIconDump = { ctermfg = M.colors.base05 }
        hi.DevIconSwift = { ctermfg = M.colors.base01 }
        hi.DevIconCsv = { ctermfg = M.colors.base02 }
        hi.DevIconGruntfile = { ctermfg = M.colors.base01 }
        hi.DevIconTcl = { ctermfg = M.colors.base04 }
        hi.DevIconGulpfile = { ctermfg = M.colors.base02 }
        hi.DevIconTex = { ctermfg = M.colors.base03 }
        hi.DevIconHaml = { ctermfg = M.colors.base05 }
        hi.DevIconDefault = { ctermfg = M.colors.base04 }
        hi.DevIconClojureJS = { ctermfg = M.colors.base04 }
        hi.DevIconFavicon = { ctermfg = M.colors.base03 }
        hi.DevIconHeex = { ctermfg = M.colors.base05 }
        hi.DevIconFs = { ctermfg = M.colors.base04 }
        hi.DevIconHh = { ctermfg = M.colors.base05 }
        hi.DevIconD = { ctermfg = M.colors.base02 }
        hi.DevIconHpp = { ctermfg = M.colors.base05 }
        hi.DevIconMotoko = { ctermfg = M.colors.base05 }
        hi.DevIconHrl = { ctermfg = M.colors.base05 }
        hi.DevIconPsd = { ctermfg = M.colors.base04 }
        hi.DevIconHs = { ctermfg = M.colors.base05 }
        hi.DevIconsbt = { ctermfg = M.colors.base02 }
        hi.DevIconTerminal = { ctermfg = M.colors.base06 }
        hi.DevIconHtm = { ctermfg = M.colors.base05 }
        hi.DevIconExs = { ctermfg = M.colors.base05 }
        hi.DevIconGodotProject = { ctermfg = M.colors.base04 }
        hi.DevIconSass = { ctermfg = M.colors.base05 }
        hi.DevIconToml = { ctermfg = M.colors.base04 }
        hi.DevIconHxx = { ctermfg = M.colors.base05 }
        hi.DevIconTs = { ctermfg = M.colors.base04 }
        hi.DevIconElm = { ctermfg = M.colors.base04 }
        hi.DevIconCs = { ctermfg = M.colors.base03 }
        hi.DevIconTwig = { ctermfg = M.colors.base02 }
        hi.DevIconIni = { ctermfg = M.colors.base04 }
        hi.DevIconErl = { ctermfg = M.colors.base05 }
        hi.DevIconJava = { ctermfg = M.colors.base02 }
        hi.DevIconDiff = { ctermfg = M.colors.base08 }
        hi.DevIconJl = { ctermfg = M.colors.base05 }
        hi.DevIconCp = { ctermfg = M.colors.base04 }
        hi.DevIconTextResource = { ctermfg = M.colors.base03 }
        hi.DevIconLuau = { ctermfg = M.colors.base04 }
        hi.DevIconSml = { ctermfg = M.colors.base01 }
        hi.DevIconImportConfiguration = { ctermfg = M.colors.base07 }
        hi.DevIconJs = { ctermfg = M.colors.base03 }
        hi.DevIconYaml = { ctermfg = M.colors.base04 }
        hi.DevIconGraphQL = { ctermfg = M.colors.base05 }
        hi.DevIconBashProfile = { ctermfg = M.colors.base02 }
        hi.DevIconJson5 = { ctermfg = M.colors.base03 }
        hi.DevIconBat = { ctermfg = M.colors.base02 }
        hi.DevIconJsx = { ctermfg = M.colors.base04 }
        hi.DevIconEjs = { ctermfg = M.colors.base03 }
        hi.DevIconBashrc = { ctermfg = M.colors.base02 }
        hi.DevIconBabelrc = { ctermfg = M.colors.base03 }
        hi.DevIconDsStore = { ctermfg = M.colors.base08 }
        hi.DevIconCoffee = { ctermfg = M.colors.base03 }
        hi.DevIconGo = { ctermfg = M.colors.base04 }
        hi.DevIconSystemVerilog = { ctermfg = M.colors.base06 }
        hi.DevIconGitAttributes = { ctermfg = M.colors.base08 }
        hi.DevIconMixLock = { ctermfg = M.colors.base05 }
        hi.DevIconKsh = { ctermfg = M.colors.base08 }
        hi.DevIconGitConfig = { ctermfg = M.colors.base08 }
        hi.DevIconGitIgnore = { ctermfg = M.colors.base08 }
        hi.DevIconConfigRu = { ctermfg = M.colors.base09 }
        hi.DevIconGitlabCI = { ctermfg = M.colors.base05 }
        hi.DevIconLeex = { ctermfg = M.colors.base05 }
        hi.DevIconVagrantfile = { ctermfg = M.colors.base04 }
        hi.DevIconGitModules = { ctermfg = M.colors.base08 }
        hi.DevIconMl = { ctermfg = M.colors.base01 }
        hi.DevIconGvimrc = { ctermfg = M.colors.base06 }
        hi.DevIconLicense = { ctermfg = M.colors.base03 }
        hi.DevIconPyo = { ctermfg = M.colors.base04 }
        hi.DevIconCobol = { ctermfg = M.colors.base04 }
        hi.DevIconCrystal = { ctermfg = M.colors.base00 }
        hi.DevIconNPMIgnore = { ctermfg = M.colors.base09 }
        hi.DevIconMakefile = { ctermfg = M.colors.base04 }
        hi.DevIconMaterial = { ctermfg = M.colors.base05 }
        hi.DevIconVimrc = { ctermfg = M.colors.base06 }
        hi.DevIconMd = { ctermfg = M.colors.base07 }
        hi.DevIconSettingsJson = { ctermfg = M.colors.base05 }
        hi.DevIconCsh = { ctermfg = M.colors.base08 }
        hi.DevIconPackedResource = { ctermfg = M.colors.base04 }
        hi.DevIconPdf = { ctermfg = M.colors.base01 }
        hi.DevIconMdx = { ctermfg = M.colors.base04 }
        hi.DevIconMint = { ctermfg = M.colors.base06 }
        hi.DevIconZshprofile = { ctermfg = M.colors.base02 }
        hi.DevIconPng = { ctermfg = M.colors.base05 }
        hi.DevIconZshenv = { ctermfg = M.colors.base02 }
        hi.DevIconZshrc = { ctermfg = M.colors.base02 }
        hi.DevIconNim = { ctermfg = M.colors.base03 }
        hi.DevIconBrewfile = { ctermfg = M.colors.base09 }
        hi.DevIconJpg = { ctermfg = M.colors.base05 }
        hi.DevIconDoc = { ctermfg = M.colors.base04 }
        hi.DevIconCxx = { ctermfg = M.colors.base04 }
        hi.DevIconCMakeLists = { ctermfg = M.colors.base04 }
        hi.DevIconJson = { ctermfg = M.colors.base03 }
        hi.DevIconClojure = { ctermfg = M.colors.base02 }
        hi.DevIconMli = { ctermfg = M.colors.base01 }
        hi.DevIconGitCommit = { ctermfg = M.colors.base08 }
        hi.DevIconWebp = { ctermfg = M.colors.base05 }
        hi.DevIconClojureC = { ctermfg = M.colors.base02 }
        hi.DevIconMustache = { ctermfg = M.colors.base01 }
        hi.DevIconDart = { ctermfg = M.colors.base04 }
        hi.DevIconClojureDart = { ctermfg = M.colors.base04 }
        hi.DevIconTFVars = { ctermfg = M.colors.base05 }
        hi.DevIconNix = { ctermfg = M.colors.base04 }
        hi.DevIconLhs = { ctermfg = M.colors.base05 }
        hi.DevIconLua = { ctermfg = M.colors.base04 }
        hi.DevIconRmd = { ctermfg = M.colors.base04 }
        hi.DevIconTextScene = { ctermfg = M.colors.base05 }
        hi.DevIconBmp = { ctermfg = M.colors.base05 }
        hi.DevIconTsx = { ctermfg = M.colors.base04 }
        hi.DevIconCpp = { ctermfg = M.colors.base04 }
        hi.DevIconBash = { ctermfg = M.colors.base02 }
        hi.DevIconOpenTypeFont = { ctermfg = M.colors.base07 }
        hi.DevIconVerilog = { ctermfg = M.colors.base06 }
        hi.DevIconTxt = { ctermfg = M.colors.base02 }
        hi.DevIconAi = { ctermfg = M.colors.base03 }
        hi.DevIconPackageLockJson = { ctermfg = M.colors.base01 }
        hi.DevIconVHDL = { ctermfg = M.colors.base06 }
        hi.DevIconGif = { ctermfg = M.colors.base05 }
        hi.DevIconIco = { ctermfg = M.colors.base03 }
        hi.DevIconDb = { ctermfg = M.colors.base05 }
        hi.DevIconCson = { ctermfg = M.colors.base03 }
        hi.DevIconPhp = { ctermfg = M.colors.base05 }
        hi.DevIconProcfile = { ctermfg = M.colors.base05 }
        hi.DevIconWebpack = { ctermfg = M.colors.base04 }
        hi.DevIconH = { ctermfg = M.colors.base05 }
        hi.DevIconJpeg = { ctermfg = M.colors.base05 }
        hi.DevIconXcPlayground = { ctermfg = M.colors.base01 }
        hi.DevIconPm = { ctermfg = M.colors.base04 }
        hi.DevIconXls = { ctermfg = M.colors.base06 }
        hi.DevIconVim = { ctermfg = M.colors.base06 }
        hi.DevIconVue = { ctermfg = M.colors.base02 }
        hi.DevIconCss = { ctermfg = M.colors.base04 }
        hi.DevIconScss = { ctermfg = M.colors.base05 }
        hi.DevIconXml = { ctermfg = M.colors.base01 }
        hi.DevIconR = { ctermfg = M.colors.base06 }
        hi.DevIconXul = { ctermfg = M.colors.base01 }
        hi.DevIconPpt = { ctermfg = M.colors.base02 }
        hi.DevIconYml = { ctermfg = M.colors.base04 }
        hi.DevIconDesktopEntry = { ctermfg = M.colors.base05 }
        hi.DevIconPromptPs1 = { ctermfg = M.colors.base08 }
        hi.DevIconLess = { ctermfg = M.colors.base05 }
        hi.DevIconPsb = { ctermfg = M.colors.base04 }
        hi.DevIconZsh = { ctermfg = M.colors.base02 }
        hi.DevIconCMake = { ctermfg = M.colors.base04 }
        hi.DevIconSolidity = { ctermfg = M.colors.base04 }
        hi.DevIconPy = { ctermfg = M.colors.base05 }
        hi.DevIconQuery = { ctermfg = M.colors.base02 }
        hi.DevIconEnv = { ctermfg = M.colors.base03 }
        hi.DevIconDockerfile = { ctermfg = M.colors.base08 }
        hi.DevIconDrools = { ctermfg = M.colors.base05 }
        hi.DevIconPyc = { ctermfg = M.colors.base04 }
        hi.DevIconAwk = { ctermfg = M.colors.base08 }
        hi.DevIconPrisma = { ctermfg = M.colors.base07 }
        hi.DevIconPyd = { ctermfg = M.colors.base04 }
        hi.DevIconDropbox = { ctermfg = M.colors.base04 }
        hi.DevIconLock = { ctermfg = M.colors.base08 }
        hi.DevIconMarkdown = { ctermfg = M.colors.base04 }
        hi.DevIconConfiguration = { ctermfg = M.colors.base07 }
        hi.DevIconGitLogo = { ctermfg = M.colors.base09 }
        hi.DevIconEdn = { ctermfg = M.colors.base04 }
        hi.DevIconRake = { ctermfg = M.colors.base09 }
        hi.DevIconEex = { ctermfg = M.colors.base05 }
        hi.DevIconRakefile = { ctermfg = M.colors.base09 }
        hi.DevIconGemfile = { ctermfg = M.colors.base09 }
        hi.DevIconRb = { ctermfg = M.colors.base09 }
        hi.DevIconGDScript = { ctermfg = M.colors.base04 }
        hi.DevIconHtml = { ctermfg = M.colors.base09 }
        hi.DevIconRproj = { ctermfg = M.colors.base06 }
        hi.DevIconLog = { ctermfg = M.colors.base07 }
        hi.DevIconErb = { ctermfg = M.colors.base09 }
        hi.DevIconSvg = { ctermfg = M.colors.base09 }
        hi.DevIconRss = { ctermfg = M.colors.base09 }
        hi.DevIconConf = { ctermfg = M.colors.base04 }
        hi.DevIconSvelte = { ctermfg = M.colors.base09 }
        hi.DevIconPackageJson = { ctermfg = M.colors.base05 }
        hi.DevIconTor = { ctermfg = M.colors.base04 }
        hi.DevIconEx = { ctermfg = M.colors.base05 }
        hi.DevIconC = { ctermfg = M.colors.base04 }
        hi.DevIconSh = { ctermfg = M.colors.base08 }
        hi.DevIconFsharp = { ctermfg = M.colors.base04 }
        hi.DevIconScala = { ctermfg = M.colors.base02 }
        hi.DevIconPl = { ctermfg = M.colors.base04 }
        hi.DevIconScheme = { ctermfg = M.colors.base00 }
        hi.DevIconTerraform = { ctermfg = M.colors.base05 }
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
