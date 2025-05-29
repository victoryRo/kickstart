--
-- ------------------------ TreeSitter ------------------------- ||

return {
  -- Resaltar, editar y navegar el código
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Establece el módulo principal que se utilizará para opts
    -- Configurar Treesitter Consultar `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
      },
      --Instalar automáticamente los idiomas que no están instalados
      auto_install = true,
      highlight = {
        enable = true,
        -- Algunos lenguajes dependen del sistema de resaltado de expresiones regulares de Vim
        -- (como Ruby) para las reglas de sangría.
        -- Si experimenta problemas de sangría inusuales,
        -- agregue el lenguaje a la lista de lenguajes con resaltado
        -- de expresiones regulares de Vim adicionales y deshabilitados para sangría.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },

    -- Hay módulos adicionales de nvim-treesitter que puedes usar para interactuar con nvim-treesitter.
    -- Deberías explorar algunos y ver qué te interesa:
    --
    --    - Selección incremental: Incluida, consultar `:help nvim-treesitter-incremental-selection-mod`
    --    - Muestra tu contexto actual: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}

--
--
-- ------------------------------------------------------------- ||
--
