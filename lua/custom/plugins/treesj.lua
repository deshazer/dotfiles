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
    local php = require 'treesj.langs.php'

    local rec_ignore = { 'arguments', 'formal_parameters' }

    -- Teach treejs how to wrap change arrow functions to function () { return } and back
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
                if tsj:type() ~= 'statement_block' then
                  tsj:wrap { left = '{', right = '}' }

                  local ph = tsj:child 'parenthesized_expression'
                  local not_seq = ph and not ph:child 'sequence_expression'

                  if not_seq then
                    if ph:will_be_formatted() then
                      ph:remove_child { '(', ')' }
                    else
                      local text = ph:text():gsub('^%(', ''):gsub('%)$', '')
                      ph:update_text(text)
                    end
                  end

                  local body = tsj:child(2)
                  if body:will_be_formatted() then
                    local set_return
                    if body:has_preset 'split' then
                      set_return = body:child(1)
                    else
                      set_return = body:child(1):child(1)
                    end
                    set_return:update_text('return ' .. set_return:text() .. ';')
                  else
                    body:update_text('return ' .. body:text() .. ';')
                  end
                  local parent = tsj:parent()
                  local parent_type = tsj:tsnode():parent():type()
                  if parent_type == 'arrow_function' then
                    print(vim.inspect(parent))
                  end
                end
              end,
            },
            join = {
              space_in_brackets = false,
              force_insert = '',
              format_tree = arrow_body_format_join,
            },
          },
          arrow_function = { target_nodes = { 'body' } },
        }),
      },
    }
  end,
}
