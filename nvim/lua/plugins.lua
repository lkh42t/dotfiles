local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap
if vim.fn.isdirectory(install_path) == 0 then
  packer_bootstrap = vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    -- editor scheme
    use("fneu/breezy")
    use("tomasiser/vim-code-dark")
    use("itchyny/lightline.vim")

    -- language support
    use({ "dart-lang/dart-vim-plugin", ft = "dart" })
    use({ "Vimjas/vim-python-pep8-indent", ft = "python" })

    -- editor enhancement
    use("editorconfig/editorconfig-vim")
    use("airblade/vim-gitgutter")
    use("tpope/vim-fugitive")
    use({
      "tpope/vim-surround",
      requires = { "tpope/vim-repeat" },
    })
    use("tpope/vim-commentary")
    use("cohama/lexima.vim")
    use("ctrlpvim/ctrlp.vim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- language server and completion
    use("neovim/nvim-lspconfig")
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
      },
    })

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    git = {
      subcommands = {
        install = "clone --no-single-branch --progress",
      },
    },
  },
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])
