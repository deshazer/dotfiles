return {
  'FooSoft/vim-argwrap',
  config = function()
    vim.keymap.set('n', 'gw', '<Plug>(ArgWrapToggle)', { desc = '[G]o (Arg) [W]rap' })
  end,
}
