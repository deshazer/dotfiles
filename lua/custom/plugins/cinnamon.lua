return {
  'declancm/cinnamon.nvim',
  version = '*', -- use latest release
  config = function()
    local cinnamon = require 'cinnamon'
    cinnamon.setup {
      keymaps = {
        basic = false,
        extra = false,
      },
      options = {
        mode = 'window',
        max_delta = {
          time = 100,
        },
      },
    }
    -- Keep cursor centered while smooth scrolling
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

    -- Just to next/previous method (I don't like cinnamon for this)
    vim.keymap.set('n', 'M', '[mzz', { desc = 'Just to previous [M]ethod' })
    vim.keymap.set('n', 'm', ']mzz', { desc = 'Just to next [M]ethod' })

    -- Center search result on screen
    vim.keymap.set('n', 'n', function()
      cinnamon.scroll 'nzzzn'
    end)
    vim.keymap.set('n', 'N', function()
      cinnamon.scroll 'Nzzzn'
    end)

    -- Get those centering keymaps to scroll smoothly
    vim.keymap.set('n', 'zz', function()
      cinnamon.scroll 'zz'
    end)
    vim.keymap.set('n', 'zt', function()
      cinnamon.scroll 'zt'
    end)
    vim.keymap.set('n', 'zb', function()
      cinnamon.scroll 'zb'
    end)

    --
  end,
}
