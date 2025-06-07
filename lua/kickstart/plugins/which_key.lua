--
-- ------------------------- Which Key ------------------------- ||

-- which carga `which-key`
-- antes de que se carguen todos los elementos de la interfaz de usuario.
-- Los eventos pueden ser eventos de autocomandos normales (`:help autocmd-events`).

-- Luego, como usamos la clave `opts` (recomendada), la configuración se ejecuta
-- después de cargar el complemento como `require(MODULE).setup(opts)`.

return {
  {
    -- Complemento útil para mostrarle las combinaciones de teclas pendientes.
    'folke/which-key.nvim',
    -- Establece el evento de carga en 'VimEnter'
    event = 'VimEnter',
    opts = {
      -- retraso entre presionar una tecla y abrir which-key (milisegundos)
      -- esta configuración es independiente de vim.o.timeoutlen
      delay = 0,
      icons = {
        -- Establezca las asignaciones de íconos en verdadero si tiene una fuente Nerd
        mappings = vim.g.have_nerd_font,
        -- Si usa una fuente Nerd: configure icons.keys
        -- en una tabla vacía que usará los iconos de la fuente Nerd definidos por el valor predeterminado which-key.nvim;
        -- de lo contrario, defina una tabla de strings.
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Documentar las key existentes
      spec = {
        { '<leader>f', group = ' Buscar' },
        { '<leader>b', group = ' Buffers' },
        { '<leader>m', group = ' Mapa' },
        { '<leader>l', group = ' LSP' },
        { '<leader>t', group = ' Toggle' },
        { '<leader>g', group = ' Git' },
      },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
