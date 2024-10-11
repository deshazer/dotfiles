return {
  'declancm/cinnamon.nvim',
  version = '*', -- use latest release
  config = function()
    require('cinnamon').setup({
    keymaps = {
      basic = true
      extra = true,
    },
    options = { mode = "window"}
    })
  end
  },
}
