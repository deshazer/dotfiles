return {
  'ggandor/leap.nvim',
  config = function()
    require 'leap'

    vim.keymap.set('n', 's', '<Plug>(leap)', { desc = 'Leap bidirectionally' })
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)', { desc = 'Leap from window' })
    vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)', { desc = 'Leap backward' })
  end,
}
