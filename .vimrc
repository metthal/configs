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

" vim-fugitive - git integration
Plugin 'tpope/vim-fugitive'

" vim-gitgutter - show changes on the left seft next to line numbers
Plugin 'airblade/vim-gitgutter'

" NERDTree - whole directory structure
Plugin 'scrooloose/nerdtree'

" NERDTreeTabs - improvement of NERDTree to work with tabs
Plugin 'jistr/vim-nerdtree-tabs'

" NERDTree Dir Enter - fixes opening of folders when 'open in tab' is used
Plugin 'Nopik/vim-nerdtree-direnter'

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
set timeoutlen=50

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
set smarttab
set smartindent

"set expandtab " Use spaces
set noexpandtab " Use tabs

" Spelling check
set spell
set spelllang=en_us,en_gb " English
"set spelllang=sk " Slovak

" Just underline when spelling error is found
hi clear SpellBad
hi SpellBad cterm=underline

" NASM syntax for .asm and .inc files
autocmd BufNewFile,BufRead *.asm set filetype=nasm
autocmd BufNewFile,BufRead *.inc set filetype=nasm

" Alternative navigations between tabs
" Move to the left tab
noremap <C-Left> :tabprev<CR>
" Move to the right tab
noremap <C-Right> :tabnext<CR>

" Stay in visual mode after indentation and keep selection
vnoremap < <gv
vnoremap > >gv

" Paste and copy pasted text again
noremap <C-p> p`[V`]y

" Page Up & Page Down key bindings
noremap <C-Down> <PageDown>
noremap <C-Up> <PageUp>

" Deleting the context of {}, (), [] and ""
onoremap { i{
onoremap ( i(
onoremap [ i[
onoremap " i"

" Show trailing whitespaces and tabs
set list
set listchars=tab:>-,trail:.

" Highlight current line number
set cursorline
hi clear CursorLine
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
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'powerlineish'

" Command-T settings
nnoremap <C-f> :CommandT<CR>
nnoremap <C-b> :CommandTBuffer<CR>
let g:CommandTAcceptSelectionCommand = 'tabe'
let g:CommandTMaxCachedDirectories = 0
let g:CommandTMaxHeight = 15
let g:CommandTTraverseSCM = "pwd"

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!!'
let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
hi YcmErrorSign cterm=bold ctermfg=160
hi YcmWarningSign cterm=bold ctermfg=226
nnoremap <F2> :YcmCompleter GoToDeclaration<CR>

" vim-fugitive bindings
noremap <C-l> :Gblame<CR>
noremap <C-d> :Gdiff<CR>

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
nnoremap <C-e> :NERDTreeTabsToggle<CR>
let g:NERDTreeMapOpenInTab = '<Enter>'
