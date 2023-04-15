return {
{
"iamcco/markdown-preview.nvim",
event = "BufRead",
ft = "markdown",
build = function()
vim.fn["mkdp#util#install"]()
end,
},
}
