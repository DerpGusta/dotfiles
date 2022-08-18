local options = {
	completeopt = {'menuone','noselect'},
	cursorline = true,
	expandtab = true,
	fileencoding = 'utf-8',
	guifont = "JetBrains_Mono:h8.5",
	hlsearch = true,
	ignorecase = true,
	incsearch = true,
	laststatus = 3,
	mouse = 'a',
	number = true,
	scrolloff = 8,
	shiftwidth = 2,
	showcmd = false,
	showmode = false,
	sidescrolloff = 8,
	tabstop = 2,
	termguicolors = true,
	timeoutlen = 300,
	undofile = false,
	updatetime = 300,
	wrap = false,
  signcolumn = "number",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  fillchars = { eob = ' ' },
}


for k, v in pairs(options) do
	vim.opt[k] = v
end
