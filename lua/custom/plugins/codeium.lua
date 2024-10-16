return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
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
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        return vim.fn['codeium#CycleCompletions'](1)
      end
    end, { expr = true })

    vim.keymap.set('i', '<C-h>', function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        return vim.fn['codeium#CycleCompletions'](-1)
      end
    end, { expr = true })
  end,
}
