-- Collection of various small independent plugins/modules
--  Check out more mini plugins: https://github.com/echasnovski/mini.nvim
return {
  'echasnovski/mini.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        -- Use balanced pair for brackets. Use opening ones to possibly remove edge
        -- whitespace from `i` textobject.
        -- Defaults can be found here:
        -- https://github.com/echasnovski/mini.ai/blob/9b9b7cfa38b4871c3e44cfe89cf6d53fd40684d9/lua/mini/ai.lua#L1074
        -- NOTE: These are all built-in anyway (just in case you want to tweak them)
        ['('] = { '%b()', '^.%s*().-()%s*.$' },
        [')'] = { '%b()', '^.().*().$' },
        ['['] = { '%b[]', '^.%s*().-()%s*.$' },
        [']'] = { '%b[]', '^.().*().$' },
        ['{'] = { '%b{}', '^.%s*().-()%s*.$' },
        ['}'] = { '%b{}', '^.().*().$' },
        ['<'] = { '%b<>', '^.%s*().-()%s*.$' },
        ['>'] = { '%b<>', '^.().*().$' },
        -- Use special "same balanced" pattern to select quotes in pairs
        ["'"] = { "%b''", '^.().*().$' },
        ['"'] = { '%b""', '^.().*().$' },
        ['`'] = { '%b``', '^.().*().$' },

        -- ['?'] Derived from user prompt (already included by default)

        -- NOTE: These are custom

        -- Disable these and let treesitter handle this
        ['f'] = '', -- Function
        ['a'] = '', -- Argument (function parameter)

        -- Tag (might need to let treesitter handle this too)
        ['t'] = { '<(%w-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },

        -- Quotes
        ['q'] = { { "%b''", '%b""', '%b``' }, '^.().*().$' },

        -- Brackets (b for parentheses and B for curly brackets)
        ['b'] = { '%b()', '^.().*().$' },
        ['B'] = { '%b{}', '^.().*().$' },
        -- Array (square brackets)
        ['r'] = { '%b[]', '^.().*().$' },
      },
    }
  end,
}
