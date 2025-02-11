-- @see https://medium.com/@shaikzahid0713/terminal-support-in-neovim-c616923e0431
require("toggleterm").setup({
  close_on_exit = false,
  direction = 'horizontal',
  -- @see options.lua for other keymapping.
  open_mapping = [[<c-\>]],
  persist_mode = true,
  shade_terminals = true,
  size = 20,
  start_in_insert = true,
  terminal_mappings = true,
})
