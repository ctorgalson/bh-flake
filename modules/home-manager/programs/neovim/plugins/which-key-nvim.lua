-- @see https://github.com/folke/which-key.nvim
local wk = require("which-key")
local builtin = require('telescope.builtin')
wk.add({
  { "<leader>f", group = "Find" },
  -- { "<leader>ff", builtin.find_files, "Search for files", mode = "n" },
  -- { "<leader>fg", builtin.live_grep, "Search in files", mode = "n" },
  -- { "<leader>fb", builtin.buffers, "Search in open buffers", mode = "n" },
  -- { "<leader>fh", builtin.help_tags, "Search Neovim help", mode = "n" },
  -- { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files", mode = "n" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers", mode = "n" },
  { "<leader>fi", "<cmd>Telescope live_grep<cr>", desc = "Find in files", mode = "n" },
  { "<leader>fh", "<cmd>Telescope help_ags<cr>", desc = "Find in Neovim help", mode = "n" },
  -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },
  -- { "<leader>fn", desc = "New File" },
  -- { "<leader>f1", hidden = true }, -- hide this keymap
  -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  -- { "<leader>b", group = "buffers", expand = function()
  --     return require("which-key.extras").expand.buf()
  --   end
  -- },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})
