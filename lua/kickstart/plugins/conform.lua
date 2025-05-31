--
-- -------------------------- Conform -------------------------- ||

return {
  {
    -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>u',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Formatear buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Desactive "format_on_save lsp_fallback"
        -- para los idiomas que no tengan un estilo de codificación bien estandarizado.
        -- Puede agregar idiomas adicionales aquí o volver a activarlo para los que estén deshabilitados.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform también puede ejecutar varios formateadores secuencialmente
        -- python = { "isort", "black" },

        -- Puede usar 'stop_after_first' para ejecutar el primer formateador disponible de la lista
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
