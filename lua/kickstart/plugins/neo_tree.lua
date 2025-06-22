--
-- -------------------------- Neo Tree ------------------------- ||

-- Neo-tree es un complemento de Neovim para explorar el sistema de archivos
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- No es estrictamente obligatorio, pero se recomienda
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },

      filtered_items = {
        visible = false, -- true: simplemente se mostrarán de forma diferente a los elementos normales.
        force_visible_in_empty_folder = false, -- true: se mostrarán los archivos ocultos si la carpeta raíz está vacía.
        show_hidden_count = true, -- true: la cantidad de elementos ocultos en cada carpeta se mostrará como la última entrada.
        hide_dotfiles = true, -- true: ocultar los archivos ocultos.
        hide_gitignored = false, -- true: ocultar los archivos ignorados por git.
      },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
