local hostname = vim.fn.hostname()
if hostname == "manjaro" then
    vim.g.wiki_root = '~/syncthing/common/wiki'
else
    vim.g.wiki_root =  '/mnt/c/Users/SriHarshaTolety/Syncthing/common/wiki'
end
vim.g.wiki_filetypes = { 'md','markdown'}
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_link_extension = '.md'
vim.g.wiki_tags_scan_num_lines = 20
-- vim.g.vimwiki_global_ext = 0 -- do not set filetype to vimwiki for all markdown
-- vim.g.vimwiki_table_mappings = 0 -- needed for snippets to work! (This was hassling me for days)
-- vim.g.vimwiki_list = {{ path= '/mnt/c/Users/SriHarshaTolety/Sync/wiki',syntax= 'markdown',ext= '.md'}}
-- vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown'}
