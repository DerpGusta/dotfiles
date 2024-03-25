local map = vim.keymap.set

map("n", "j", "v:count == 0 ? 'gj' : 'j'" , { expr = true})
map("n", "k", "v:count == 0 ? 'gk' : 'k'" , { expr = true})

map("v", "<" , "<gv")
map("v", ">" , ">gv")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("t", "<Esc>", "<C-\\><C-n>")

-- Yank into system clipboard
map({'n', 'v'}, '<leader>y', '"+y') -- yank motion
map({'n', 'v'}, '<leader>Y', '"+Y') -- yank line
--
-- -- Delete into system clipboard
map({'n', 'v'}, '<leader>d', '"+d') -- delete motion
map({'n', 'v'}, '<leader>D', '"+D') -- delete line
--
-- -- Paste from system clipboard
map('i', '<C-v>', '<esc>"+pa')  -- paste while in insert mode
map('n', '<leader>p', '"+p')  -- paste after cursor
map('n', '<leader>P', '"+P')  -- paste before cursor
