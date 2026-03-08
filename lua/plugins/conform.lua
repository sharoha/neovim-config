return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
	  formatters_by_ft = {
		  hlint = { 'hlint' },
		  lua = { 'stylua' }
	  }
  },
  keys = {
	{
		'<leader>f',
		function()
			require('conform').format { async = true, lsp_format = 'fallback' }
		end,
		mode = '',
		desc = '[F]ormat buffer'
	}
  }
}
