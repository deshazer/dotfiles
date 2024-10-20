-- Powerful wrapping and joining of treesitter nodes
-- Think:
--   - splitting and joining arg lists/arrays/objects
--   - changeing arrow functions to function () { return } statements and back
--   - making other code changes necessary when splitting/joining lines
return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    vim.keymap.set('n', 'gw', require('treesj').toggle, { desc = '[G]o [W]rap' })

    local lang_utils = require 'treesj.langs.utils'
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local ts = vim.treesitter
    -- local treesj = require 'treesj.treesj'
    local php = require 'treesj.langs.php'

    local rec_ignore = { 'arguments', 'formal_parameters' }

    -- Teach treeSJ how to wrap change arrow functions to function () { return } and back
    local arrow_body_format_join = function(tsj)
      local parent = tsj:tsnode():parent():type()
      if parent == 'arrow_function' and tsj:tsnode():named_child_count() == 1 then
        tsj:remove_child { '{', '}' }
        tsj:update_preset({ force_insert = '', space_in_brackets = false }, 'join')
        local stmt = tsj:child 'return_statement' or tsj:child 'expression_statement'

        if stmt then
          if stmt:has_to_format() then
            stmt:remove_child { 'return', ';' }
            local obj = stmt:child 'object'
            if obj then
              tsj:wrap({ left = '(', right = ')' }, 'inline')
            end
          else
            local text = stmt:text():gsub('^return ', ''):gsub(';$', '')
            stmt:update_text(text)
          end
        end
      end
    end

    require('treesj').setup {
      use_default_keymaps = false,
      max_join_length = 10000,
      langs = {
        php = lang_utils.merge_preset(php, {
          statement_block = lang_utils.set_preset_for_statement {
            split = {
              recursive_ignore = rec_ignore,
            },
            join = {
              no_insert_if = {
                'function_declaration',
                'try_statement',
                'if_statement',
              },
              format_tree = arrow_body_format_join,
            },
          },
          body = lang_utils.set_preset_for_statement {
            split = {
              recursive_ignore = rec_ignore,
              format_tree = function(tsj)
                -- I choose not to use the TreeSJ objects because I can't get them to work!!
                if tsj:type() ~= 'statement_block' then
                  local node = ts_utils.get_node_at_cursor()
                  if node == nil then
                    error 'No Treesitter parser found.'
                  end

                  while node ~= nil and node:type() ~= 'arrow_function' do
                    node = node:parent()
                  end

                  if node == nil then
                    error 'No arrow function found.'
                  end

                  local bufnr = vim.api.nvim_get_current_buf()

                  -- This is what we're working with
                  print(node:type())
                  print(ts.get_node_text(node, bufnr))

                  local start_row, start_col, end_row, end_col = node:range()
                  print(start_row, start_col, end_row, end_col)

                  local params_node = node:field('parameters')[1]
                  local return_type_node = node:field('return_type')[1]
                  local body_node = node:field('body')[1]

                  print(params_node)
                  print(return_type_node)
                  print(body_node)

                  local params_text = params_node and ts.get_node_text(params_node, bufnr) or ''
                  local return_type_text = return_type_node and ts.get_node_text(return_type_node, bufnr) or ''
                  local body_text = body_node and ts.get_node_text(body_node, bufnr) or ''

                  print(params_text)
                  print(return_type_text)
                  print(body_text)

                  local replacement = {
                    'function ' .. params_text .. (return_type_node and (': ' .. return_type_text) or '') .. ' {',
                    'return ' .. body_text .. ';',
                    '}',
                  }

                  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, replacement)

                  require('conform').format {
                    bufnr = bufnr,
                    range = {
                      ['start'] = { start_row, start_col },
                      ['end'] = { start_row + #replacement, #replacement[#replacement] },
                    },
                    async = false,
                    lsp_format = 'fallback',
                  }

                  -- tsj:wrap { left = '{', right = '}' }
                  --
                  -- local ph = tsj:child 'parenthesized_expression'
                  -- local not_seq = ph and not ph:child 'sequence_expression'
                  --
                  -- if not_seq then
                  --   if ph:will_be_formatted() then
                  --     ph:remove_child { '(', ')' }
                  --   else
                  --     local text = ph:text():gsub('^%(', ''):gsub('%)$', '')
                  --     ph:update_text(text)
                  --   end
                  -- end
                  --
                  -- local body = tsj:child(2)
                  -- if body:will_be_formatted() then
                  --   local set_return
                  --   if body:has_preset 'split' then
                  --     set_return = body:child(1)
                  --   else
                  --     set_return = body:child(1):child(1)
                  --   end
                  --   set_return:update_text('return ' .. set_return:text() .. ';')
                  -- else
                  --   body:update_text('return ' .. body:text() .. ';')
                  -- end
                  -- local parent = tsj:tsnode():parent()
                  -- print(vim.inspect(tsj))
                  -- local parent_type = parent:type()
                  -- if parent_type == 'arrow_function' then
                  --   local parent_tsj = require('treesj.treesj').new { tsnode = parent, lang = 'php', from_self = false }
                  --   local new_text = parent_tsj:text():gsub('fn', 'function', 1):gsub('=>', '', 1)
                  --
                  --   -- parent_tsj:update_text(parent_tsj:text():gsub('fn', 'function', 1):gsub('=>', '', 1))
                  --   -- print(parent_tsj:text())
                  --   -- print(new_text)
                  --   parent_tsj:update_text(new_text)
                  --   print(vim.inspect(parent_tsj))
                  -- end
                end
              end,
            },
            join = {
              space_in_brackets = false,
              force_insert = '',
              format_tree = arrow_body_format_join,
            },
          },
          arrow_function = { target_nodes = { 'arrow_function', 'body' } },
        }),
      },
    }
  end,
}
