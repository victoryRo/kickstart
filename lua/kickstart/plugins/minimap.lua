--
-- -------------------------- MiniMap -------------------------- ||

return {
  -- minimap
  {
    'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require 'codewindow'
      codewindow.setup {
        exclude_filetypes = { 'help' }, -- Choose certain filetypes to not show minimap on
        minimap_width = 10, -- The width of the text part of the minimap
        width_multiplier = 4, -- How many characters one dot represents
        window_border = 'single', -- The border style of the floating window (accepts all usual options)
        events = { 'TextChanged', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost' }, -- Events that update the code window
      }
      codewindow.apply_default_keybinds()
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
