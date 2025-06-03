--
-- -------------------------- KEYMAPS -------------------------- ||
--  Ver `:help vim.keymap.set()`

-- ------------- Modo Normal ------------- ||

-- Borrar los resaltados en la búsqueda al presionar <Esc> en modo normal
--  Ver `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- ---- NEOTREE
-- Abrir y cerrar menu
vim.keymap.set('n', '<leader>e', '<cmd>:Neotree toggle<CR>', { desc = 'Menu' })
-- Posicionar el menu en el archivo actual
vim.keymap.set('n', '<leader>o', '<cmd>:Neotree selector<CR>', { desc = 'Achivo en menu' })

-- ---- GENERAL
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Escribir' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Cerrar' })

-- ---- DIVIDIR VENTANAS
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = 'Ventana horizontal' })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Ventana vertical' })

-- ---- MOVER VENTANAS
vim.keymap.set('n', '<leader>1', ':vertical resize +8<cr>', { desc = 'Mover división a la derecha' })
vim.keymap.set('n', '<leader>2', ':vertical resize -8<cr>', { desc = 'Mover división a la izquierda' })
vim.keymap.set('n', '<leader>3', ':resize +5<cr>', { desc = 'Mover división arriba' })
vim.keymap.set('n', '<leader>4', ':resize -5<cr>', { desc = 'Mover división abajo' })

-- GO PREVIEW
vim.keymap.set('n', 'ld', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = 'LSP definicion' })
vim.keymap.set('n', 'lt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { desc = 'LSP definicion de tipo' })
vim.keymap.set('n', 'li', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { desc = 'LSP implementacion' })
vim.keymap.set('n', 'lc', "<cmd>lua require('goto-preview').close_all_win()<CR>", { desc = 'cerrar vista previa' })
vim.keymap.set('n', 'lr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = 'LSP referencias' })
vim.keymap.set('n', 'lp', "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", { desc = 'LSP declaracion' })

-- TERMINAL
vim.keymap.set('n', 'tv', ':ToggleTerm direction=vertical size=85 name=Vertical<CR>', { desc = 'Terminal vertical' })
vim.keymap.set('n', 'th', ':ToggleTerm direction=horizontal size=15 name=Horizontal<CR>', { desc = 'Terminal horizontal' })
vim.keymap.set('n', 'tb', ':ToggleTerm direction=tab size=20 name=Tab<CR>', { desc = 'Terminal tab' })
vim.keymap.set('n', 'tf', ':ToggleTerm direction=float size=50 name=Flotante<CR>', { desc = 'Terminal flotante' })

-- BUFFERLINE
vim.keymap.set('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { desc = 'Buffer previo' })
vim.keymap.set('n', '<leader>bn', ':BufferLineCycleNext<CR>', { desc = 'Buffer siguiente' })
vim.keymap.set('n', '<leader>bc', ':BufferLineCloseOthers<CR>', { desc = 'Buffer cerrar todos excepto el actual' })
vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { desc = 'Buffer cerrar a la izquierda' })
vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { desc = 'Buffer cerrar a la derecha' })

-- Diagnostico Mapas de teclas
-- vim.keymap.set('n', '<leader>i', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Combinaciones de teclas para facilitar la navegación dividida.
--  Use CTRL+<hjkl> to switch between windows

-- Consulte `:help wincmd` para obtener una lista de todos los comandos de ventana
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Mover el foco a la ventana izquierda' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Mover el foco a la ventana izquierda' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Mover el foco a la ventana izquierda' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Mover el foco a la ventana izquierda' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--

-- ------------- Modo Insert ------------- ||

-- jk comando de escape para salir de modo insert a modo normal
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })

-- ------------- Modo Visual ------------- ||

-- Mover lineas resaltadas a la derecha e izquierda
vim.keymap.set('v', '<', '<gv', { desc = 'Indentar a la izquierda' })
vim.keymap.set('v', '<', '>gv', { desc = 'Indentar a la derecha' })

-- Mover lineas arriba y abajo
vim.keymap.set('v', 'J', ":move '>+1<CR>gv-gv", { desc = 'Mover lineas abajo' })
vim.keymap.set('v', 'K', ":move '<-2<CR>gv-gv", { desc = 'Mover lineas arriba' })

-- -------- Comandos automaticos --------- ||
--  See `:help lua-guide-autocommands`

-- Resaltar al copiar texto
-- Pruébalo con `yap` en modo normal
--  Consulte `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

--
--
-- ------------------------------------------------------------- ||
--
