return {
  "https://git.sr.ht/~nedia/auto-save.nvim",
  event = { "BufReadPre" },
  opts = {
    events = { 'InsertLeave', 'BufLeave' },
    silent = true,
    exclude_ft = { 'neo-tree','oil' },
  },
}
