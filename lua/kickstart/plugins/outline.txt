--
-- --------------------- Simbolos en linea ---------------------- ||
return {
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>y', '<cmd>Outline<CR>', desc = 'Linea de simbolos' },
    },
    opts = {
      -- Your setup opts here
      symbols = {
        filter = { 'String', 'Variable', 'Constant', exclude = true },
      },
      outline_window = {
        width = 20,
      },
    },
  },
}
--
--
-- ------------------------------------------------------------- ||
--
