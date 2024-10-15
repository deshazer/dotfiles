return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = '[O]il' })
    end,
  },
  -- oil will break the "open file" behavior of the 'gx' keymap
  -- So, this plugin will fix it
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true, -- default settings
    submodules = false, -- submodules are only needed to run tests
  },
}
