local function my_on_attach(bufnr)
    local treeutils = require("silfa.treeutils")
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    --custom mappings
    vim.keymap.set('n', '<leader>ps', function()
        treeutils.launch_grep_string({ search = vim.fn.input("Grep in dir > ") })
    end, opts('Grep dir'))
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function ()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- empty setup using defaults
      require("nvim-tree").setup{
          on_attach = my_on_attach,
          actions = {
              open_file = {
                  resize_window = false,
              },
          },
          view = {
              width = {},
          },
      }
  end
}