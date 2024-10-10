return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('n', '<Esc>', function()
      return vim.fn['codeium#Clear']()
    end, { silent = true, expr = true })
  end,
}
