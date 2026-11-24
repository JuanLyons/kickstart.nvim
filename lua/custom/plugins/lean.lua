-- Lean 4: language server, infoview (proof goals) and unicode input.
-- Requires elan. Open .lean files inside a `lake new` project.

-- Lean's keys use <LocalLeader>. Kickstart sets that to Space, which would
-- override its <leader>s search keys in Lean files, so use backslash instead.
vim.g.maplocalleader = '\\'

vim.g.lean_config = { mappings = true }
vim.pack.add { 'https://github.com/Julian/lean.nvim' }
