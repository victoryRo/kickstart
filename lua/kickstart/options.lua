--
-- -------------------------- OPTIONS -------------------------- ||
-- Ver `:help vim.o`

-- NOTE: ¡Puedes cambiar estas opciones como desees!
-- Para más opciones, consulta `:help option-list`

-- Permitir linea de numeros
vim.o.number = true

--  Permitir numeros relativos en la linea
vim.o.relativenumber = true

-- Habilite el modo mouse
-- útil para cambiar el tamaño de las divisiones
vim.o.mouse = 'a'

-- No mostrar el modo, ya que está en la línea de estado
vim.o.showmode = false

-- Sincronizar el portapapeles entre el Sistema Operativo y Neovim.
-- Programar la configuración después de `UiEnter`, ya que puede aumentar el tiempo de inicio.
-- Eliminar esta opción si se desea que el portapapeles del SO permanezca independiente.
-- Consultar `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Habilitar salto de sangría
vim.o.breakindent = true

-- Guardar historial de deshacer
vim.o.undofile = true

-- Búsqueda sin distinción entre mayúsculas y minúsculas,
-- A MENOS QUE \C o una o más letras mayúsculas estén en el término de búsqueda
vim.o.ignorecase = true
vim.o.smartcase = true

-- Mantener la columna de signo activada de forma predeterminada
vim.o.signcolumn = 'yes'

-- Disminuir el tiempo de actualización
vim.o.updatetime = 250

-- Disminuir el tiempo de espera de la secuencia mapeada
vim.o.timeoutlen = 300

-- Configurar cómo se deben abrir las nuevas divisiones
vim.o.splitright = true
vim.o.splitbelow = true

-- Establece cómo neovim mostrará ciertos caracteres de espacio en blanco en el editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- ¡Previsualiza las sustituciones en tiempo real mientras escribes!
vim.o.inccommand = 'split'

-- Muestra en qué línea se encuentra el cursor
vim.o.cursorline = false

-- Número mínimo de líneas de pantalla para mantener por encima y por debajo del cursor.
vim.o.scrolloff = 10

-- si se realiza una operación que fallaría debido a cambios no guardados en el búfer (como `:q`),
-- en su lugar, se abre un cuadro de diálogo preguntando si se desea guardar el/los archivo(s) actuales.
-- Ver `:help 'confirm'`
vim.o.confirm = true

vim.o.spell = false
vim.o.wrap = false
vim.o.shiftwidth = 4 -- Número de espacio insertado para la sangría
vim.o.showtabline = 4 -- Mostrar siempre la línea tabline
vim.o.tabstop = 4 -- número de espacio en una pestaña
vim.o.background = 'dark'

-- lee los gui valores de color hexadecimales de varios grupos destacados.
vim.opt.termguicolors = true

--
--
-- ------------------------------------------------------------- ||
--
