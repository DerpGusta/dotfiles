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

