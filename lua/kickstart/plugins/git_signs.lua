--
-- Aquí hay un ejemplo más avanzado donde pasamos opciones de configuración a `gitsigns.nvim`.
return {

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },

      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Saltar al siguiente git [c]ambio' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Saltar al git anterior [c]ambio' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })

        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>gs', gitsigns.stage_buffer, { desc = 'Deshacer buffer' })
        map('n', '<leader>gu', gitsigns.stage_hunk, { desc = 'Deshacer el hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Restablecer hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Restablecer buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Previo hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'Registro de commit' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diferencia buffer actual' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Diferencias con el ultimo commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Mostrar linea de registro' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'Mostrar cambios eliminados' })
      end,
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
