set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" autocompletion
Plugin 'ycm-core/YouCompleteMe'

" airline equivalent to powerline
Plugin 'vim-airline/vim-airline'

" NERDTree
Plugin 'preservim/nerdtree'

" colorscheme gruvbox
Plugin 'morhetz/gruvbox'

" auto closing brackets, parentheses, qutoes
" disabled due to errors
" Plugin 'jiangmiao/auto-pairs'

" block commenting
Plugin 'preservim/nerdcommenter'

" clang-format
Plugin 'rhysd/vim-clang-format'

" coc.nvim
Plugin 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarm install --frozen-lockfile'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

" built-in vim configs
syntax on
filetype plugin indent on    " required
set autoindent

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set laststatus=2

set showcmd

" column length indicator
set colorcolumn=80,100,120

" background theme
set background=dark

" absolute line number, relative line numbers
" aka hybrid line numbers
set number relativenumber
set nu rnu

" colorscheme
colorscheme gruvbox

" map leader
let mapleader = '\'
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" ycm
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/ycm_extra_conf/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

" nerd tree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

map <C-n> :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark<Space>
noremap <leader>nf :NERDTreeFind<cr>

" nerdcommmenter
let NERDDefaultAlign = 'left'
let NERDSpaceDelims = 1

map <C-_> <plug>NERDCommenterToggle

" clang-format
map <leader>fmt :ClangFormat<cr>
