return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local options = {
      lazygit = { enabled = true },
      terminal = { enabled = true },
    }
    require("snacks").setup({
      opts = options,
    })
  end,
}

