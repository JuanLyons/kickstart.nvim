-- render-markdown.nvim formats markdown inside the editor.
-- markdown-preview.nvim opens a live browser preview (images, diagrams, math).

-- markdown-preview.nvim needs a build step after install or update.
-- This must be defined before vim.pack.add so it runs on the first install.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'markdown-preview.nvim' and (kind == 'install' or kind == 'update') then
      vim.cmd.packadd(name)
      vim.fn['mkdp#util#install']()
    end
  end,
})

vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
}

require('render-markdown').setup {}

-- Open the preview in its own Firefox window (separate profile, app_id
-- "md-preview") so Sway keeps it on the current workspace.
local preview_profile = vim.fn.stdpath 'data' .. '/md-preview-firefox'
vim.fn.mkdir(preview_profile, 'p')
function _G.md_preview_open(url)
  vim.fn.jobstart({ 'firefox', '--profile', preview_profile, '--name', 'md-preview', '--new-window', url }, { detach = true })
end
vim.cmd [[
  function! MdPreviewOpen(url)
    call v:lua.md_preview_open(a:url)
  endfunction
]]
vim.g.mkdp_browserfunc = 'MdPreviewOpen'

vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { desc = '[M]arkdown browser [P]review' })
vim.keymap.set('n', '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', { desc = '[M]arkdown [R]ender toggle' })
require('which-key').add { { '<leader>m', group = '[M]arkdown' } }
