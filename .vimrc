" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" Source a global configuration file if available
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif

" Uncomment the next line to make Vim more Vi-compatible
"set compatible

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
let g:solarized_termcolors=256
colorscheme solarized

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set hlsearch		" When there is a previous search pattern, highlight all matches.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set history=1000	" Commands and previous search patterns to remember.
set autoindent		" Copy indent from current line when starting a new line.

set complete-=i		" Remove included files from autocomplete scan (for speed).

set smarttab		" Tab follows 'shitwidth' and 'tabstop' settings.
"set nrformats-=octal	" Example: Using CTRL-A on "007" results in "010".
set shiftround		" Round indent to multiple of 'shiftwidth'.
set laststatus=1	" Show status line only if there are at least two windows.
set ruler		" Show the line and column number of the cursor position.
set showcmd		" Show (partial) command in the last line of the screen.
set wildmenu		" Command-line completion operates in an enhanced mode.
set scrolloff=1		" Minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=5	" Same horizontally, if 'nowrap' is set.
set display+=lastline   " As much as possible of the last line in a window will be displayed.
set autoread		" When a file is changed outside of Vim, automatically read it again.

" Visually wrap long lines
set wrap
set linebreak

"set list 		" Show tabs and trailing spaces.
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Increase command timeout (slow connections)
"set ttimeout
"set ttimeoutlen=50

" Load matchit.vim, but only if the user hasn't installed a newer version.
"if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
"  runtime! macros/matchit.vim
"endif

" Folding by syntax
"set foldmethod=syntax
"set foldlevelstart=20
"set foldnestmax=1

"set number		" Print the line number in front of each line.
"set colorcolumn=+2	" Highlight columns, set to number or +/- 'textwidth'.

" Undo persistence
set undofile
set undodir=~/.vim/undo

" Make a backup before overwriting a file.
set writebackup
" The backup is removed after the file was successfully written,
" unless the 'backup' option is also on.
set backup
set backupdir=~/.vim/backup

" Swap file location
" Using "." first in the list is recommended.  This means that editing
"	the same file twice will result in a warning.  Using "/tmp" on Unix is
"	discouraged: When the system crashes you lose the swap file.
"	"/var/tmp" is often not cleared when rebooting, thus is a better
"	choice than "/tmp".  But it can contain a lot of files, your swap
"	files get lost in the crowd.  That is why a "tmp" directory in your
"	home directory is tried first.
"set dir=/tmp

" Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %
"cmap w!! %!sudo dd of=%

" Horizontal resize without <shift>
map <C-w>, <C-w><
map <C-w>. <C-w>>

" Swtich to new window on vsplit
map <C-w>v :belowright vsplit<CR>

" Quit quickly (overrides q/@ recording/execution)
"map q :q<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" Reselect visual block after indent/outdent
"vnoremap < <gv
"vnoremap > >gv
" if your doing this just to indent it further (like i was), dont forget about
" repeating the last command with .

" Use as <Esc> alternative
"inoremap jk <Esc>
"inoremap kj <Esc>
"inoremap jj <Esc>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Additional filetypes
au BufRead,BufNewFile *.module,*.inc,*.install set filetype=php
au BufRead,BufNewFile *.local set filetype=rc
au BufRead,BufNewFile *.tpl set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile /etc/nginx/*.conf set ft=nginx

" Indentation overrides
au filetype php,html,css,javascript set expandtab
au filetype php,html,css,javascript set tabstop=2
au filetype php,html,css,javascript set shiftwidth=2
au filetype nginx set expandtab
au filetype nginx set tabstop=4
au filetype nginx set shiftwidth=4
au filetype nginx set cindent
