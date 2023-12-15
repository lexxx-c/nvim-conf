
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("bar")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    
    -- theme
    {'rebelot/kanagawa.nvim', },

    --        -- dap
    --        'mfussenegger/nvim-dap',
    --        'rcarriga/nvim-dap-ui',
    --        -- Linters
    --        --'mfussenegger/nvim-lint',
    --        'nvim-lua/plenary.nvim',
    --        'nvimtools/none-ls.nvim',
    --        -- Formatters
    --        -- 'mhartington/formatter.nvim'

    -- mason
    {'williamboman/mason.nvim', },
    {'williamboman/mason-lspconfig.nvim', },
    -- lsp-zero
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {'neovim/nvim-lspconfig', },
    {'hrsh7th/cmp-nvim-lsp', },
    -- autocompletion
    {'hrsh7th/nvim-cmp', },
    {'L3MON4D3/LuaSnip', },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter", 
        -- build = ":TSUpdate"
    },

    -- telescope
    {'nvim-lua/plenary.nvim', },
    {
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x', 
    },

    -- undotree
    {'mbbill/undotree', },

    -- Git
    {'tpope/vim-fugitive', }, 
    -- GitHub
    {'tpope/vim-rhubarb', }, 

    -- nvim-tree
    {"nvim-tree/nvim-web-devicons", }, 
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
    }

--    {
--        'akinsho/toggleterm.nvim', 
--        version = "*", 
--        config = true
--    }
    
})


require("plugins.kanagawa")
require("plugins.treesitter")
require("plugins.nvim-tree")

require("plugins.lsp-zero")
require("plugins.mason")
require("plugins.mason-lspconfig")









