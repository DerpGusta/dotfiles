local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

if not package.loaded['telescope']
then
	require('config.telescope')
end

M = {}

M.dot_picker = function ()
	local args ={
		cwd = "~/.config/nvim/",
		hidden = true
	}
	builtin.file_browser(args)
end

M.color_picker = function()
	local args = {
		enable_preview = true
	}
	builtin.colorscheme(args)
end

return M
