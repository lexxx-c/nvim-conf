

local M = {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        'L3MON4D3/LuaSnip', -- Snippets plugin
        'onsails/lspkind.nvim',
    },
}


M.config = function()
    local cmp = require'cmp'
    local lspkind = require('lspkind')
    cmp.setup {
        formatting = {
            format = lspkind.cmp_format(),
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),         
        }),
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, 
            {
                { name = 'buffer' },
            }
        )
    }
    -- Set configuration for specific filetype.
    -- cmp.setup.filetype('gitcommit', {
    --     sources = cmp.config.sources(
    --         {
    --             -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    --             { name = 'git' },
    --         }, 
    --         {
    --             { name = 'buffer' },
    --         }
    --     )
    -- })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline({ '/', '?' }, {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = {
    --         { name = 'buffer' }
    --     }
    -- })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(':', {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = cmp.config.sources(
    --         {
    --             { name = 'path' }
    --         }, 
    --         {
    --             { name = 'cmdline' }
    --         }
    --     )
    -- })
end

return M


