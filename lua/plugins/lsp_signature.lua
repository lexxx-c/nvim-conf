
return {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = function() 
        -- require'lsp_signature'.setup() 
        require'lsp_signature'.on_attach({
            -- hint_prefix = ' ',
            toggle_key = '<M-s>', -- toggle signature on and off in insert mode
        }) 
    end
}



