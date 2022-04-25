if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" autocompletion and other plugins
Plug 'neoclide/coc.nvim', {
    \ 'branch': 'release', 'do': 'yarn install --frozen-lockfile'
    \ }


Plug 'itchyny/lightline.vim'

" NERDTree
Plug 'preservim/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin' |
    \ Plug 'ryanoasis/vim-devicons'

" colorscheme
Plug 'sainnhe/everforest'

" Syntax highlighting
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" block commenting
Plug 'preservim/nerdcommenter'

" enclose selected text in pairs
Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

" vim-autoformat
Plug 'Chiel92/vim-autoformat'

" pylint
Plug 'vim-scripts/pylint.vim'

" jsdoc syntax hightlighting
Plug 'othree/jsdoc-syntax.vim', {'for': ['javascript', 'typescript']}

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
set nofen

" column length indicator
set colorcolumn=80,100,120

" background theme
if $TERM =~ '256color'
  set t_ut=
endif

set t_Co=256
set background=dark
set termguicolors

" zsh is slow
set shell=/bin/bash

" color scheme
let g:everforest_background = 'soft'
let g:everforest_enable_italic = 1

colo everforest

" absolute line number, relative line numbers
" aka hybrid line numbers
" set number relativenumber
set nu rnu

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

" extensions for MIB file type
au BufRead,BufNewFile *-MIB* set filetype=mib

" add .clang-tidy as yml
au BufRead,BufNewFile .clang-tidy set filetype=yaml
au BufRead,BufNewFile .clang-format set filetype=yaml
au BufRead,BufNewFile .clangd set filetype=yaml

au BufRead,BufNewFile *geojson set filetype=json

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-nvim                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-n>" :
      \ coc#refresh()
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-clangd',
    \ 'coc-rls',
    \ 'coc-pyright',
    \ 'coc-html'
    \ ]

" coc-pairs
" insert indented newline afte <CR> next to opening pair
inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" rename files
nmap <leader>rn <Plug>(coc-rename)

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

let g:NERDCustomDelimiters = {
  \ 'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
  \ }

map <C-_> <plug>NERDCommenterToggle

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hyundeok Park                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:auto_split(...)
  let l:width = winwidth(0)
  let l:height = winheight(0) * 2

  if (height > width)
    if (a:0 > 0)
      exe "split " . a:1
    else
      :split
    endif
  else
    if (a:0 > 0)
      exe "vsplit " . a:1
    else
      :vsplit
    endif
  endif
endfunction

command! -nargs=? HyundeokAutoSplit :call <SID>auto_split(<f-args>)

function! s:coc_auto_split(...)
  let fname = a:1
  let call = ''

  if a:0 == 2
    let fname = a:2
    let call = a:1
  endif

  let bufnum=bufnr(expand(fname))
  let winnum=bufwinnr(bufnum)

  exe "HyundeokAutoSplit " . fname

  exe call
endfunction

command! -nargs=+ CocHyundeokAutoSplit :call <SID>coc_auto_split(<f-args>) 
