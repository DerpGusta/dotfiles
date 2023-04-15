local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- TERMINAL MODE
map("t", "<leader><Esc>", "<C-\\><C-n>", opts)

-- NORMAL MODE

-- Telescope select files
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<cr>", opts)
map("n", "<C-Down>", ":resize -2<cr>", opts)
map("n", "<C-Left>", ":vertical resize +2<cr>", opts)
map("n", "<C-Right>", ":vertical resize -2<cr>", opts)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-j>", ":m .+1<cr>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", opts)
map("n", "<A-k>", ":m .-2<cr>==", opts)
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", opts)

-- clear any highlights when <esc> is pressed
map("n", "<Esc>", ":noh<cr>", opts)

-- move one up/down display line instead of physicial line
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- list of buffers

-- INSERT MODE

-- VISUAL MODE

-- Search for visually selected text
map("v", "//", 'y/<C-R>"<cr>', opts)

-- Have the same buffer on clipboard for multiple pastes
map("v", "p", "pgvy", opts)

-- VISUAL BLOCK MODE

-- Move current line / block with Alt-j/k ala vscode.
map("x", "<A-j>", ":m '>+1<cr>gv-gv", opts)
map("x", "<A-k>", ":m '<-2<cr>gv-gv", opts)

-- Use tab for indenting in visual mode
map("x", "<Tab>", ">gv|", opts)
map("x", "<S-Tab>", "<gv", opts)

-- Copy to system clipboard
map("x", "\\y", '"+y', opts)
map("x", "\\Y", '"*y', opts)

-- Cut to system clipboard
map("x", "\\d", '"+d', opts)
map("x", "\\D", '"*d', opts)

-- Paste from system clipboard
map("n", "\\p", '<ESC>"+p', opts)
map("n", "\\P", '<ESC>"*p', opts)


-- DAP
map("n", "<F5>", "<cmd>require'dap'.continue<cr>", opts)
map("n", "<F10>", "<cmd>require'dap'.step_over<cr>", opts)
map("n", "<F11>", "<cmd>require'dap'.step_into<cr>", opts)
map("n", "<F12>", "<cmd>require'dap'.step_out<cr>", opts)

-- quickfix mappings
map("n", "[q", ":cprevious<cr>", opts)
map("n", "]q", ":cnext<cr>", opts)
map("n", "]Q", ":clast<cr>", opts)
map("n", "[Q", ":cfirst<cr>", opts)

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

map("n", "<C-q>", ":call QuickFixToggle()<cr>", opts)

