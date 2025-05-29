--
-- --------------------------- TODO ---------------------------- ||

return {
  -- Resaltar tareas pendientes, notas, etc. en los comentarios
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
