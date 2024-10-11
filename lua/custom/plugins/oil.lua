return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
    }
    vim.keymap.set('n', '<leader>-', '<cmd>Oil<cr>', { desc = '[O]il' })
  end,
}
