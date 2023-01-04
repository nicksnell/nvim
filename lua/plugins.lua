local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'

  use { 
    'nvim-treesitter/nvim-treesitter',  
    run = function()
	local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end
  }

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use {
   'nvim-tree/nvim-tree.lua',
    -- requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use {
    'romgrk/barbar.nvim', 
    wants = 'nvim-web-devicons'
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
    end
  }

  use 'mhinz/vim-startify'
  use 'tpope/vim-fugitive'
  use 'sheerun/vim-polyglot'  
  use 'tjdevries/colorbuddy.nvim'
  use 'bkegley/gloombuddy'
  use 'editorconfig/editorconfig-vim'
  use 'numToStr/Comment.nvim'
  use 'wakatime/vim-wakatime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'css', 'elixir', 'go', 'html', 'javascript', 
    'json', 'lua', 'markdown', 'r', 'rust', 'ruby', 
    'scss', 'sql', 'swift', 'toml', 'typescript', 'yaml', 
    'vue', 'python'
  }
})

require('colorbuddy').colorscheme('gloombuddy')
require('lualine').setup()
require('Comment').setup()

-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('nvim-tree').setup()

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- require'telescope'.load_extension('project')
