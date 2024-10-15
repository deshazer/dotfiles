return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
      custom_calculation = function(node, language_tree)
        if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' then
          return '{{-- %s --}}'
        end
      end,
    }
  end,
}
