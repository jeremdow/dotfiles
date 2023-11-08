" .vimrc
" TODO: Get rid of this old boilerplate
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" TODO: Do this Neovim way (or not at all).
" Source a global configuration file if available
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif

" TODO: Does nvim even support this?
" Uncomment the next line to make Vim more Vi-compatible
"set compatible

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
" Run :PlugInstall | :PlugUpgrade to update plugins.

" Make sure you use single quotes
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 2

Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.php,*.twig,*.js,*.jsx"

Plug 'altercation/vim-colors-solarized'

" pangloss/vim-javascript is optional
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" A pretty statusline, bufferline integration
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

" Git wrapper inside Vim, sign column in the gutter
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Git blame on current line in status bar
Plug 'zivyangll/git-blame.vim'
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
" TODO: Remove unsused plugins/shortcuts

" Plug 'vim-vdebug/vdebug', { 'on': 'VdebugStart' }
" TODO: I need a way to call ConfigVdebug() on load?
" or use option { 'for': 'php'} and add config in autocmd...

"Plug 'vim-syntastic/syntastic'
Plug 'dense-analysis/ale'
"Plug 'maximbaz/lightline-ale'

Plug 'prettier/vim-prettier'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

let g:prettier#config#single_quote = 'true'

" Is there anything lighter/better than this?
Plug 'lumiliet/vim-twig', { 'for': 'twig' }

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

" Syntastic
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_css_checkers = ['stylelint']
"let g:syntastic_php_checkers = ['php', 'phpcs']
"let g:syntastic_php_phpcs_args='--standard=Drupal'

" Vdebug
" function! ConfigVdebug()
"   let g:vdebug_options['break_on_open'] = 0
"   let g:vdebug_options['continuous_mode'] = 1
" endfunction

" command VdebugConfig call ConfigVdebug()

" Asynchronous Lint Engine
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1

"   ~always keep the signcolumn open!!
set signcolumn=yes
:highlight SignColumn ctermbg=black

" let g:ale_fixers = {
"       \ 'php': ['phpcbf'],
"       \ 'javascript': ['prettier'],
"       \ 'css': ['prettier'],
"       \}
" let g:ale_linters_explicit = 1

" Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 1

" let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --print-width 80'
" let g:ale_javascript_prettier_use_local_config = 1

" Enable completion where available.
let g:ale_completion_enabled = 1

" Drupal/Coder
let g:ale_php_phpcs_use_global = 1
let g:ale_php_phpcs_standard = 'Drupal'
let g:ale_php_phpcbf_use_global = 1
let g:ale_php_phpcbf_standard = 'Drupal'

" Additional filetypes
au BufRead,BufNewFile *.php,*.module,*.inc,*.install,*.theme set filetype=php
au BufRead,BufNewFile *.tpl set filetype=html
au BufRead,BufNewFile *.make set filetype=yaml

" " Indentation overrides
" au filetype json set tabstop=4
" au filetype json set shiftwidth=4
" TODO: Why is this here?

" Only do this part when compiled with support for autocommands.
" TODO: Which is always? The above should be in here, or condition removed.
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
  " au BufWritePost .vimrc so ~/.vimrc

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

" I'm not hiring him. He uses spaces not tabs.
set expandtab
set tabstop=2
set shiftwidth=2

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
" :map f :Fixup<CR>
" :map s :Squash<CR>
" :map r :Reword<CR>
" :map c :Pick<CR>
