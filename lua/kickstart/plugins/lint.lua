--
-- ---------------------------- Lint --------------------------- ||

return {

	-- Pelusa (linting)
	{
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require 'lint'
			lint.linters_by_ft = {
				-- instalamos markdownlint con npm global
				markdown = { 'markdownlint' },
				-- instalamos jsonlint con npm global
				-- json = { 'jsonlint' },
			}

			-- Para permitir que otros complementos agreguen linters a require('lint').linters_by_ft,
			-- configure linters_by_ft de la siguiente manera:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
			--
			-- Sin embargo, tenga en cuenta que esto habilitará un conjunto de linters predeterminados,
			-- lo que provocará errores a menos que estas herramientas estén disponibles:
			-- {
			--   clojure = { "clj-kondo" },
			--   dockerfile = { "hadolint" },
			--   inko = { "inko" },
			--   janet = { "janet" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			--   rst = { "vale" },
			--   ruby = { "ruby" },
			--   terraform = { "tflint" },
			--   text = { "vale" }
			-- }

			-- Puede deshabilitar los linters predeterminados configurando sus tipos de archivo como nil:
			-- lint.linters_by_ft['clojure'] = nil
			-- lint.linters_by_ft['dockerfile'] = nil
			-- lint.linters_by_ft['inko'] = nil
			-- lint.linters_by_ft['janet'] = nil
			-- lint.linters_by_ft['json'] = nil
			-- lint.linters_by_ft['markdown'] = nil
			-- lint.linters_by_ft['rst'] = nil
			-- lint.linters_by_ft['ruby'] = nil
			-- lint.linters_by_ft['terraform'] = nil
			-- lint.linters_by_ft['text'] = nil

			-- Crea un autocomando que realiza el análisis de errores en los eventos especificados.
			local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
			vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
				group = lint_augroup,
				callback = function()
					-- Ejecute el linter únicamente en búferes que pueda modificar para evitar ruido superfluo,
					-- especialmente dentro de las prácticas ventanas emergentes de LSP
					-- que describen el símbolo sobre el que se desplaza el cursor usando Markdown.
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}

--
--
-- ------------------------------------------------------------- ||
--
