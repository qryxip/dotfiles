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
vim.api.nvim_set_keymap('n', '<localleader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<localleader>l', '<cmd>TroubleToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>q', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>w', '<cmd>Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>s', '<cmd>Telescope current_buffer_fuzzy_find<CR>', {noremap = true})

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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(
  {
    'sickill/vim-monokai',
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    },
    {
      'akinsho/bufferline.nvim',
      version = "^2",
      dependencies = {
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('bufferline').setup()
      end,
    },

    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    },
    'andymass/vim-matchup',
    'p00f/nvim-ts-rainbow',
    {
      'yioneko/nvim-yati',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
    },

    'ur4ltz/surround.nvim',
    'windwp/nvim-autopairs',

    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'folke/trouble.nvim',
      dependencies = {
        'kyazdani42/nvim-web-devicons',
      },
    },
    'j-hui/fidget.nvim',
    'kyazdani42/nvim-web-devicons',

    'simrat39/rust-tools.nvim',

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',

    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },

    {
      'chrisbra/csv.vim',
      config = function()
        vim.cmd [[
        augroup on_csv
          autocmd!
          autocmd BufRead,BufNewFile *.csv let b:csv_arrange_align='l*'
        augroup END
        ]]
      end,
    },

    'vmchale/dhall-vim',

    'NoahTheDuke/vim-just',
    'IndianBoy42/tree-sitter-just',
  },
  {}
)

require('rust-tools').setup()

require('lualine').setup {
  options = {
    theme = 'gruvbox',
  }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'bash', 'c', 'rust' },
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
    disable = { "lua" },
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
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
}

lspconfig.denols.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
}

lspconfig.tsserver.setup {
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  single_file_support = false,
}

lspconfig.rust_analyzer.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
  autostart = false,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy",
      }
    }
  }
}

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'lua_ls',
    'rust_analyzer',
    'tsserver',
  },
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

if vim.g.neovide then
  vim.opt.guifont = { "Cica", "h12" }

  for _, mode in ipairs({"n", "!"}) do
    vim.api.nvim_set_keymap(mode, '<C-=>', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1; print("neovide_scale_factor=%s", vim.g.neovide_scale_factor)<CR>', {noremap = true})
    vim.api.nvim_set_keymap(mode, '<C-->', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1; print("neovide_scale_factor=%s", vim.g.neovide_scale_factor)<CR>', {noremap = true})
    vim.api.nvim_set_keymap(mode, '<C-0>', '<cmd>lua vim.g.neovide_scale_factor = 1.<CR>', {noremap = true})
  end
end
