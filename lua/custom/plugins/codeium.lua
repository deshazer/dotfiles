return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('i', '<C-k>', function()
      return vim.fn['codeium#AcceptNextWord']()
    end, { silent = true, expr = true })

    vim.keymap.set('i', '<C-j>', function()
      return vim.fn['codeium#AcceptNextLine']() .. '<CR>'
    end, { silent = true, expr = true })

    vim.keymap.set('i', '<C-d>', function()
      return vim.fn['codeium#Clear']()
    end, { silent = true, expr = true })

    vim.keymap.set('i', '<C-l>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true })

    vim.keymap.set('i', '<C-h>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true })
  end,
}
