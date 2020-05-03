let mapleader = ';'
noremap <leader> <nop>
" PLUGINS:
call plug#begin('~/.vim/plugged')
" LIST OF PLUGINS:
Plug 'junegunn/vim-plug'    " for helptags
" --- Completion -------------------------
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" --- Linting ----------------------------
Plug 'dense-analysis/ale'
" --- Making it look good ----------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
" --- FuzzyFinder ------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" --- Working with Git -------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" --- NerdTree ---------------------------
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" --- Additional syntax support ----------
Plug 'let-def/ocp-indent-vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
" --- Misc -------------------------------
Plug 'haya14busa/is.vim'       " incsearch
Plug 'thaerkh/vim-workspace'
Plug 'dylanaraps/wal.vim'
" ----------------------------------------
call plug#end()
" -------

" BASICS:
set encoding=utf-8
set number relativenumber
set ruler
set showcmd
set incsearch
set colorcolumn=80
set mouse=a
set clipboard=unnamedplus
syntax on

" APPEARENCE:
set background=dark
set termguicolors
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_invert_selection=0
colorscheme gruvbox

hi clear SignColumn " Required after having changed the colorscheme

"   Airline:
let g:airline_theme='gruvbox'

set laststatus=2 " Always shows the statusline
let g:airline_powerline_fonts = 1

" airline for tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" integration with other extensions
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#ale#enabled = 1

" FUZZYFINDING:
set path+=** " Do I need this, since I'm using fuzzying finding
set wildmenu
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :Ag<CR>

" ALE:

"   Linters:
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1

let g:ale_linters = {
      \'ocaml': ['merlin'],
      \'vim': ['vint'] }

"   Fixers:
let g:ale_fix_on_save = 1

let g:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace' ],
      \'ocaml': ['ocp-indent'] }
" Python is completely supported by coc, check CocConfig
" C++ seems to be completely supported by coc-clangd

" COC:
let g:coc_global_extensions = [
      \'coc-marketplace', 'coc-lists',
      \'coc-pairs', 'coc-yank',
      \'coc-json', 'coc-python', 'coc-vimlsp' , 'coc-clangd', 'coc-prettier']
" clangd is under llvm, thus preferred
" coc-reason doesn't rely on Merlin, so it's kind of dumb ^^

"   Misc:
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]g <Plug>(coc-diagnostic-next-error)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)| " not working for clangd
nmap <silent> gi <Plug>(coc-implementation)|  " not working for clangd
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup highlight_on_cursor
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <leader>t :CocList<CR>

command! -nargs=0 Format :call CocAction('format')
nmap <leader>f :Format<CR>

"  Enable autocompletion
set wildmode=longest,list,full

" NERDTREE:
let g:netrw_banner=0                            " disable annoying banner
let g:netrw_browse_split=4                      " open in prior window
let g:netrw_altv=1                              " open splits to the right
let g:netrw_liststyle=3                         " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()    " hide gitignored
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
map <C-n> :NERDTreeToggle<CR>

" VIMWORKSPACE:
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_create_new_tabs = 0
let g:workspace_autosabe_insert_leave = 0

" SHORTCUTS:

"   Split Navigation:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow splitright

"   Buffers:
nnoremap <leader>j :bprevious<CR>
nnoremap <leader>k :bnext<CR>
nnoremap <leader>q :bp <BAR> bd #<CR>

"   Tabs:
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>
nnoremap <leader>Q :tabclose<CR>
nnoremap <leader>n :tab split<CR>

"   Remove Surrounding:
nnoremap <leader>x %x``x

"   Disable Arrows:
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

"   TERMINAL:
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <A-;> <C-\><C-N>

augroup term_auto_insert
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup END

" INDENTATION:
" Tab is equal to the normal indentation step, which is 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set cindent

" MISC:

augroup disable_commenting_newline
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
