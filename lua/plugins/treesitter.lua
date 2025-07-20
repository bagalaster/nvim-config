return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	local configs = require'nvim-treesitter.configs'

	configs.setup({
	    ensure_installed = { "lua", "luadoc", "sql", "python", "markdown", "markdown_inline" },
	    sync_install = false,
	    highlight = { enable = true },
	    auto_install = true,
	})
    end
}

