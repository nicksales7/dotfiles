-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Key Mappings
vim.keymap.set('n', '<leader><Tab>', function()
  vim.cmd('vsplit')                         -- Split the current window vertically
  vim.cmd('wincmd h')                       -- Move to the left window
  vim.cmd('Explore')                        -- Open Netrw in the left split
  vim.cmd('lcd %:p:h')                      -- Set Netrw to the current file's directory
  vim.cmd('wincmd l')                       -- Move back to the right window
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>n', ':noh<CR>', { noremap = true, silent = true }) -- Clear search highlight
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true }) -- Move focus right
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true }) -- Move focus up
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true }) -- Move focus down

-- Disable arrow keys in normal mode
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', { noremap = true, silent = true })

-- Autoclose brackets and quotes
vim.api.nvim_set_keymap('i', '(', '()<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "'", "''<Esc>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '`', '``<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '"', '""<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{', '{}<Esc>i', { noremap = true, silent = true })

-- Autocommands
vim.api.nvim_exec([[
  autocmd FileType markdown setlocal spell spelllang=en
  autocmd FileType markdown nnoremap <buffer> $ $$<Left>
  autocmd FileType tex nnoremap <buffer> $ $$<Left>
  autocmd FileType markdown inoremap <buffer> $ $$<Left>
  autocmd FileType tex inoremap <buffer> $ $$<Left>
]], false)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
      vim.o.conceallevel = 2
      vim.api.nvim_set_keymap('i', '\\{', '\\{\\}<Left><Left>', { noremap = true, silent = true })
  end
})

-- General Options
vim.opt.background = 'dark'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cmdheight = 2
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/Documents/nvim-undo')
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.updatetime = 300
vim.opt.swapfile = false
vim.opt.concealcursor = 'nc'

-- Lazy.nvim Plugins
require("lazy").setup({
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("lackluster")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "java", "haskell", "rust" },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<C-l>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-l>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
      vim.g.UltiSnipsSnippetDirectories = { '~/.vim/UltiSnips', 'UltiSnips' }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "ms-jpq/coq_nvim", branch = "coq" },
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true,
      }
    end,
    config = function()
      -- Your LSP settings here
    end,
  },
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lsp = {},
      mappings = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  }
})

-- Lualine Configuration
require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', function() return vim.fn end},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
