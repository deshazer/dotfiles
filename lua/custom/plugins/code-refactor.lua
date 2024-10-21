return {
  {
    dir = '/home/steven/code/personal/code-refactor.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>cr', ':CodeActions all<cr>', desc = '[C]ode [R]efactor' },
    },
    config = function()
      require('code-refactor').setup {
        format = function(opt)
          -- opt.range has the form { ['start'] = { row, col }, ['end'] = { row, col }}
          require('conform').format {
            bufnr = vim.api.nvim_get_current_buf(),
            range = opt.range,
            async = false,
            timeout_ms = 1000,
            lsp_format = 'fallback',
          }
        end,
      }
    end,
  },
}
