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
vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>Trouble diagnostics toggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-q>', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-w>', '<cmd>Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-s>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>b', '<cmd>Telescope buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>s', '<cmd>Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>x', '<cmd>Telescope commands<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader><C-t>', '<Cmd>Telescope lsp_workspace_symbols<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader><C-O>', '<Cmd>Telescope lsp_document_symbols<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<localleader>l', '<cmd>Trouble diagnostics toggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>q', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>f', '<cmd>lua vim.lsp.buf.format()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>w', '<cmd>Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>s', '<cmd>Telescope current_buffer_fuzzy_find<CR>', {noremap = true})

vim.api.nvim_set_keymap('!', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-f>', '<C-Right>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-b>', '<C-Left>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-l>', '<cmd>Trouble diagnostics toggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<A-q>', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-q>', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-l>', '<Plug>(skkeleton-toggle)', {noremap = true})

vim.api.nvim_create_user_command(
  'SearchConflicts',
  function()
    vim.fn.setreg('/', '^\\(<\\{7\\}\\||\\{7\\}\\|=\\{7\\}\\|>\\{7\\}\\).*')
    vim.o.hlsearch = true
  end,
  {}
)

vim.cmd [[
augroup on_any_file
  autocmd!
  autocmd BufRead,BufNewFile * set fileformat=unix
  autocmd BufRead,BufNewFile * set encoding=utf-8
  autocmd BufRead,BufNewFile * set textwidth=120
  autocmd BufRead,BufNewFile * set shiftwidth=2
  autocmd BufRead,BufNewFile * set noautowrite
  autocmd BufRead,BufNewFIle * set expandtab
  autocmd BufRead,BufNewFIle * set shiftwidth=2
  autocmd BufRead,BufNewFIle * set tabstop=2
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

augroup on_rust
  autocmd!
  autocmd BufRead,BufNewFile *.rs set shiftwidth=4
  autocmd BufRead,BufNewFIle *.rs set shiftwidth=4
  autocmd BufRead,BufNewFIle *.rs set tabstop=4
augroup END

augroup on_python
  autocmd!
  autocmd BufRead,BufNewFile *.py set shiftwidth=4
  autocmd BufRead,BufNewFIle *.py set shiftwidth=4
  autocmd BufRead,BufNewFIle *.py set tabstop=4
  autocmd BufRead,BufNewFile *.py set textwidth=79
augroup END
]]

vim.api.nvim_create_augroup('on_java', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'java',
  group = 'on_java',
  callback = function()
    require('jdtls').start_or_attach {
      cmd = {'jdtls'},
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    }
  end,
})

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
      dependencies = {
        'kyazdani42/nvim-web-devicons',
      },
    },

    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      run = ':TSUpdate'
    },
    'andymass/vim-matchup',
    --'p00f/nvim-ts-rainbow',
    --{
    --  'yioneko/nvim-yati',
    --  dependencies = {
    --    'nvim-treesitter/nvim-treesitter',
    --  },
    --},

    'ur4ltz/surround.nvim',
    'windwp/nvim-autopairs',

    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim',
      },
      config = true,
    },
    'lewis6991/gitsigns.nvim',
    'emmanueltouzery/agitator.nvim',

    {
      'vim-skk/skkeleton',
      dependencies = {
        'vim-denops/denops.vim',
      },
      config = function()
        vim.api.nvim_create_augroup('skkeleton-initialize-pre', { clear = true })
        vim.api.nvim_create_autocmd({ 'User' }, {
          pattern = 'skkeleton-initialize-pre',
          group = 'skkeleton-initialize-pre',
          callback = function()
            vim.api.nvim_call_function("skkeleton#config", {{
              globalDictionaries = {'~/.skk/SKK-JISYO.L'},
              showCandidatesCount = 0,
            }})
          end,
        })
      end,
    },

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

    'mfussenegger/nvim-jdtls',
    'udalov/kotlin-vim',

    'simrat39/rust-tools.nvim',

    'imsnif/kdl.vim',

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

    'b0o/schemastore.nvim',
    'vmchale/dhall-vim',

    'NoahTheDuke/vim-just',
    --'IndianBoy42/tree-sitter-just',
  },
  {}
)

require('rust-tools').setup()

require('lualine').setup {
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_z = {
      function()
        return string.format('%3d:%-2d', vim.fn.line('.'), vim.fn.virtcol('.'))
      end,
    },
  },
}

--vim.opt.runtimepath:append("/home/ryo/.local/share/nvim/lazy/nvim-treesitter")
require('nvim-treesitter').setup {
  -- parser_install_dir = "/home/ryo/.local/share/nvim/lazy/nvim-treesitter",
  ensure_installed = { 'vim', 'query', 'bash', 'c', 'rust', 'python', 'lua' },
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
    enable = false,
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
require('bufferline').setup()

require('neogit').setup {}

require('gitsigns').setup {}

function _G.ShowCommitAtLine()
  local commit_sha = require'agitator'.git_blame_commit_for_line()
  vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
end

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'bashls',
    'jsonls',
    'kotlin_language_server',
    'lua_ls',
    'lemminx',
    'rust_analyzer',
    'ts_ls',
  },
}

local lspconfig = require('lspconfig')

lspconfig.bashls.setup {}

lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.dhall_lsp_server.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
}

lspconfig.clangd.setup {}

lspconfig.denols.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
}

lspconfig.kotlin_language_server.setup {}

lspconfig.lemminx.setup {
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=false, buffer=bufnr }
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end,
}

lspconfig.ts_ls.setup {
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  single_file_support = false,
}

lspconfig.pyright.setup {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
      },
    },
  }
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
  vim.opt.guifont = "Cica:h10:b"

  for _, mode in ipairs({"n", "!"}) do
    vim.api.nvim_set_keymap(mode, '<C-=>', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1; print("neovide_scale_factor=%s", vim.g.neovide_scale_factor)<CR>', {noremap = true})
    vim.api.nvim_set_keymap(mode, '<C-->', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1; print("neovide_scale_factor=%s", vim.g.neovide_scale_factor)<CR>', {noremap = true})
    vim.api.nvim_set_keymap(mode, '<C-0>', '<cmd>lua vim.g.neovide_scale_factor = 1.<CR>', {noremap = true})
  end
end
