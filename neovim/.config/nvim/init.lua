if vim.g.neovide then
  vim.o.guifont = "Iosevka Comfy Fixed,Symbols Nerd Font:h10:#e-antialias"
  -- vim.o.linespacing = 0 -- use a negative number for reducing space between characters
  vim.g.neovide_remember_window_size = true

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5

  vim.g.neovide_cursor_unfocused_outline_width = 0.05
  vim.g.neovide_cursor_antialiasing = false

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_input_use_logo = false

  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_scale_factor = 1.0

  --
  -- Increase font size
  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.10
  end, {})
  -- Decrease font size
  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.10
  end, {})
  -- Reset font size
  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, {})
  local uv = vim.uv
  local home = os.getenv("HOME")
  local filepath = home .. "/.cache/wal/last_used_theme"

  -- Check current pywal theme and sets the background accordingly
  local function bg_toggle()
    local file = io.open(home .. "/.cache/wal/last_used_theme", "r")
    if not file then
      print("theme_toggle: cannot read file")
    else
      local line = file:read("*l")
      file:close()
      -- Find the position of the first period and substring up to the period if it exists
      line = string.sub(line, 1, string.find(line, "%.") - 1 or #line + 1)
      if line == "gruvbox-dark" then
        vim.schedule(function()
          vim.o.background = "dark"
        end)
      elseif line == "gruvbox-light" then
        vim.schedule(function()
          vim.o.background = "light"
        end)
      end
    end
  end
  local function watch_with_function(path, on_event, on_error, opts)
    -- TODO: Check for 'fail'? What is 'fail' in the context of handle creation?
    --       Probably everything else is on fire anyway (or no inotify/etc?).
    local handle = uv.new_fs_event()

    -- these are just the default values
    local flags = {
      watch_entry = false, -- true = when dir, watch dir inode, not dir content
      stat = false, -- true = don't use inotify/kqueue but periodic check, not implemented
      recursive = false, -- true = watch dirs inside dirs
    }

    local unwatch_cb = function()
      uv.fs_event_stop(handle)
    end

    local event_cb = function(err, filename, events)
      if err then
        on_error(error, unwatch_cb)
      else
        on_event(filename, events, unwatch_cb)
      end
      if opts.is_oneshot then
        unwatch_cb()
      end
    end

    -- attach handler
    uv.fs_event_start(handle, path, flags, event_cb)

    return handle
  end

  local function error_handler(error, _)
    print("error when changing theme" .. error)
  end
  watch_with_function(filepath, bg_toggle, error_handler, { is_oneshot = false })
  bg_toggle()
end

local indent = 2
local scroll = 2

vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.shiftwidth = indent
vim.o.tabstop = indent
vim.o.expandtab = true
vim.o.scrolloff = scroll
vim.o.sidescrolloff = scroll
vim.o.inccommand = "split"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeoutlen = 300
vim.o.updatetime = 200 -- used by CursorHold event
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
-- vim.o.cmdheight = 2
vim.o.foldcolumn = "1"
vim.o.signcolumn = "number"
vim.o.conceallevel = 2
vim.o.foldlevel = 99 -- Using ufo provider need a large value (sourced from docs)
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob:~,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.diagnostic.config({ virtual_text = false })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
    { import = "plugins.treesitter" },
  },
  defaults = { lazy = true },
  install = { missing = true, colorscheme = { "habamax" } },
  rocks = {
    enabled = true,
    hererocks = true,
  },
  ui = {
    size = { width = 0.9, height = 0.9 },
    wrap = true,
    border = "single", -- see nvim_open_win() for more values
  },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = {},
  },
}
require("lazy").setup(opts)
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Plugin Manager" })
