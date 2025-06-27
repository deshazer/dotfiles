-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Lazy "Escape"
vim.keymap.set('i', 'jk', '<Esc>l', { desc = 'Get back to normal mode more easily [jk]' })
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'This makes Ctrl-C clear Codeium suggestions' })

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Duplicate the ctrl-backspace behavior of most text editors
vim.keymap.set('i', '<C-Del>', '<C-o>dw', {
  noremap = true,
  silent = true,
  desc = 'Duplicate the ctrl-backspace behavior of most text editors',
})

-- Go to end or beginning of line more naturally
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Go to end of line [ -> ]' })
vim.keymap.set({ 'n', 'v' }, 'H', '_', { desc = 'Go to beginning of line [ <- ]' })

-- Easily append common line endings
vim.keymap.set('n', '<leader>,', 'mzA,<Esc>`z', { desc = 'Append comma to the end of the line' })
vim.keymap.set('n', '<leader>;', 'mzA;<Esc>`z', { desc = 'Append semicolon to the end of the line' })
vim.keymap.set('n', '<leader>.', 'mzA.<Esc>`z', { desc = 'Append period to the end of the line' })

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>mzA;<Esc>`za')
vim.keymap.set('i', ',,', '<Esc>mzA,<Esc>`za')

-- Don't yank the thing you are pasting over the top of (aka Make Pasting Great Again)
-- Also, paste before the cursor by default in visual mode
vim.keymap.set('x', 'p', '"_dP', { desc = '[P]ut without yanking' })
vim.keymap.set('x', 'P', '"_dp', { desc = '[P]ut without yanking' })

-- Moving highlighted lines of text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted text line-wise' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted text line-wise' })

-- Keep your cursor in the same place while joining lines
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep your cursor in the same place while joining lines' })

-- Disable annoying command line thing (but only if you type it fast)
vim.keymap.set('n', 'q:', '<nop>', { remap = true, desc = 'Disable annoying command line thing' })

-- Navigate between quickfix items
vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz', { desc = 'Next Quickfix item' })
vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz', { desc = 'Previous Quickfix item' })

-- Managing tabs
vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<CR>', { desc = '[Q]uit [T]ab' })

-- When you don't want to delete and not "cut"
-- Unfortunately <leader>d won't work because it conflicts with the LSP <leader>ds for searching doc symbols
vim.keymap.set('n', '<leader>dd', '"_d', { desc = '[D]elete without yanking' })
vim.keymap.set('v', '<leader>dd', '"_d', { desc = '[D]elete without yanking' })

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

-- Neovim built-in treesitter support!
-- vim.keymap.set('n', '<leader>it', '<cmd>InspectTree<cr>', { desc = '[I]nspect Treesitter [T]ree' })
-- vim.keymap.set('n', '<leader>eq', '<cmd>EditQuery<cr>', { desc = '[E]dit Treesitter [Q]uery' })

-- Source VIMRC
vim.keymap.set('n', '<leader>sv', '<cmd>source $MYVIMRC<cr>', { desc = '[S]ource [V]imrc' })

-- Close all buffers except the current one
vim.keymap.set('n', '<leader>cb', '<cmd>%bd|e#|bd#<cr>', { desc = '[C]lose all [B]uffers (except current)' })

vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all' })
vim.keymap.set('n', '<leader>wq', '<cmd>wqa<cr>', { desc = '[W]rite and [Q]uit all' })
