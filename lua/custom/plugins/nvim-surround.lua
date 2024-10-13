return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      -- Can't use the traditional "s" keymaps because they conflict with leap.nvim
      -- Mnemonic here is [G]o [A]round
      -- To change the surrounding html tag you would "type": "gart" ([G]o [A]round [R]hange [T]ag)
      -- To change from double-quote to backtick type: gar"` or garq` ([G]o [A]round [R]hange [Q]uote to `)
      --
      -- NOTE: You need to type "gar" or "gad" quickly to trigger the keymap!
      -- (then you can pause to find right element to change without breaking the command)
      --
      -- aliases = {
      --    ["a"] = ">",
      --    ["b"] = ")",
      --    ["B"] = "}",
      --    ["r"] = "]",
      --    ["q"] = { '"', "'", "`" },
      --    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      -- }
      keymaps = {
        insert = '<C-g>a',
        insert_line = '<C-g>A',
        normal = 'ga',
        normal_cur = 'gaa',
        normal_line = 'gA',
        normal_cur_line = 'gAA',
        visual = 'ga',
        visual_line = 'gA',
        delete = 'gad',
        change = 'gar',
      },
    }
  end,
}
