if &compatible
  set nocompatible
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))

Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
let g:deoplete#enable_at_startup = 1
Plug 'luochen1990/rainbow'
Plug 'w0rp/ale'
Plug 'sebdah/vim-delve'
Plug 'lambdalisue/suda.vim'
Plug 'whiteinge/diffconflicts'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'rbgrouleff/bclose.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tomasr/molokai'
" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
" go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries','for':['go'], 'tag': '*'}
Plug 'vim-scripts/go.vim', {'for': ['go']}
Plug 'buoto/gotests-vim', {'for': ['go']}
Plug 'jodosha/vim-godebug', {'for': ['go']}
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

call plug#end()

autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
set modifiable
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set lazyredraw                                   " enable lazyredraw
set nocursorline                                 " disable cursorline
set ttyfast                                      " enable fast terminal connection

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
"set softtabstop=
set shiftwidth=4
set expandtab

set history=10000

"" Map leader to space
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile
set undofile undodir=~/.vim/undo undolevels=9999 " undo options

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
" do not hide markdown
set conceallevel=0
"responsiveness
set nocursorcolumn
set scrolljump=10
set synmaxcol=180

syntax on
set ruler
"set number relativenumber
set background=dark
let no_buffers_menu=1
colorscheme molokai

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 1

if &term =~ '256color'
  set t_ut=
endif

set scrolloff=2

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=1

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ %p%%\ col\ %c)

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" find from fzf
map <Leader>f :Ag<space>
map <leader>O :FZF<CR>
command! -bang -nargs=* Find call fzf#vim#grep( 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>)
" buffer close while keeping the window
nnoremap <leader>bd :Bclose<CR>
nnoremap <leader>bD :Bclose!<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 20 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=20
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

"" go build on save
"autocmd BufWritePre *.go :GoBuild
"
"remove whitespaces
autocmd BufWritePre * %s/\s\+$//e

"focus
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
set autoread                                     " reload on external file changes

"*****************************************************************************
"" Mappings
"*****************************************************************************
" deoplete
imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr> pumvisible() ? deoplete#close_popup() : "\<cr>"
""source vim
nnoremap <leader>R :source ~/.nvimrc<CR>

"Hide/show
nnoremap <leader><esc> :let @/=''<cr>:noh<cr>       " clear search
noremap <leader>`       :set relativenumber!<CR>
nnoremap <leader>p :set invpaste paste?<cr>     " toggle paste mode

""Write
noremap <leader>w       :w !sudo tee %<CR>
if has('nvim')
    noremap <leader>w   :w suda://%<CR>
endif

"" Split
noremap <Leader>b :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
"" Pane
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-w> :tabclose<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>te :tabe % <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>B :Buffers<CR>
nnoremap <leader>E :Explore<CR>
"wildmode
set wildmenu wildmode=longest:full,full          " wildmode settings
"ale
" Error and warning signs.
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEErrorSign ctermfg=25 ctermbg=236 guifg=#465457 guibg=#232526
highlight ALEWarningSign ctermfg=25 ctermbg=236 guifg=#465457 guibg=#232526
highlight ALEError ctermbg=none cterm=underline
"relative number background
highlight CursorLineNr ctermfg=15 ctermbg=236 guifg=#465457 guibg=#232526
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
"let g:ale_sign_error = '💣'
"let g:ale_sign_warning = '🚩'
let g:ale_open_list = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"Better commenting style
highlight CommentsWithoutSpace ctermbg=236
match CommentsWithoutSpace /\/\/ \@!/

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>T :tabnew %<cr>
noremap <leader>l :bnext<CR>
noremap <leader>h :bprevious<CR>
nmap <leader>bl :ls<CR>
noremap <leader>C :bd<CR>

"" Clear search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Resize windows
nnoremap <silent> <Leader>J :exe "resize " . (winheight(0) + 20)<CR>
nnoremap <silent> <Leader>K :exe "resize " . (winheight(0) - 20)<CR>
nnoremap <silent> <Leader>H :exe "vertical resize " . (winwidth(0) - 30)<CR>
nnoremap <silent> <Leader>L :exe "vertical resize " . (winwidth(0) + 30)<CR>
"" Reset window sizes
nnoremap <Leader>= <C-w>=

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


"*****************************************************************************
"" Custom configs
"*****************************************************************************
setlocal spell

autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" vim-go
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_updatetime = 2000
let g:go_info_mode = 'gocode'
let g:go_fmt_fail_silently = 1
let g:syntastic_go_checkers = ['golint', 'govet','test','build']
let g:syntastic_mode_map = { 'mode': 'active' }

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_extra_types = 1
"
let g:go_term_enabled = 1
let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1

let g:go_addtags_transform = "camelcase"

set completeopt+=noselect
let g:go_gocode_unimported_packages = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#source_importer = 1

imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
         \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"
""snipets
let g:neosnippet#snippets_directory = ['~/.config/nvim/snippets/']
let g:go_snippet_engine = "neosnippet"
imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

augroup completion_preview_close
  autocmd!
  if v:version > 73 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>rb  <Plug>(go-build)
  au FileType go nmap <leader>r  <Plug>(go-run-split)
  au FileType go nmap <leader>gl  <Plug>(go-lint)
  au FileType go nmap <leader>gn  <Plug>(go-rename)
  au FileType go nmap <leader>l :bnext<CR>
  au FileType go nmap <leader>t  <Plug>(go-test)
  "au FileType go nmap <leader>T  <Plug>(go-test-func)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
"  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
"  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  "au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
augroup END

"netrw - super simple fileBrowser
let g:netrw_banner=0
"let g:netrw_browse_split=4
let g:netrw_altv=1
"let g:netrw_liststyle = 3
let g:netrw_winsize = 25

"close quickfix windows
nnoremap <leader>a :cclose<CR>

" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

set mouse-=c
