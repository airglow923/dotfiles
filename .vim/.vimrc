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

" vim-closetag
Plug 'alvan/vim-closetag'

" vim-prettier
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'for': [
        \ 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql',
        \ 'markdown', 'vue', 'yaml', 'html'
        \ ]
    \ }

call plug#end()

" built-in vim configs
syntax on
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

" enable doxygen
let g:load_doxygen_syntax=1
 
"##############################################################################"
" ycm                                                                          "
"##############################################################################"

let g:ycm_extra_conf_globlist = ['~/Programming/*', '!~/*']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_clangd_binary_path='clangd'

nnoremap <F12> :YcmCompleter GoToDefinition<CR>

" somehow <F36> turns out to be ctrl + F12
nnoremap <F36> :YcmCompleter GoToDeclaration<CR>

nnoremap <A-CR> :YcmCompleter FixIt<CR>

"##############################################################################"
" nerdtree                                                                     "
"##############################################################################"

let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

map <C-n> :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark<Space>
noremap <leader>nf :NERDTreeFind<cr>

"##############################################################################"
" nerdcommenter                                                                "
"##############################################################################"

let NERDDefaultAlign = 'left'
let NERDSpaceDelims = 1

map <C-_> <plug>NERDCommenterToggle

"##############################################################################"
" clang-format                                                                 "
"##############################################################################"

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

" extensions C++ file type
au BufRead,BufNewFile *.tpp set filetype=cpp

" add .clang-tidy as yml
au BufRead,BufNewFile .clang-tidy set filetype=yaml
au BufRead,BufNewFile .clang-format set filetype=yaml

"##############################################################################"
" coc.nvim                                                                     "
"##############################################################################"

" coc-pairs
" insert indented newline afte <CR> next to opening pair
inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"##############################################################################"
" vim-closetag                                                                 "
"##############################################################################"

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,vue'

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
