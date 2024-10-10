return {
  'numToStr/Comment.nvim',
  opts = {},
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }

    local api = require 'Comment.api'

    -- Toggle line (linewise)
    vim.keymap.set('n', '<C-_>', api.toggle.linewise.current, { noremap = true, silent = true })

    -- Toggle selection (linewise)
    vim.keymap.set('x', '<C-_>', function()
      local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.toggle.linewise(vim.fn.visualmode())
    end)
  end,
}
