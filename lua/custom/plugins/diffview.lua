return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'lewis6991/gitsigns.nvim' },
  vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewOpen<cr>', { desc = '[D]iff [V]iew' }),
  opts = {
    hooks = {
      diff_buf_read = function()
        -- vim.opt.foldenable = false
        vim.opt.foldmethod = 'manual'
        vim.opt.foldlevel = 99
      end,
    },
  },
}
