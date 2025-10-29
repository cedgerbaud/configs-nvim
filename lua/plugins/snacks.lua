local function mergeTables(...)
    local result = {}  -- Start with an empty table
    for _, t in ipairs({...}) do  -- Loop over all input tables
        for key, value in pairs(t) do  -- Copy each key-value pair
            result[key] = value
        end
    end
    return result
end

local picker_keys = require("plugins.snacks.picker").keys
local snack_keys = {
  --- Git
  { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  --- Lazygit
  { "<leader>lg", function() Snacks.lazygit.open() end, desc = "Open lazygit" },
  --- Notifier
  { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  --- Terminal
  { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
  -- Other
  { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
  { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    local dashboard = require("plugins.snacks.dashboard")
    local notifier = require("plugins.snacks.notifier")
    local words = require("plugins.snacks.words")
    local picker = require("plugins.snacks.picker")

    return {
      dashboard = dashboard.opts,
      lazygit = { enabled = true },
      notifier = notifier.opts,
      picker = picker.opts,
      words = words.opts,
    }
  end,
  keys = mergeTables(picker_keys, snack_keys),
  init = function ()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}

