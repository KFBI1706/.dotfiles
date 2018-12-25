" vim-bootstrap b99cad

""Note: Skip initialization for vim-tiny or vim-small.
"if  | endif

if &compatible
  set nocompatible
endif
"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be improved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

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

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
""discord
""Plug 'anned20/vimsence'
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}

""syntax checkers
"Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
"Plug 'scrooloose/syntastic'
Plug 'jodosha/vim-godebug'
Plug 'sebdah/vim-delve'
Plug 'lambdalisue/suda.vim'
let g:deoplete#enable_at_startup = 1
Plug 'w0rp/ale'
"Plug 'scrooloose/syntastic'

"Added by me
Plug 'whiteinge/diffconflicts'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-surround'
Plug 'rbgrouleff/bclose.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" end of added by me
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/grep.vim'
Plug 'Raimondi/delimitMate'
"Plug 'majutsushi/tagbar'
Plug 'avelino/vim-bootstrap-updater'
"Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Vim-Session
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"
Plug 'neomake/neomake'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"if v:version >= 73
"  Plug 'Shougo/vimshell.vim'
"endif

""if v:version >= 74
""  "" Snippets
""  Plug 'SirVer/ultisnips'
""endif

"" Color
Plug 'tomasr/molokai'
"Plug 'jdkanani/vim-material-theme'
"Plug 'crucerucalin/peaksea.vim'
"Plug 'liuchengxu/space-vim-dark'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************
" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}

" go
"" Go Lang Bundle
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'vim-scripts/go.vim'

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

"" Map leader to ,
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

"deoplete
"let g:deoplete#sources={}
"let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
"let g:deoplete_ignore_sources = [ "buffer", "*.wiki" ]
"let g:deoplete#omni#input_patterns={}
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#omni_patterns = {}
"let g:deoplete#omni_patterns.scala = '[^. *\t]\.\w*\|: [A-Z]\w*'
"let g:deoplete#omni#input_patterns.scala = ['[^. *\t-9]\.\w*',': [A-Z]\w', '[\[\t\( ][A-Za-z]\w*']
"call deoplete#custom#source('_', 'converters',
"      \ ['converter_auto_paren',
"      \  'converter_auto_delimiter',
"      \ 'converter_remove_overlap'])


" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
set ruler
set number relativenumber
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

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"wiki
let g:vimwiki_list = [{'path':'~/Projects/wiki/files', 'path_html':'~/Projects/wiki/export/html/'}]
""disable url shortening
"let g:vimwiki_url_maxsave="
autocmd BufNewFile,BufRead *.wiki nnoremap <leader>wb :Vimwiki2HTMLBrowse<CR>

"curly bracket tab expansion inoremap
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
" Search for currently selected
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

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

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 3
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <leader>k :NERDTreeToggle<CR>

" find from fzf
map <Leader>f :Ag<space>
map <leader>O :FZF<CR>
command! -bang -nargs=* Find call fzf#vim#grep( 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>)
nnoremap <leader>bd :Bclose<CR>

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
"nnoremap <leader>E :bufdo e<CR>

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

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gD :Git! diff <CR>
noremap <Leader>gd :Git! diff --staged<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-w> :tabclose<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Set the working directory to wherever the open file lives
"set autochdir
"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
"noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>te :tabe % <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>B :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
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

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

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

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>T :tabnew %<cr>
noremap <leader>l :bnext<CR>
noremap <leader>h :bprevious<CR>
"nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
"noremap <leader>w :bn<CR>
noremap <leader>C :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"*****************************************************************************
"" Custom configs
"*****************************************************************************
setlocal spell
"gitcommit
autocmd Filetype gitcommit setlocal spell textwidth=72
"""LATEX
	" Word count:
	autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
	" Compile document using xelatex:
	autocmd FileType tex inoremap <leader><CR> <Esc>:!xelatex<space><c-r>%<Enter>a
	autocmd FileType tex nnoremap <leader><CR> :!xelatex<space><c-r>%<Enter>
	" Code snippets
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4kfR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab


" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
"let g:go_version_warning =

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build()
  endif
endfunction

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
"let g:go_gocode_unimported_packages = 1
"let g:deoplete#sources#go#gocode_binary = $HOME.'/Projects/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#source_importer = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
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

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 73 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

" vim-go
augroup vg
  "au FileType go nmap <leader>b :GoBuild<CR>
  " au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  au FileType go nmap <leader>c :GoCallers<CR>
  au FileType go  nmap <leader>ce :GoCallees<CR>
  "au FileType go Shortcut GoCoverageToggle nmap <leader>? :GoCoverageToggle<CR>
  "au FileType go Shortcut GoDefPop nmap <leader>D :GoDefPop<CR>
  "au FileType go Shortcut GoImplements nmap <leader>v :GoImplements<CR>
  "au FileType go Shortcut GoImports nmap <leader>I :GoImports<CR>
  "au FileType go Shortcut GoInstall nmap <leader>i :GoInstall<CR>
  "au FileType go Shortcut GoPlay nmap <leader>y :GoPlay<CR>
  au FileType go  nmap <leader>' :GoDocBrowser<CR>
  "au FileType go Shortcut GoToggleBreakpoint nmap <leader>b :GoToggleBreakpoint<CR>
  au FileType go nmap <leader>D :GoDebug<CR>
  "au FileType go Shortcut GoRefactor nmap <leader>e :Refactor extract
  au FileType go nmap <leader>st <Plug>(go-run-tab)
  au FileType go nmap <leader>sp <Plug>(go-run-split)
  au FileType go nmap <leader>vs <Plug>(go-run-vertical)
  "au FileType go Shortcut GoAlternate nmap <leader>. :GoAlternate<CR>
  "au FileType go nmap <leader>T :GoTestFunc
  au FileType go nmap <leader>t :GoTest
  "au FileType go Shortcut GoReferrers nmap <leader>r :GoReferrers<CR>
  "au FileType go Shortcut GoReferrers nmap gr :GoReferrers<CR>
  "au FileType go Shortcut GoChannelPeers nmap <leader>p :GoChannelPeers<CR>
  au FileType go nmap <leader>df :GoDef<CR>
  au FileType go nmap <leader>k :GoInfo<CR>
  au FileType go nnoremap <leader>e :GoIfErr<CR>
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
  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>gl  <Plug>(go-lint)
  au FileType go nmap <leader>l :bnext<CR>
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
"  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
"  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  "au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
augroup END

nnoremap <leader>a :cclose<CR>


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
"
if exists('g:loaded_polyglot')
    let g:polyglot_disabled = ['go','python']
endif
let python_highlight_all = 1

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

""set Mouse
set mouse-=c
