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

" indentation style for different file types

" html
autocmd FileType html setlocal tabstop=2 sts=2 shiftwidth=2

" css
autocmd FileType css setlocal tabstop=2 sts=2 shiftwidth=2

" javascript
autocmd FileType javascript setlocal tabstop=2 sts=2 shiftwidth=2

" typescript
autocmd FileType typescript setlocal tabstop=2 sts=2 shiftwidth=2

" java
autocmd FileType java setlocal tabstop=2 sts=2 shiftwidth=2

" Makefile
autocmd FileType make set noexpandtab

" shell
autocmd FileType sh setlocal tabstop=2 sts=2 shiftwidth=2

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
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" nerdcommmenter
let NERDSpaceDelims=1
