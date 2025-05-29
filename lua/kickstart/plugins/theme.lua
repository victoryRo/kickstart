--
-- -------------------------- Themes --------------------------- ||

return {

  -- tokyonight
  {
    -- Puedes cambiar fácilmente a un esquema de colores diferente.
    -- Cambia el nombre del complemento de esquema de colores a continuación y luego
    -- cambia el comando en la configuración al nombre de ese esquema de colores.
    --
    -- Si quieres ver qué esquemas de colores ya están instalados, puedes usar `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Asegúrese de cargar esto antes de todos los demás complementos de inicio.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Desactivar cursiva en los comentarios
        },
      }

      -- Carga el esquema de colores aquí.
      -- Como muchos otros temas,
      -- este tiene diferentes estilos y puedes cargar cualquier otro,
      -- como 'tokyonight-storm', 'tokyonight-moon' o 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- nordic theme
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'nordic'
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
}

--
--
-- ------------------------------------------------------------- ||
--
