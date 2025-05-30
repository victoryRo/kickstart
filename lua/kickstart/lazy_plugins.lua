--
-- --------------- CONFIGURAR E INSTALAR PLUGINS --------------- ||

require('lazy').setup({

  -- Detecta automáticamente la tabulación y el ancho de desplazamiento
  'NMAC427/guess-indent.nvim',

  -- Importamos la configuracion de cada complemento "plugin"

  require 'kickstart.plugins.theme',

  require 'kickstart.plugins.treesitter',

  require 'kickstart.plugins.neo_tree',

  require 'kickstart.plugins.git_signs',

  require 'kickstart.plugins.which_key',

  require 'kickstart.plugins.telescope',

  require 'kickstart.plugins.lsp_config',

  require 'kickstart.plugins.conform',

  require 'kickstart.plugins.blink_cmp',

  require 'kickstart.plugins.todo_comments',

  require 'kickstart.plugins.mini',

  require 'kickstart.plugins.indent_line',

  require 'kickstart.plugins.lint',

  require 'kickstart.plugins.autopairs_rainbow',

  require 'kickstart.plugins.minimap',

  require 'kickstart.plugins.golang',

  require 'kickstart.plugins.signature',

  require 'kickstart.plugins.preview',

  require 'kickstart.plugins.codeium',

  require 'kickstart.plugins.term',

  require 'kickstart.plugins.outline',

  require 'kickstart.plugins.buffer',
}, {
  ui = {

    -- Si usa una fuente Nerd:
    -- configure los iconos en una tabla vacía que usará los iconos de la fuente Nerd
    -- definidos por lazy.nvim por defecto. De lo contrario, defina una tabla de iconos Unicode.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

--
--
-- ------------------------------------------------------------- ||
--
