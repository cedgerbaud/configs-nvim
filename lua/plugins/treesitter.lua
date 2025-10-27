return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua", "python", "javascript", "bash", "caddy", "dockerfile", "gitignore", "hcl", "helm", "html", "jinja_inline", "jq", "json", "markdown_inline", "powershell", "python", "ssh_config", "terraform", "yaml"},
      highlight = { enabled = true },
      indent = { enabled = true },
    })
  end
}
