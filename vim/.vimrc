set autowrite
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

" Maps < leader > / so we're ready to type the search keyword
nnoremap <Leader> f :Rg <CR>
 " Navigate quickfix list with ease
nnoremap <silent> [q :cprevious <CR>
nnoremap <silent> ]q :cnext <CR>

" Go error commands
map <C-s> :cnext<CR>
map <C-a> :cprevious<CR>
noremap <Leader>a :cclose<CR>


" Go cmd commands
autocmd FileType go map <leader>r :GoRun<CR>
autocmd FileType go map <leader>t :GoTest<CR>
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
 let l:file = expand('%')
 if l:file =~# '^\f\+_test\.go$'
   call go#test#Test(0, 1)
 elseif l:file =~# '^\f\+\.go$'
   call go#cmd#Build(0)
 endif
endfunction

autocmd FileType go nmap <leader>x :<C-u>call <SID>build_go_files()<CR>

 
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
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set updatetime=300
set shortmess+=c " don't give | ins-completion-menu | messages.

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
    else
          call feedkeys('K', 'in')
    endif
endfunction

" Use to apply macros in the right lines
xnoremap @: <C-u> call ExecuteMacroOverVisualRange() <CR>

function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Enable highlight in Go
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1

"Configure metalinter for Go
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1


" Configure alternates for Go
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.jsx,*.tsx,*.json,*.astro PrettierAsync

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
autocmd BufNewFile,BufRead *.astro set filetype=astro


call plug#begin()
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'wuelnerdotexe/vim-astro'
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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prisma/vim-prisma'
call plug#end()

