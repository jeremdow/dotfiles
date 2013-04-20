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
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

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

" Su-write
command W w !sudo tee % > /dev/null

" Custom formatting
au BufRead,BufNewFile *.module,*.inc,*.install set filetype=php
au BufRead,BufNewFile *.local set filetype=rc
au BufRead,BufNewFile *.tpl set filetype=html
au filetype php,html,css,javascript,bash,rc set expandtab
au filetype php,html,css,javascript set tabstop=2
au filetype php,html,css,javascript set shiftwidth=2

" Crosh Ctrl-w wincmd workarounds
"nmap <silent> <C-j> :wincmd j<CR>
"nmap <silent> <C-k> :wincmd k<CR>
