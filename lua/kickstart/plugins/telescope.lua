--
-- ------------------------- Telescope ------------------------- ||

-- NOTA: Los plugins pueden especificar dependencias.

-- Las dependencias también son especificaciones propias de los plugins:
-- cualquier acción que realices para un plugin en el nivel superior también se puede realizar para una dependencia.

-- Utiliza la key `dependencies` para especificar las dependencias de un plugin en particular.

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- Si encuentra errores, consulte el archivo README de telescope-fzf-native para obtener instrucciones de instalación
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` se usa para ejecutar algún comando cuando se instala/actualiza el complemento.
        -- Esto solo se ejecuta en ese momento, no cada vez que se inicia Neovim.
        build = 'make',

        -- `cond` es una condición utilizada para determinar si este complemento debe instalarse y cargarse.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Útil para obtener íconos bonitos, pero requiere una fuente Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope es un buscador difuso que incluye muchas funciones diferentes
      -- que permiten realizar búsquedas difusas.
      -- Es más que un simple "buscador de archivos",
      -- puede buscar en muchos aspectos de Neovim, tu espacio de trabajo, LSP y mucho más.

      -- La forma más sencilla de usar Telescope es empezar haciendo algo como:
      -- :Telescope help_tags
      -- Tras ejecutar este comando,
      -- se abrirá una ventana donde podrás escribir en el indicador de comandos.
      -- Verás una lista de opciones de `help_tags` y una vista previa de la ayuda.

      -- Dos mapas de teclas importantes para usar en Telescope son:
      -- Modo de inserción: <c-/>
      -- Modo normal: ?

      -- Esto abre una ventana que muestra todos los mapas de teclas del selector actual de Telescope.
      -- Esto es muy útil para descubrir qué puede hacer Telescope y cómo hacerlo.

      -- Configurando Telescope
      require('telescope').setup {
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Habilitar las extensiones de Telescope si están instaladas
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Consultar `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Buscar ayuda' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Buscar keymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar archivos' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Seleccionar Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Buscar palabra archivo actual' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Busqueda por Grep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Buscar diagnostico' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Buscar resumen' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Buscar archivos recientes ("." para repetir)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Encontrar buffers existentes' })

      -- Ejemplo ligeramente avanzado de anulación del comportamiento y tema predeterminados
      vim.keymap.set('n', '<leader>/', function()
        -- Puede pasar configuración adicional a Telescope para cambiar el tema, el diseño, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Búsqueda difusa en el búfer actual' })

      -- También es posible pasar opciones de configuración adicionales.
      --  Consultar `:help telescope.builtin.live_grep()` para obtener información sobre claves específicas
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep en archivos abiertos',
        }
      end, { desc = 'Buscar en archivos abiertos' })

      -- Acceso directo para buscar sus archivos de configuración de Neovim
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Buscar archivos Neovim' })
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
