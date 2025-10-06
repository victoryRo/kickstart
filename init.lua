--[[

====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

 ¿Qué es Kickstart?

 Kickstart.nvim *no* es una distribución.

 Kickstart.nvim es un punto de partida para tu propia configuración.
 El objetivo es que puedas leer cada línea de código de principio a fin,
 comprender qué hace tu configuración y modificarla para adaptarla a tus necesidades.

--]]
-- ---------------------------------------------------------------- ||

-- Establezca <space> como tecla líder
-- Consulta `:help mapleader`

-- NOTE: Establecer tecla lider antes de que se carguen los plugins
-- (de lo contrario, se utilizará un líder incorrecto)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Establezca en verdadero si tiene una fuente Nerd instalada y seleccionada en la terminal
vim.g.have_nerd_font = true

-- ---------------------------------------------------------------- ||

-- ------ Configuracion de opciones ------ ||
require 'kickstart.options'

-- ------ Configuracion atajo de teclados ------ ||
require 'kickstart.keymaps'

-- ---- Instalar `lazy.nvim` ---- ||
require 'kickstart.lazy_bootstrap'

-- ---- Configurar e instalar plugins ---- ||
require 'kickstart.lazy_plugins'

-- ------ Conocer el estado de Neovim ------ ||
require 'kickstart.health'

------------------------------------------- nvim-go
-- autocomand para nvim-go plugin

local NvimGo = vim.api.nvim_create_augroup('NvimGo', {
  clear = true,
})
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'NvimGoLintPopupPost',
  group = NvimGo,
  command = 'wincmd p',
})

---------------------------------------------------|
-- deshabilitar algunos proveedores predeterminados
-- cuando verificamos el estado de neovim

for _, provider in ipairs { 'node', 'perl', 'python3', 'ruby' } do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

---------------------------------------------------|

-- ------------------------------------------------------------- ||
--
