return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula',
        disabled_filetypes = {
          statusline = { 'neo-tree', 'snacks_dashboard' },
          tabline = { 'neo-tree', 'snacks_dashboard' },
        },
      },
    })
  end
}

