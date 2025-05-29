--
-- ------------------------- Blink CMP ------------------------- ||

return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Motor de fragmentos
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- El paso de compilación es necesario para la compatibilidad con expresiones regulares en fragmentos.
          -- Este paso no es compatible con muchos entornos de Windows.
          -- Elimine la siguiente condición para volver a habilitarlo en Windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contiene una variedad de fragmentos prediseñados.
          -- Consulte el archivo README para obtener información sobre fragmentos language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'predeterminado' (recomendado) para asignaciones similares a las compleciones integradas
        -- <c-y> para aceptar ([y]es) la finalizacion.
        -- Esto se importará automáticamente si su LSP lo admite.
        -- Esto expandirá los fragmentos si el LSP envió uno.
        --   'super-tab' para aceptar la tabulación.
        --   'enter' para aceptar la entrada.
        --   'none' para no asignar.

        -- Para comprender por qué se recomienda el ajuste predeterminado,
        -- deberá leer `:help ins-completion`.

        -- No, en serio. Por favor, lee `:help ins-completion`, ¡es realmente bueno!

        -- Todos los ajustes preestablecidos tienen las siguientes asignaciones:
        --   <tab>/<s-tab>: mover a la derecha/izquierda de la expansión del fragmento
        --   <c-space>: abrir el menú o abrir documentos si ya están abiertos
        --   <c-n>/<c-p> o <up>/<down>: seleccionar el elemento siguiente/anterior
        --   <c-e>: ocultar el menú
        --   <c-k>: activar o desactivar la ayuda de firma

        -- Consulte :h blink-cmp-config-keymap para definir tu propio mapa de teclas
        preset = 'default',

        -- Para mapas de teclas de Luasnip más avanzados (por ejemplo, selección de nodos de elección, expansión),
        -- consulte:  https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) para 'Nerd Font Mono' o 'normal' para 'Nerd Font'
        -- Ajusta el espaciado para garantizar que los íconos estén alineados
        nerd_font_variant = 'mono',
      },

      completion = {
        -- De forma predeterminada, puede presionar `<c-space>` para mostrar la documentación.
        -- Opcionalmente, configure `auto_show = true` para mostrar la documentación después de un retraso.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },
      -- Blink.cmp incluye un comparador difuso de Rust opcional y recomendado,
      -- que descarga automáticamente un binario precompilado cuando está habilitado.
      --
      -- De forma predeterminada, usamos la implementación de Lua,
      -- pero puedes habilitar la implementación de Rust mediante `'prefer_rust_with_warning'`

      -- Consulta :h blink-cmp-config-fuzzy para mas informacion
      fuzzy = { implementation = 'lua' },

      -- Muestra una ventana de ayuda de firma mientras escribe argumentos para una función
      signature = { enabled = true },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
