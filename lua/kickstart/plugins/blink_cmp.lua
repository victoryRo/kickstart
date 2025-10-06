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
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- Todos los ajustes preestablecidos tienen las siguientes asignaciones:
        --   <tab>/<s-tab>: mover a la derecha/izquierda de la expansión del fragmento
        --   <c-space>: abrir el menú o abrir documentos si ya están abiertos
        --   <c-n>/<c-p> o <up>/<down>: seleccionar el elemento siguiente/anterior
        --   <c-e>: ocultar el menú
        --   <c-k>: activar o desactivar la ayuda de firma

        -- Consulte :h blink-cmp-config-keymap para definir tu propio mapa de teclas
        preset = 'default',

        -- ['<C-e>'] = { 'hide' },
        -- ['<C-j>'] = { 'select_and_accept' },
        -- ['<Tab>'] = { 'select_next', 'fallback' },
        -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
        -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

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
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = 'single',
          },
        },

        menu = {
          border = 'single',

          draw = {
            -- No necesitamos label_description ahora porque label y label_description
            -- ya están combinados en label por colorful-menu.nvim.
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require('colorful-menu').blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- O quieres agregar más elementos a la etiqueta
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require('colorful-menu').blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                  end
                  -- Hacer otra cosa
                  return highlights
                end,
              },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'lazydev', 'snippets', 'buffer' },
        -- default = { 'lsp', 'path', 'lazydev', 'buffer' },

        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },

          -- Recetas
          -- Mantener la primera letra en mayúscula en la fuente del búfer
          buffer = {
            -- mantener mayúsculas y minúsculas del primer carácter
            transform_items = function(a, items)
              local keyword = a.get_keyword()
              local correct, case
              if keyword:match '^%l' then
                correct = '^%u%l+$'
                case = string.lower
              elseif keyword:match '^%u' then
                correct = '^%l+$'
                case = string.upper
              else
                return items
              end

              -- evitar duplicados de las correcciones
              local seen = {}
              local out = {}
              for _, item in ipairs(items) do
                local raw = item.insertText
                if raw:match(correct) then
                  local text = case(raw:sub(1, 1)) .. raw:sub(2)
                  item.insertText = text
                  item.label = text
                end
                if not seen[item.insertText] then
                  seen[item.insertText] = true
                  table.insert(out, item)
                end
              end
              return out
            end,
          },
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
      signature = { enabled = false },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
