return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-t>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1",
			start_in_insert = true,
			hide_numbers = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
		})
	end,
	keys = {
		{ "<C-t>", "", desc = "Toggle Terminal" },
	},
}
