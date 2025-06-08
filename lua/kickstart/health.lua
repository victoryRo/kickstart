--[[
--
-- Este archivo no es necesario para su propia configuración,
-- pero ayuda a las personas a determinar si su sistema está configurado correctamente.
--
-- este archivo se llama desde la pagina principal ( init.lua )
-- ejecutando el comando :check
--]]

local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim obsoleto: '%s'. Actualice a la última versión estable o nightly", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format("La version de Neovim es: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim obsoleto: '%s'. Actualice a la última versión estable o nocturna", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Se encontró ejecutable: '%s'", exe))
    else
      vim.health.warn(string.format("No se pudo encontrar el ejecutable: '%s'", exe))
    end
  end

  return true
end

return {

  -- esta es la funcion que se ejecuta cuando se ejecuta el comando :check
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[NOTA: No todas las advertencias son una "solución obligatoria" en `:checkhealth`

	Corrige solo las advertencias de los plugins e idiomas que quieras usar.
	Mason mostrará advertencias para los idiomas que no estén instalados.
	No necesitas instalarlos, a menos que quieras usar esos idiomas!]]

    local uv = vim.uv or vim.loop
    vim.health.info('Información del sistema: ' .. vim.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
