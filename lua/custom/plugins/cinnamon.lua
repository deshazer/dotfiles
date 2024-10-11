return {
  'declancm/cinnamon.nvim',
  version = '*', -- use latest release
  config = function()
    local cinnamon = require 'cinnamon'
    cinnamon.setup {
      keymaps = {
        basic = true,
        extra = true,
      },
      options = {
        mode = 'cursor',
        max_delta = {
          time = 100,
        },
      },
    }

    -- Custom keymaps for centering the scrolled-to position on the screen
    vim.keymap.set('n', '<C-U>', function()
      cinnamon.scroll '<C-U>zz'
    end)
    vim.keymap.set('n', '<C-D>', function()
      cinnamon.scroll '<C-D>zz'
    end)
    vim.keymap.set('n', '<C-B>', function()
      cinnamon.scroll '<C-B>zz'
    end)
    vim.keymap.set('n', '<C-F>', function()
      cinnamon.scroll '<C-F>zz'
    end)
    vim.keymap.set('n', 'n', function()
      cinnamon.scroll 'nzzzn'
    end)
    vim.keymap.set('n', 'N', function()
      cinnamon.scroll 'Nzzzn'
    end)
  end,
}
