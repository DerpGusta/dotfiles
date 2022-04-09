-- local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

if not package.loaded['telescope']
then
	require('config.telescope')
end

M = {}

M.dot_picker = function ()
	local opts ={
		cwd = "~/.config/nvim/",
		hidden = true
	}
	builtin.find_files(opts)
end

M.note_picker = function ()
    local opts = {
        search_dirs = { vim.g.wiki_root }
    }
    builtin.find_files(opts)
end

M.color_picker = function()
	local opts = {
		enable_preview = true
	}
	builtin.colorscheme(opts)
end

return M
