
-- these are the language servers to maintain
local lang_servers = {
    "lua_ls",
    "pyright",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
	local cmp = require('cmp')
	local cmp_lsp = require('cmp_nvim_lsp')
	local capabilities = vim.tbl_deep_extend(
	    "force",
	    {},
	    vim.lsp.protocol.make_client_capabilities(),
	    cmp_lsp.default_capabilities()
	)

	require('mason').setup()
	require('mason-lspconfig').setup {
	    ensure_installed = lang_servers,
	    automatic_installation = true,
	    handlers = {
		function(server_name)
		    require('lspconfig')[server_name].setup {
			capabilities = capabilities
		    }
		end
	    }
	}

	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	cmp.setup {
	    snippet = {
		expand = function(args)
		    require('luasnip').lsp_expand(args.body)
		end,
	    },
	    mapping = cmp.mapping.preset.insert {
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	    },
	    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	    }, {
		{ name = 'buffer' },
	    })
	}

	vim.diagnostic.config({
	    update_in_insert = true,
	    virtual_lines = true,
	    signs = false,
	})
    end,
}
