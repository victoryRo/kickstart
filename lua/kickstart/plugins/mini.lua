--
-- ---------------------------- MINI --------------------------- ||

return {
  -- Colección de varios pequeños complementos/módulos independientes
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Mejor alrededor/dentro de objetos de texto
      --
      -- Ejemplos:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Agregar/eliminar/reemplazar entornos (corchetes, comillas, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Línea de estado simple y fácil de usar.
      -- Puedes eliminar esta llamada de configuración si no te gusta.
      -- y probar otro complemento de línea de estado.
      local statusline = require 'mini.statusline'
      -- Establezca use_icons en verdadero si tiene una fuente Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Puede configurar secciones en la línea de estado anulando su comportamiento predeterminado.
      -- Por ejemplo, aquí configuramos la sección para la ubicación del cursor en LÍNE:COLUMN.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... ¡y aún hay más!
      -- Visita: https://github.com/echasnovski/mini.nvim
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
