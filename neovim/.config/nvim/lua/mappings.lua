-- toggle highlight
--vim.api.nvim_set_keymap('n', '<leader>h', ':nohlsearch<CR>',{})

-- terminal shortcuts
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>',{noremap=true})
vim.api.nvim_set_keymap('t', '<C-v><Esc>', '<Esc>',{noremap=true})

-- settings shortcuts
-- vim.api.nvim_set_keymap('n', '<leader>ev', ':edit $MYVIMRC<CR>',{})
-- vim.api.nvim_set_keymap('n', '<leader>sv', ':luafile $MYVIMRC<CR>',{})
-- vim.api.nvim_set_keymap('n', '<leader>ep', ':edit ~/.config/nvim/lua/plugins.lua<CR>',{})
-- vim.api.nvim_set_keymap('n', '<leader>em', ':edit ~/.config/nvim/lua/mappings.lua<CR>',{})

----------vim-easy-align----------
vim.api.nvim_set_keymap('x','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('n','ga','<Plug>(EasyAlign)',{})
