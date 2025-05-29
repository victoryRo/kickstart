--
-- ------------------------- Signature ------------------------- ||

return {

  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      handler_opts = {
        -- double, rounded, single, shadow, none
        border = 'double',
      },
    },
  },
}

--
--
-- ------------------------------------------------------------- ||
--
