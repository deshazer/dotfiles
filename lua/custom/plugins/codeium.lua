return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('n', '<Esc>', function()
      -- Clear highlights on search when pressing <Esc> in normal mode
      --  See `:help hlsearch`
      vim.cmd 'noh'
      return vim.fn['codeium#Clear']()
    end, { silent = true, expr = true, remap = true })
  end,
}
