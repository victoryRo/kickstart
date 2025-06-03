return {

  -- indentar y resaltar codigo (lineas)
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {

        chunk = {
          enable = true,
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '┌',
            left_bottom = '└',
            right_arrow = '─',
          },
          style = '#00ffff',
        },

        indent = {
          enable = true,
          chars = {
            '│',
          },
          style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID 'Whitespace'), 'fg', 'gui'),
          },
        },

        line_num = {
          enable = true,
          style = '#99e6ff',
        },
      }
    end,
  },
}
