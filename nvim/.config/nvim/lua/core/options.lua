local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Indentation and columns
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.colorcolumn = "120"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Appearance
opt.termguicolors = true
opt.cmdheight = 1
opt.background = "dark"
opt.cursorline = true
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.wrap = false
opt.guicursor = "n-v-c:block,i:block-blinkwait400-blinkon200-blinkoff100"
opt.scrolloff = 8
opt.showtabline = 2

-- Behaviour
opt.clipboard:append("unnamedplus")
-- opt.shortmess:append("u")
opt.backspace = "indent,eol,start"
opt.mouse = ""

-- Code Folding
opt.foldlevelstart = 99
opt.foldtext = ""
opt.foldcolumn = "1"

vim.opt.fillchars:append({
	fold = "·",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = " ",
	foldinner = " ",
})
