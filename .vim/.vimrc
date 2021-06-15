if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" autocompletion
Plug 'ycm-core/YouCompleteMe', {
    \ 'do': './install.py --clangd-completer --cs-completer --go-completer --rust-completer --java-completer --ts-completer'
    \ }

" airline equivalent to powerline
Plug 'vim-airline/vim-airline'

" NERDTree
Plug 'preservim/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin' |
    \ Plug 'ryanoasis/vim-devicons'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'romainl/flattened'
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/sonokai'

" auto closing brackets, parentheses, qutoes
" disabled due to errors
" Plugin 'jiangmiao/auto-pairs'

" block commenting
Plug 'preservim/nerdcommenter'

" coc.nvim
Plug 'neoclide/coc.nvim', {
    \ 'branch': 'release', 'do': 'yarm install --frozen-lockfile'
    \ }

" vim-closetag
Plug 'alvan/vim-closetag'

" vim-prettier
" disabled due to coc-prettier
" Plug 'prettier/vim-prettier', {
"     \ 'do': 'npm install'
"     \ }

" vim-autoformat
Plug 'Chiel92/vim-autoformat'

" pylint
Plug 'vim-scripts/pylint.vim'

" powershell syntax highlightinh
Plug 'pprovost/vim-ps1', {'for': 'ps1'}

" rust syntax highlighting
Plug 'rust-lang/rust.vim', {'for': 'rust'}

Plug 'tpope/vim-fugitive'

" toml syntax highlighting
Plug 'cespare/vim-toml'

" jsdoc syntax hightlighting
Plug 'othree/jsdoc-syntax.vim', {'for': ['javascript', 'typescript']}

" jsonc syntax highlighting
Plug 'neoclide/jsonc.vim'

" CSS color preview
Plug 'ap/vim-css-color'

" enable syntax highlighting for code blacks in Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" built-in vim configs
if !exists('g:syntax_on')
  syntax enable
endif

set runtimepath+=~/.vim/plugged/YouCompleteMe/

filetype plugin indent on

set autoindent
set smartindent
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
if $TERM =~ '256color'
  set t_ut=
endif

set t_Co=256
set background=dark
set termguicolors

" absolute line number, relative line numbers
" aka hybrid line numbers
" set number relativenumber
set nu rnu

" spell check
" disabled due to lack of functionality
" set spell spelllang=en_us

" copy without line numbers
se mouse+=a

" map leader
let mapleader = '\'

" enable doxygen
let g:load_doxygen_syntax=1

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

" extensions for C++ file type
au BufRead,BufNewFile *.tpp set filetype=cpp

" extensions for sh file type
au BufRead,BufNewFile .env* set filetype=sh

" add .clang-tidy as yml
au BufRead,BufNewFile .clang-tidy set filetype=yaml
au BufRead,BufNewFile .clang-format set filetype=yaml

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ycm                                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_extra_conf_globlist = ['~/Programming/*', '!~/*']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']

" clangd
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")

nnoremap <F12> :YcmCompleter GoToDefinition<CR>

" somehow <F36> turns out to be ctrl + F12
nnoremap <F36> :YcmCompleter GoToDeclaration<CR>

nnoremap <A-CR> :YcmCompleter FixIt<CR>

" disable due to unstability
" source ~/git/lsp-examples/vimrc.generated

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 2
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

" Start NERDTree when Vim is started without file arguments but put cursr in
" another window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
    \ if argc() == 0 && !exists('s:std_in') |
      \ NERDTree | wincmd p |
    \ endif

" close vim when only NERDTree pane remains
autocmd BufEnter *
    \ if tabpagenr('$') == 1
        \ && winnr('$') == 1
        \ && exists('b:NERDTree')
        \ && b:NERDTree.isTabTree() |
      \ quit |
    \ endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter *
    \ if bufname('#') =~ 'NERD_tree_\d\+'
        \ && bufname('%') !~ 'NERD_tree_\d\+'
        \ && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" |
      \ execute 'buffer'.buf |
    \ endif

map <C-n> :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark<Space>
noremap <leader>nf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDDefaultAlign = 'left'
let NERDSpaceDelims = 1

map <C-_> <plug>NERDCommenterToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-eslint',
    \ 'coc-prettier'
    \ ]

" coc-pairs
" insert indented newline afte <CR> next to opening pair
inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" rename files
nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-closetag                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.md'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,vue,md'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" seoul256                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:seoul256_background = 233

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sonokai                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sonokai_style = 'atlantis'

" selected colorscheme
colo solarized8_high

" nvim
let g:python3_host_prog=expand('/usr/bin/python3')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-autoformat                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatters_python = ['black']

noremap <F3> :Autoformat<CR>

" format on save
au BufWrite * :Autoformat
