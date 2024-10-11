-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
--  INSERT MODE
-- vim.keymap.set('i', 'jk', '<Esc>l', { desc = 'Get back to normal mode more easily [jk]' })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', {
  noremap = true,
  silent = true,
  desc = 'Duplicate the ctrl-backspace behavior of most text editors',
})

-- NORMAL MODE
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Go back to the file explorer' })

vim.keymap.set('n', '<leader>,', 'mzA,<Esc>`z', { desc = 'Append comma to the end of the line' })
vim.keymap.set('n', '<leader>;', 'mzA;<Esc>`z', { desc = 'Append semicolon to the end of the line' })
vim.keymap.set('n', '<leader>.', 'mzA.<Esc>`z', { desc = 'Append period to the end of the line' })

-- <C-d> and <C-u> for scrolling down and up are old and busted!
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep cursor centered on page while navigating' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep cursor centered on page while navigating' })

-- Put the search result in the middle of the screen too!
vim.keymap.set('n', 'n', 'nzzzn') -- The zn is for folding compatibility
vim.keymap.set('n', 'N', 'Nzzzn') -- The zn is for folding compatibility

-- Don't yank the thing you are pasting over the top of (aka Make Pasting Great Again)
vim.keymap.set('x', 'p', '"_dP', { desc = '[P]ut without yanking' })

-- Moving highlighted lines of text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted text line-wise' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted text line-wise' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep your cursor in the same place while joining lines' })

vim.keymap.set('n', 'm', ']m', { desc = 'Just to next [M]ethod' })
vim.keymap.set('n', 'M', '[m', { desc = 'Just to previous [M]ethod' })

-- Navigate between quickfix items
vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz', { desc = 'Next Quickfix item' })
vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz', { desc = 'Previous Quickfix item' })

vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<CR>', { desc = '[Q]uit [T]ab' })

-- When you don't want to delete and not "cut"
-- Unfortunately <leader>d won't work because it conflicts with the LSP <leader>ds for searching doc symbols
vim.keymap.set('n', '<leader>dd', '"_d')
vim.keymap.set('v', '<leader>dd', '"_d')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Q is the same as :q! (dangerous!)
vim.keymap.set('n', 'Q', '<nop>')

-- Do a find and replace
vim.keymap.set('n', '<leader>rp', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Find and [R]e[P]lace in current file' })

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Reselect pasted text
vim.keymap.set('n', 'p', 'p`[v`]')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>mzA;<Esc>`za')
vim.keymap.set('i', ',,', '<Esc>mzA,<Esc>`za')
