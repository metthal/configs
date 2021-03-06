" This primary enables python3 instead of python2 in vim
" If we want to use python2 just run vim --cmd 'let py2=1'
if exists('py2') && has('python')
elseif has('python3')
endif

" Vundle
" -----------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-airline - better status line
Plugin 'vim-airline/vim-airline'

" vim-airline-themes - themes for vim-airline
Plugin 'vim-airline/vim-airline-themes'

" YouCompleteMe - code completion
Plugin 'Valloric/YouCompleteMe'

" YCM_Generator
Plugin 'rdnetto/YCM-Generator'

" vim-fugitive - git integration
Plugin 'tpope/vim-fugitive'

" vim-gitgutter - show changes on the left next to line numbers
Plugin 'airblade/vim-gitgutter'

" NERDTree - whole directory structure
Plugin 'scrooloose/nerdtree'

" ctrlp.vim - fuzzy opening of files
Plugin 'ctrlpvim/ctrlp.vim'

" vim-grepper - integration with searching in files
Plugin 'mhinz/vim-grepper'

" QFEnter - navigation in quickfix window
Plugin 'yssl/QFEnter'

" Rainbow - rainbow color parentheses
Plugin 'luochen1990/rainbow'

" Tagbar - display class outlines using tags
Plugin 'majutsushi/tagbar'

" Markdown preview
Plugin 'iamcco/markdown-preview.nvim'

" RetDec DSM Syntax Highlight
Plugin 's3rvac/vim-syntax-retdecdsm'

" Redmine Wiki Syntax Highlight
Plugin 's3rvac/vim-syntax-redminewiki'

" YARA Syntax Highlight
Plugin 's3rvac/vim-syntax-yara'

" PowerShell Syntax Highlight
Plugin 'PProvost/vim-ps1'

" badwolf color scheme
Plugin 'sjl/badwolf'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" -----------------------------------------------------------

" Color scheme
syntax on
colorscheme badwolf

" Always show line numbers
set number

" Relative line numbers
function! NumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

" Switch to relative line numbers when in insert mode
autocmd InsertEnter * :set relativenumber
autocmd InsertLeave * :set norelativenumber

" Manual switch if we need it
nnoremap <C-m> :call NumberToggle()<cr>

" Shorten timeout when leaving insert mode
set timeoutlen=1000 ttimeoutlen=50

" Always show status line
set laststatus=2

" Don't use swap files
set noswapfile

" Improve loading speeds
set ttyfast

" Do not wrap lines
set nowrap

" Tab & indent settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set tabstop=2
"set softtabstop=2
"set shiftwidth=2
set smarttab
set smartindent

" Allow switching between buffers when changes are unsaved
set hidden

" Search while typing
set incsearch

"set expandtab " Use spaces
set noexpandtab " Use tabs

" Spelling check
" set spell
"set spelllang=en_us,en_gb " English
"set spelllang=sk " Slovak

" Show possible files when doing filename autocompletion
set wildmenu

" Just underline when spelling error is found
hi clear SpellBad
hi SpellBad cterm=underline

" NASM syntax for .asm and .inc files
autocmd BufNewFile,BufRead *.asm set filetype=nasm
autocmd BufNewFile,BufRead *.inc set filetype=nasm

" LLVM syntax for .ll files
autocmd BufNewFile,BufRead *.ll set filetype=llvm

" RetDec DSM syntax for .dsm files
autocmd BufNewFile,BufRead *.dsm set filetype=retdecdsm

" Redmine Wiki syntax for .redmine files
autocmd BufNewFile,BufRead *.redmine set filetype=redminewiki

" YARA syntax for .yar and .yara files
autocmd BufNewFile,BufRead *yar,*.yara set filetype=yara

" Dockerfiles
autocmd BufNewFile,BufRead Dockerfile.* set filetype=dockerfile

" SQL files
autocmd BufNewFile,BufRead *.sql set filetype=mysql

" No spell checking in quickfix window
autocmd FileType qf set nospell

" Alternative navigations between buffers
" Move to the left buffer
noremap <C-Left> :bprev<CR>
" Move to the right buffer
noremap <C-Right> :bnext<CR>

" Stay in visual mode after indentation and keep selection
vnoremap < <gv
vnoremap > >gv

" Paste and copy pasted text again
noremap <C-p> p`[v`]y

" Page Up & Page Down key bindings
noremap <C-Down> <PageDown>
noremap <C-Up> <PageUp>

" Deleting the context of {}, (), [], "" and <>
onoremap { i{
onoremap ( i(
onoremap [ i[
onoremap " i"
onoremap < i<

" Show trailing whitespaces and tabs
set list
set listchars=tab:>-,trail:.

" Highlight current line number
hi CursorLineNR ctermfg=226

" Shortcuts for hex-edit
execute "set <M-x>=\ex"
execute "set <M-c>=\ec"
nmap <M-x> :%!xxd -g1<CR>
nmap <M-c> :%!xxd -g1 -r<CR>

" vimdiff navigation
" Next difference
noremap <M-Down> ]c
" Previous difference
noremap <M-Up> [c
" Update differences
noremap <C-u> :diffupdate<CR>
" Merging
execute "set <M-a>=\ea"
execute "set <M-d>=\ed"
execute "set <M-s>=\es"
nnoremap <M-a> :diffget LOCAL<CR>
nnoremap <M-s> :diffget BASE<CR>
nnoremap <M-d> :diffget REMOTE<CR>

" vim-airline settings
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_theme = 'powerlineish'

" ctrlp settings
set wildignore+=*/env/*,*/build/*,*/__pycache__/*,*/site-packages/*

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!!'
let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_rust_src_path = '/home/milkovic/rust-1.28.0/src'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
hi YcmErrorSign cterm=bold ctermfg=160
hi YcmWarningSign cterm=bold ctermfg=226
nnoremap <F2> :YcmCompleter GoToDeclaration<CR>
nnoremap <F3> :YcmCompleter GoToDefinition<CR>

" vim-fugitive bindings
noremap <C-l> :Gblame<CR>
noremap <C-d> :Gdiff<CR>
execute "set <M-n>=\en"
execute "set <M-m>=\em"
noremap <M-m> :cnext<CR>
noremap <M-n> :cprev<CR>

" vim-gitgutter symbols and colors
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = '~-'
hi GitGutterChange cterm=bold ctermfg=226
hi GitGutterAdd cterm=bold ctermfg=118
hi GitGutterDelete cterm=bold ctermfg=160
hi GitGutterChangeDelete cterm=bold ctermfg=202

" NERDTree settings
nnoremap <C-e> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
let g:NERDTreeMapActivateNode = '<Enter>'

" vim-grepper settings
let g:grepper = {
	\ 'tools': [ 'ag' ]
	\ }
let g:grepper.quickfix = 1
let g:grepper.highlight = 1
nnoremap <Leader>/ :Grepper<CR>
nnoremap <Leader>c :Grepper -cword -noprompt<CR>

" QFEnter settings
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = [ '<CR>' ]
let g:qfenter_keymap.open_keep = [ '<Leader><CR>' ]

" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'ctermfgs': ['darkblue', 'darkgreen', 'magenta', 'darkred'],
\	'separately': {
\		'cmake': 0
\	}
\}

" Tagbar
let g:tagbar_ctags_bin = '~/bin/ctags-repo/install/bin/ctags'
let g:tagbar_sort = 0
nmap . :TagbarToggle<CR>
