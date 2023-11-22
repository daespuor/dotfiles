set scrolloff=8
set number
set relativenumber
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set encoding=utf-8
set expandtab 
set smartindent 
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use to find files
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags <CR>

" Maps < leader > / so we're ready to type the search keyword
 nnoremap <Leader> f :Rg <CR>
 " Navigate quickfix list with ease
nnoremap <silent> [q :cprevious <CR>
nnoremap <silent> ]q :cnext <CR>

" NERDTree commands
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
      \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
" Fold python
let g:SimpylFold_docstring_preview = 1

" Use tab for trigger completion with characters ahead and navigate.
" " NOTE: There's always complete item selected by default, you may want to
" enable
 " no select by `"suggest.noselect": true` in your configuration file.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" Detect root env for Python
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
" Detect node version
let g:coc_node_path = '$HOME/.nvm/versions/node/v16.6.1/bin/node'
inoremap <silent><expr> <TAB>
       \ coc#pum#visible() ? coc#pum#next(1) :
       \ CheckBackspace() ? "\<Tab>":
       \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1)
       : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use < c-space > to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `: CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> ff <Plug>(coc-format-selected)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set updatetime=300
set shortmess+=c " don't give | ins-completion-menu | messages.

" Use K to show documentation in preview window
 nnoremap  K :call show_documentation()

 function! s:show_documentation()
       if (index(['vim', 'help'], & filetype) >= 0)
             execute 'h '.expand('')
       else
             call CocAction('doHover')
       endif
 endfunction

" Use to apply macros in the right lines
xnoremap @: <C-u> call ExecuteMacroOverVisualRange() <CR>

function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
                  \ [
                  \   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
                  \   {
                  \     'filetype': 'typescript',
                  \     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
                  \     'end': '',
                  \   },
                  \   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
                  \ ]
let g:ft=''
let g:ale_fix_on_save=1
let g:ale_fixers={'javascript': ['prettier', 'eslint'],
                  \   'typescript': ['prettier', 'eslint'],
                  \   'python': ['autopep8'],
                  \}
call plug#begin()
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', {'do': {-> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'codechips/coc-svelte', {'do': 'npm install'}
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'Shougo/context_filetype.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
