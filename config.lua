lvim.plugins = {
    -- Themes
    {
        "chrisfishbob/Everbloom",
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "sainnhe/sonokai" },
    { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        keys = {
            { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
            { "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },
            { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
            { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" },
            { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" },
            { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" },
        }
    },
    -- Autosave
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {}
        end
    },
    -- Undotree
    { "mbbill/undotree" },
    -- Auto PEP 8 indent
    { "Vimjas/vim-python-pep8-indent" },
    -- UFO (folding utility)
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = "BufReadPost",
        keys = {
            {
                "zr",
                function() require("ufo").openFoldsExceptKinds { "comment" } end,
                desc = " 󱃄 Open All Folds except comments",
            },
            { "zm", function() require("ufo").closeAllFolds() end, desc = " 󱃄 Close All Folds" },
            {
                "z1",
                function() require("ufo").closeFoldsWith(1) end,
                desc = " 󱃄 Close L1 Folds",
            },
            {
                "z2",
                function() require("ufo").closeFoldsWith(2) end,
                desc = " 󱃄 Close L2 Folds",
            },
            {
                "z3",
                function() require("ufo").closeFoldsWith(3) end,
                desc = " 󱃄 Close L3 Folds",
            },
            {
                "z4",
                function() require("ufo").closeFoldsWith(4) end,
                desc = " 󱃄 Close L4 Folds",
            },
        },
        init = function()
            -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
            -- auto-closing them after leaving insert mode, however ufo does not seem to
            -- have equivalents for zr and zm because there is no saved fold level.
            -- Consequently, the vim-internal fold levels need to be disabled by setting
            -- them to 99
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
        opts = {
            provider_selector = function(_, ft, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
                if vim.tbl_contains(lspWithOutFolding, ft) then return { "treesitter", "indent" } end
                return { "lsp", "indent" }
            end,
            -- open opening the buffer, close these fold kinds
            -- use `:UfoInspect` to get available fold kinds from the LSP
            close_fold_kinds = { "imports", "comment" },
            open_fold_hl_timeout = 800,
            -- fold_virt_text_handler = foldTextFormatter,
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require "colorizer".setup()
        end,
    }
}

Sonokai_dim_inactive_windows = 0

-- Set default color scheme
lvim.colorscheme = "sonokai"

-- Undotree toggle
lvim.keys.normal_mode["<leader>u"] = vim.cmd.UndotreeToggle

-- Centering the cursor in various scenarios
lvim.keys.normal_mode["G"] = "Gzz"

-- Move blocks of text while in visual mode
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

-- Unables copy and pasting outside of vim
lvim.keys.normal_mode["<leader>y"] = "\"+y"
lvim.keys.visual_mode["<leader>y"] = "\"+y"

-- Spaces > tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Misc
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 10

-- The Dark Arts
lvim.keys.normal_mode["Q"] = "<nop>"

-- References navigation but better
lvim.keys.normal_mode["<C-j>"] = "<cmd>cnext<CR>zz"
lvim.keys.normal_mode["<C-k>"] = "<cmd>cprev<CR>zz"

-- Tab navigation
lvim.keys.normal_mode["<C-n>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":BufferLineCyclePrev<CR>"

-- For when the LSP decides to hallucinate
lvim.keys.normal_mode["<leader>z"] = ":LspRestart<CR>"
