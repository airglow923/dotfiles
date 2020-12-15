call plug#begin('~/.vim/plugged')

" autocompletion
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --all --clangd-completer'}

" airline equivalent to powerline
Plug 'vim-airline/vim-airline'

" NERDTree
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}

" colorscheme gruvbox
Plug 'morhetz/gruvbox'

" auto closing brackets, parentheses, qutoes
" disabled due to errors
" Plugin 'jiangmiao/auto-pairs'

" block commenting
Plug 'preservim/nerdcommenter'

" clang-format
Plug 'rhysd/vim-clang-format'

" coc.nvim
Plug 'neoclide/coc.nvim', {
    \   'branch': 'release', 'do': 'yarm install --frozen-lockfile'
    \ }

call plug#end()

" built-in vim configs
syntax on
filetype plugin indent on
set autoindent

set encoding=utf-8
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

" copy without line numbers
se mouse+=a

" colorscheme
colorscheme gruvbox

" map leader
let mapleader = '\'

" ycm
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/.ycm_extra_conf.py'
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

" detect WSL
" unused
function IsWSL()
  let is_wsl = 0
  if !empty(system("grep -F -i 'microsoft' '/proc/version' 2>/dev/null"))
    let is_wsl = 1
  endif
  return is_wsl
endfunction

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' |
        \ call system(s:clip, @0) | endif
  augroup END
endif
