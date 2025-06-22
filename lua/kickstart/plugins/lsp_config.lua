--
-- ------------------------- LSP Config ------------------------ ||

-- LSP Plugins
return {
  {
    -- `lazydev` configura Lua LSP para la configuración,
    -- el entorno de ejecución y los complementos de Neovim.
    -- Se utiliza para autocompletar,
    -- realizar anotaciones y firmar las API de Neovim.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Cargar tipos de luvit cuando se encuentra la palabra `vim.uv`
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {

      -- Instalar automáticamente LSP y herramientas relacionadas en la ruta estándar de Neovim
      -- Mason debe cargarse antes que sus dependientes, por lo que debemos configurarlo aquí.
      -- NOTE: `opts = {}` es lo mismo que llamar a `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Actualizaciones de estado útiles para LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Permite capacidades adicionales proporcionadas por blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Breve aparte: **¿Qué es LSP?**

      -- LSP es una sigla que probablemente hayas oído, pero quizá no entiendas.

      -- LSP significa Protocolo de Servidor de Lenguaje (Language Server Protocol).
      -- Es un protocolo que ayuda a los editores y a las herramientas de lenguaje a comunicarse de forma estandarizada.
      --
      -- En general, existe un "servidor", que es una herramienta diseñada para comprender
      -- un lenguaje específico (como `gopls`, `lua_ls`, `rust_analyzer`, etc.).
      -- Estos Servidores de Lenguaje (a veces llamados servidores LSP, pero es algo así como un cajero automático)
      -- son procesos independientes que se comunican con un "cliente", en este caso, ¡Neovim!

      -- LSP proporciona a Neovim funciones como:

      -- Ir a la definición
      -- Encontrar referencias
      -- Autocompletar
      -- Búsqueda de símbolos
      -- ¡y mucho más!

      -- Por lo tanto, los servidores de lenguaje son herramientas externas que deben instalarse por separado de Neovim.
      -- Aquí es donde entran en juego `mason` y los complementos relacionados.

      -- Si te preguntas sobre lsp vs. treesitter,
      -- puedes consultar la sección de ayuda, con un diseño elegante y maravilloso, `:help lsp-vs-treesitter`.

      -- Esta función se ejecuta cuando un LSP se conecta a un búfer específico.
      -- Es decir, cada vez que se abre un nuevo archivo asociado a un lsp
      -- (por ejemplo, al abrir `main.rs`, que está asociado a `rust_analyzer`),
      -- se ejecuta esta función para configurar el búfer actual.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Recuerda que Lua es un lenguaje de programación real y,
          -- como tal, es posible definir pequeñas funciones auxiliares y de utilidad para evitar repetir lo mismo.

          -- En este caso, creamos una función que nos permite definir mapeos específicos
          -- para elementos relacionados con LSP con mayor facilidad.
          -- Establece el modo, el búfer y la descripción en cada ocasión.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Cambie el nombre de la variable bajo el cursor.
          -- La mayoría de los servidores de idiomas admiten el cambio de nombre entre archivos, etc.
          map('<leader>ln', vim.lsp.buf.rename, 'Renombrar')

          -- Ejecutar una acción de código; normalmente,
          -- el cursor debe estar sobre un error o una sugerencia de su LSP para que esto se active.
          map('<leader>la', vim.lsp.buf.code_action, 'Codido de accion', { 'n', 'x' })

          -- Encuentre referencias para la palabra bajo el cursor.
          map('<leader>lr', require('telescope.builtin').lsp_references, 'Ver Referencias')

          -- Salta a la implementación de la palabra bajo el cursor.
          -- Útil cuando tu lenguaje tiene formas de declarar tipos sin una implementación real.
          map('<leader>li', require('telescope.builtin').lsp_implementations, 'Ir a Implementacion')

          -- Salta a la definición de la palabra bajo el cursor.
          -- Aquí es donde se declaró por primera vez una variable, o donde se definió una función, etc.
          -- Para retroceder, presione <C-t>.
          map('<leader>ld', require('telescope.builtin').lsp_definitions, 'Ir a Definicion')

          -- WARN: Esto no es Goto Definición, es Goto Declaración.
          -- Por ejemplo, en C, esto te llevaría al encabezado.
          map('grD', vim.lsp.buf.declaration, 'Ir a Declaracion')

          -- Búsqueda difusa de todos los símbolos en el documento actual.
          -- Los símbolos son elementos como variables, funciones, tipos, etc.
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Abrir Símbolos')

          -- Búsqueda difusa de todos los símbolos en su espacio de trabajo actual.
          -- Similar a los símbolos de documento, excepto que busca en todo el proyecto.
          map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Símbolos de espacio de trabajo')

          -- Salta al tipo de la palabra bajo el cursor.
          -- Útil cuando no estás seguro de qué tipo es una variable
          -- y quieres ver la definición de su *tipo*, no dónde se *definió*.
          map('<leader>lt', require('telescope.builtin').lsp_type_definitions, 'Ir definicion de tipo')

          -- Esta función resuelve una diferencia entre neovim nightly (versión 0.11) y estable (versión 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer Algunos métodos de soporte LSP solo se encuentran en archivos específicos
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Los dos siguientes autocomandos se utilizan para resaltar
          -- las referencias de la palabra bajo el cursor cuando este permanece allí por un instante.
          -- Consulte `:help CursorHold` para obtener información sobre cuándo se ejecuta esto.
          --
          -- Al mover el cursor, se borrarán los resaltados (el segundo autocomando).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- El siguiente código crea un mapa de teclas
          -- para activar o desactivar las sugerencias de inserción en su código,
          -- si el servidor de lenguaje que utiliza las admite.
          --
          -- Esto puede ser indeseado, ya que desplazan parte de su código.
          -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          --   map('<leader>th', function()
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          --   end, '[T]oggle Inlay [H]ints')
          -- end
        end,
      })

      -- Configuración de diagnóstico
      -- Consultar :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- Los servidores y clientes LSP pueden comunicarse entre sí sobre las funciones compatibles.
      -- De forma predeterminada, Neovim no es compatible con todo lo que incluye la especificación LSP.
      -- Al añadir blink.cmp, luasnip, etc., Neovim ahora ofrece *más* capacidades.
      -- Por lo tanto, creamos nuevas capacidades con blink.cmp y las transmitimos a los servidores.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Habilite los siguientes servidores de idioma
      -- Puede agregar o eliminar cualquier LSP que desee. Se instalarán automáticamente.

      -- Agregue cualquier configuración de anulación adicional en las siguientes tablas. Las claves disponibles son:
      -- cmd (table): Anula el comando predeterminado usado para iniciar el servidor.
      -- filetypes (table): Anula la lista predeterminada de tipos de archivo asociados para el servidor.
      -- capabilities (tabla): Anula los campos en capabilities. Se puede usar para deshabilitar ciertas funciones de LSP.
      -- settings (table): Anula la configuración predeterminada utilizada al inicializar el servidor.
      -- Por ejemplo, para ver las opciones de `lua_ls`, puede visitar: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. Consulte `:help lspconfig-all` para obtener una lista de todos los LSP preconfigurados
        --
        -- Algunos lenguajes (como TypeScript) tienen complementos de lenguaje completos que pueden resultar útiles:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- Pero para muchas configuraciones, el LSP (`ts_ls`) funcionará bien
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Puede alternar a continuación para ignorar las ruidosas advertencias de "campos faltantes" de Lua_LS
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Asegúrate de que los servidores y las herramientas mencionadas estén instalados.
      --
      -- Para comprobar el estado actual de las herramientas instaladas
      -- o instalar manualmente otras herramientas, puedes ejecutar
      -- :Mason.
      --
      -- Puedes pulsar `g?` para obtener ayuda en este menú.
      --
      -- `mason` se tuvo que configurar previamente:
      -- para configurar sus opciones,
      -- consulta la tabla de `dependencias` de `nvim-lspconfig` que aparece más arriba.
      --
      -- Puedes añadir aquí otras herramientas que quieras que Mason instale,
      -- para que estén disponibles desde Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'gopls',
        'css-lsp',
        'html-lsp',
        'yamlls',
        'json-lsp',
        'emmet-ls',
        'lua-language-server',
        'dockerfile-language-server',

        -- -- install formatea codigolua
        'stylua',

        -- -- install debuggers

        -- -- install linters
        'kube-linter',
        'selene',

        -- -- install any other package
        'tree-sitter-cli',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        -- establecido explícitamente en una tabla vacía (Kickstart completa las instalaciones a través de mason-tool-installer)
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- Esto gestiona la anulación únicamente de los valores transmitidos explícitamente
            -- por la configuración del servidor anterior.
            -- Resulta útil al deshabilitar ciertas funciones de un LSP
            -- (por ejemplo, desactivar el formato de ts_ls).
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}

--
--
-- ------------------------------------------------------------- ||
--
