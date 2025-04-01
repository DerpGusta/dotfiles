local map = vim.keymap.set

map("n", "j", "v:count == 0 ? 'gj' : 'j'" , { expr = true})
map("n", "k", "v:count == 0 ? 'gk' : 'k'" , { expr = true})

map("v", "<" , "<gv")
map("v", ">" , ">gv")

-- Move lines up and down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv",{silent=true})
map("v", "K", ":m '<-2<cr>gv=gv",{silent=true})

map("n", "<C-S-h>", "<C-w>h")
map("n", "<C-S-j>", "<C-w>j")
map("n", "<C-S-k>", "<C-w>k")
map("n", "<C-S-l>", "<C-w>l")

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


-- Enable and disable autoformatting
map('n','<leader>ae', ":FormatEnable<CR>" , {silent=true}) -- Enable autoformat
map('n','<leader>ad', ":FormatDisable<CR>", {silent=true}) -- Disable autoformat
