vim.o.backspace = 'start,eol,indent'
vim.o.encoding = 'utf-8'
vim.o.fileformat = 'unix'
vim.o.laststatus = 2
vim.o.listchars = 'tab:>-,trail:-,eol: ,extends:»,precedes:«,nbsp:%'
vim.o.ttimeoutlen = 50
vim.o.updatetime = 100
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.api.nvim_set_keymap('n', '<C-j>', '<C-m>', {})
vim.api.nvim_set_keymap('n', '<A-f>', '<Plug>(easymotion-overwin-f2)', {})

vim.api.nvim_set_keymap('n', '<C-n>', 'gt', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', 'gT', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', 'c$', {noremap = true})
vim.api.nvim_set_keymap('n', '<ESC>', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>TroubleToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-q>', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-w>', '<cmd>Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-s>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>b', '<cmd>Telescope buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>s', '<cmd>Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>x', '<cmd>Telescope commands<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting_sync, ots)

vim.api.nvim_set_keymap('!', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-f>', '<C-Right>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-b>', '<C-Left>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-l>', '<cmd>TroubleToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-q>', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-q>', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})

vim.cmd [[
augroup on_any_file
  autocmd!
  autocmd BufRead,BufNewFile * set fileformat=unix
  autocmd BufRead,BufNewFile * set encoding=utf-8
  autocmd BufRead,BufNewFile * set textwidth=120
  autocmd BUfRead,BufNewFile * set shiftwidth=4
  autocmd BufRead,BufNewFile * set noautowrite
  autocmd BufRead,BufNewFIle * set expandtab
  autocmd BufRead,BufNewFIle * set shiftwidth=4
  autocmd BufRead,BufNewFIle * set tabstop=4
augroup END

augroup on_latex
  autocmd!
  autocmd BufRead,BufNewFile *.tex set textwidth=120
augroup END

augroup on_makefile
  autocmd!
  autocmd BufRead,BufNewFile Makefile set textwidth=79
  autocmd BufRead,BufNewFile Makefile set noexpandtab
augroup END

augroup on_scala
  autocmd!
  autocmd BufRead,BufNewFile *.scala set textwidth=120
  autocmd BufRead,BufNewFile *.scala set shiftwidth=2
augroup END
]]

vim.cmd('packadd packer.nvim')

require('packer').startup(function()
  use 'sickill/vim-monokai'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup()
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'andymass/vim-matchup'
  use 'p00f/nvim-ts-rainbow'
  use { 'yioneko/nvim-yati', requires = 'nvim-treesitter/nvim-treesitter' }

  use 'ur4ltz/surround.nvim'
  use 'windwp/nvim-autopairs'

  use 'neovim/nvim-lspconfig'
  use {
    'folke/trouble.nvim',
    require = 'kyazdani42/nvim-web-devicon',
  }
  use 'j-hui/fidget.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use 'simrat39/rust-tools.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'onsails/lspkind-nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'}
    },
  }

  use {
    'chrisbra/csv.vim',
    config = function()
      vim.cmd [[
      augroup on_csv
        autocmd!
        autocmd BufRead,BufNewFile *.csv let b:csv_arrange_align='l*'
      augroup END
      ]]
    end,
  }

  use 'vmchale/dhall-vim'

  use 'NoahTheDuke/vim-just'
  use 'IndianBoy42/tree-sitter-just'
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('rust-tools').setup()

require('lualine').setup {
  options = {
    theme = 'gruvbox',
  }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'bash', 'c', 'lua', 'rust' },
  highlight = {
      enable = true,
  },
  incremental_selection = {
      enable = true,
  },
  indent = {
      enable = true,
      disable = {
        "rust",
        "lua",
      },
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
  yati = {
    enable = true,
  },
}

require('surround').setup {}

require('nvim-autopairs').setup {
  check_ts = true,
  map_c_h = true,
  map_c_w = true,
}

require('nvim-web-devicons').setup()

local lspconfig = require('lspconfig')
lspconfig.bashls.setup {}
lspconfig.dhall_lsp_server.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end,
}
lspconfig.rust_analyzer.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end,
  autostart = false,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = "clippy",
      }
    }
  }
}

require('trouble').setup()

local cmp = require('cmp')
cmp.setup {
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
    },
    {
      { name = 'path' },
    },
    {
       { name = 'buffer' },
    }
  ),
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-m>'] = cmp.mapping.confirm({ select = true }),
    ['<C-j>'] = cmp.mapping.confirm({ select = true }),
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol',
    }),
  },
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').select_default,
      },
    },
  }
}

vim.cmd [[
  colorscheme monokai
]]
