--
-- -------------------------- Themes --------------------------- ||

return {

  -- nordic theme
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'nordic'
    end,
  },

  -- gruvbox theme
  {
    'luisiacc/gruvbox-baby',
    lazy = false,
    priority = 1000,
    config = function()
      -- Enable transparent mode
      -- vim.g.gruvbox_baby_transparent_mode = 1
      -- Enable telescope theme
      vim.g.gruvbox_baby_telescope_theme = 1
      -- vim.g.gruvbox_baby_background_color = 'dark'
      -- vim.g.gruvbox_baby_use_original_palette = 1
      -- vim.cmd.colorscheme 'gruvbox-baby'
    end,
  },

  -- one nord theme
  {
    'rmehri01/onenord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onenord'
    end,
  },

  -- one dark theme
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- one monokai
  {
    'cpea2506/one_monokai.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'one_monokai'
    end,
  },

  -- vesper
  {
    'datsfilipe/vesper.nvim',
    priority = 1000,
    config = function()
      require('vesper').setup {
        transparent = false,
        italics = {
          comments = true,
          keywords = true,
          functions = false,
          strings = false,
          variables = true,
        },
        overrides = {},
        palette_overrides = {},
      }
      -- vim.cmd.colorscheme 'vesper'
    end,
  },

  -- miasma
  {
    'xero/miasma.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'miasma'
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
