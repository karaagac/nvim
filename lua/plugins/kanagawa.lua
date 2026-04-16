return {
	"rebelot/kanagawa.nvim", 
	config =function()
		require('kanagawa').setup({
			compile=true,
			commentStyle = { italic = true },
			keywordStyle = { italic = true},
			statementStyle = { bold = true },

		});
		vim.cmd("colorscheme kanagawa");	
	end,

	build = function()
		vim.cmd("KanagawaCompile");
	end,
}
