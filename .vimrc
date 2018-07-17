" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" Source a global configuration file if available
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif

" Uncomment the next line to make Vim more Vi-compatible
"set compatible
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-sensible'

Plugin 'vim-syntastic/syntastic'

Plugin 'altercation/vim-colors-solarized'

Plugin 'vim-vdebug/vdebug'

Plugin 'Raimondi/delimitMate'
Plugin 'othree/html5.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'

"Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-repeat'

" All" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo of your Plugins must be added before the following line
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

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  " The ":syntax enable" command will keep your current color settings.  This
  " allows using ":highlight" commands to set your preferred colors before or
  " after using this command.  If you want Vim to overrule your settings with the
  " defaults, use: >
  " 	:syntax on
  syntax enable
endif

" Use the OS clipboard
set clipboard=unnamed

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Solarized
" option name               default     optional
" ------------------------------------------------
" g:solarized_termcolors=   16      |   256
" g:solarized_termtrans =   0       |   1
" g:solarized_degrade   =   0       |   1
" g:solarized_bold      =   1       |   0
" g:solarized_underline =   1       |   0
" g:solarized_italic    =   1       |   0
" g:solarized_contrast  =   "normal"|   "high" or "low"
" g:solarized_visibility=   "normal"|   "high" or "low"
" ------------------------------------------------
"let g:solarized_termcolors=256
colorscheme solarized

" Additional filetypes
au BufRead,BufNewFile *.php,*.module,*.inc,*.install,*.theme set filetype=php
au BufRead,BufNewFile *.tpl,*.twig set filetype=html
au BufRead,BufNewFile *.make set filetype=yaml

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_css_checkers = ['stylelint']

" Indentation overrides
au filetype php,html,xhtml,css,javascript,json,yaml,markdown,make set expandtab
au filetype php,html,xhtml,css,javascript,json,yaml,markdown,make set tabstop=2
au filetype php,html,xhtml,css,javascript,json,yaml,markdown,make set shiftwidth=2

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For these filetypes set 'textwidth' to 78 characters.
  autocmd FileType php,html,xhtml,javascript setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
	\ | exe "normal! g'\"" | endif

  " automatically reload vimrc when it's saved
  au BufWritePost .vimrc so ~/.vimrc

endif " has("autocmd")

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set hlsearch		" When there is a previous search pattern, highlight all matches.

set list 		" Show tabs and trailing spaces.

" Folding by syntax
"set foldmethod=syntax
"set foldlevelstart=20
"set foldnestmax=1

"set cursorline		" Highlight the cursor line.
set number		" Print the line number in front of each line.
set colorcolumn=+2	" Highlight columns, set to number or +/- 'textwidth'.

" Undo persistence
set undofile
set undodir=~/.vim/undo

" Make a backup before overwriting a file.
set writebackup
" The backup is removed after the file was successfully written,
" unless the 'backup' option is also on.
set backup
set backupdir=~/.vim/backup

" Vim-git mappings
:map f :Fixup<CR>
:map s :Squash<CR>
:map r :Reword<CR>
:map c :Pick<CR>

" Prettier
nnoremap gp :silent %!prettier --stdin --trailing-comma es5 --single-quote<CR>
