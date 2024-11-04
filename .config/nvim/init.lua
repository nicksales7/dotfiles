-- Remap leader to space
vim.g.mapleader = " "

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

-- New Explore Tab
vim.keymap.set('n', '<leader><Tab>', function()
  vim.cmd('vsplit')                         -- Split the current window vertically
  vim.cmd('wincmd h')                       -- Move to the left window
  vim.cmd('Explore')                        -- Open Netrw in the left split
  vim.cmd('lcd %:p:h')                      -- Set Netrw to the current file's directory
  vim.cmd('wincmd l')                       -- Move back to the right window
end, { noremap = true, silent = true })

-- Spell Check on for markdown files
vim.api.nvim_exec([[
  autocmd FileType markdown setlocal spell spelllang=en
]], false)

-- Dark mode and colorscheme
vim.opt.background = 'dark'

-- For nextword idk
vim.api.nvim_set_keymap('n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })

-- Move focus right
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })

-- Move focus up
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })

-- Move focus down
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })

-- Autoclose for TeX files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.api.nvim_set_keymap('i', '\\(', '\\(\\)<Left><Left>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '\\[', '\\[\\]<Left><Left>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '\\{', '\\{\\}<Left><Left>', { noremap = true, silent = true })
  end
})

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

-- Autocmd to set up a keymap for $$ in markdown 
vim.api.nvim_exec([[
  autocmd FileType markdown nnoremap <buffer> $ $$<Left>
  autocmd FileType markdown inoremap <buffer> $ $$<Left>
]], false)

-- Set tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Show line numbers and set relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the current line
vim.opt.cursorline = true

-- Enable mouse support in all modes
vim.opt.mouse = 'a'

-- Set backspace to behave more intuitively
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- Enable search highlighting and incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Ignore case when searching, unless uppercase is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set command-line height to 2 lines for more visibility
vim.opt.cmdheight = 2

-- Enable 24-bit RGB color support
vim.opt.termguicolors = true

-- Set auto indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Enable clipboard support
vim.opt.clipboard = 'unnamedplus'

-- Set undo file to remember undo history between sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/Documents/nvim-undo')

-- Set split window directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set up a wildmenu for command line completion
vim.opt.wildmenu = true

-- Reduce update time for more responsive UI
vim.opt.updatetime = 300

-- Turn off swap files
vim.opt.swapfile = false

-- Setup lazy.nvim
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
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
      vim.g.UltiSnipsSnippetDirectories = { '~/.vim/UltiSnips', 'UltiSnips' }
    end,
  },
  { "Julian/lean.nvim" },
  { "neoclide/coc.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
})

-- Configure lualine
require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      'filename',
      function()
        return vim.fn
      end
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
