--
-- -------------------------- Buffer -------------------------- ||
return {

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        options = {
          style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold,
          },
          separator_style = 'slope',
          diagnostics = 'nvim_lsp',
          indicator = {
            style = 'underline',
          },
          numbers = 'ordinal',
        },
      }
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
