local ok, fs = pcall(require, 'core.utils.file_system')
local project_root = ok and fs.root or function(_) return vim.fn.getcwd() end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
      layout = {
        preset = "sidebar",
        preview = false,
      },
      hidden = true
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right",
              width = 0.25
            }
          }
        }
      },
      hidden = true,
      ignored = true
    }
  },
  keys = {
     {
      "<leader>e",
      function()
        require("snacks").explorer({ cwd = project_root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>E",
      function()
        require("snacks").explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
  },
}
