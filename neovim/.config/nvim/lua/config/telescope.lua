local telescope = require("telescope")
local actions = require('telescope.actions')

telescope.setup({
  extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },
  defaults = {
    -- mappings = { i = { ["<esc>"] = actions.close } },
    -- vimgrep_arguments = {
    --   'rg',
    --   '--color=never',
    --   '--no-heading',
    --   '--with-filename',
    --   '--line-number',
    --   '--column',
    --   '--smart-case'
    -- },
    -- prompt_position = "bottom",
    prompt_prefix = " ",
    selection_caret = " ",
    -- entry_prefix = "  ",
    -- initial_mode = "insert",
    -- selection_strategy = "reset",
    -- sorting_strategy = "descending",
    -- layout_strategy = "horizontal",
    -- layout_defaults = {
    --   horizontal = {
    --     mirror = false,
    --   },
    --   vertical = {
    --     mirror = false,
    --   },
    -- },
    -- file_sorter = require"telescope.sorters".get_fzy_file
    -- file_ignore_patterns = {},
    -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    -- shorten_path = true,
    winblend = 10,
    -- width = 0.7,
    -- preview_cutoff = 120,
    -- results_height = 1,
    -- results_width = 0.8,
    -- border = {},
    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    -- prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    -- results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    -- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    -- color_devicons = true,
    -- use_less = true,
    -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
})

