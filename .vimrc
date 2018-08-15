" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" Source a global configuration file if available
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif

" Uncomment the next line to make Vim more Vi-compatible
"set compatible

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'

" A pretty statusline, bufferline integration
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

" Git wrapper inside Vim, sign column in the gutter
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Plug 'vim-syntastic/syntastic'
Plug 'vim-vdebug/vdebug', { 'on': 'VdebugStart' }

Plug 'w0rp/ale'
"Plug 'maximbaz/lightline-ale'

" Initialize plugin system
call plug#end()

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
let g:solarized_visibility="low"
colorscheme solarized

" Lightline
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly'],
  \     ['filename']
  \   ],
  \   'right': [
  \     ['linter'],
  \     ['lineinfo'],
  \     ['fileformat', 'fileencoding', 'filetype'],
  \    ]
  \ },
  \ 'inactive' : {
  \   'right': [
  \     ['lineinfo', 'percent'],
  \     ['fileformat', 'fileencoding', 'filetype'],
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'LightlineFugitive',
  \   'filename': 'LightlineFilename',
  \   'linter': 'LinterStatus'
  \ }
\ }

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function! LightlineFugitive() abort
    if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
        let l:branch = fugitive#head()
        return l:branch !=# '' ? '± '.l:branch : ''
    endif
    return ''
endfunction

" TODO: This is unused, remove it? -JMD
function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" Additional filetypes
au BufRead,BufNewFile *.php,*.module,*.inc,*.install,*.theme set filetype=php
au BufRead,BufNewFile *.tpl,*.twig set filetype=html
au BufRead,BufNewFile *.make set filetype=yaml

" Syntastic
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_css_checkers = ['stylelint']
"let g:syntastic_php_checkers = ['php', 'phpcs']
"let g:syntastic_php_phpcs_args='--standard=Drupal'

" Asynchronous Lint Engine
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1

" Set this variable to 1 to fix files when you save them.
"let g:ale_fix_on_save = 1

" Enable completion where available.
let g:ale_completion_enabled = 1

" Drupal/Coder
let g:ale_php_phpcs_use_global = 1
let g:ale_php_phpcs_standard = 'Drupal'
let b:ale_fixers = {'php': ['phpcbf']}
let g:ale_php_phpcbf_use_global = 1
let g:ale_php_phpcbf_standard = 'Drupal'

" Indentation overrides
au filetype php,html,xhtml,css,scss,javascript,json,yaml,markdown,make set expandtab
au filetype php,html,xhtml,css,scss,javascript,json,yaml,markdown,make set tabstop=2
au filetype php,html,xhtml,css,scss,javascript,json,yaml,markdown,make set shiftwidth=2

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
  "au BufWritePost .vimrc so ~/.vimrc

endif " has("autocmd")

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set noshowcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set noshowmode		" Mode information is displayed in the statusline.
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
set undodir=~/.local/share/nvim/undo
set undolevels=500                      " max undos stored
set undoreload=10000                    " buffer stored undos

" Make a backup before overwriting a file.
set writebackup
" The backup is removed after the file was successfully written,
" unless the 'backup' option is also on.
"set backup
set backupdir=~/.local/share/nvim/backup

" Vim-git mappings
:map f :Fixup<CR>
:map s :Squash<CR>
:map r :Reword<CR>
:map c :Pick<CR>

" Prettier
nnoremap gp :silent %!prettier --stdin --trailing-comma es5 --single-quote<CR>
