# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=10000
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jeremiah.dow/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

fpath=( "$HOME/.zsh" $fpath )
export LC_COLLATE="POSIX"

# case insensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# color setup for ls on OS X / FreeBSD:
export CLICOLOR=1
# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

## pager
export PAGER='less'
export LESS='-R'

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search

# start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

bindkey '^?' backward-delete-char       # [Backspace] - delete backward
bindkey '^h' backward-delete-char
bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward

# sindresorhus/pure
autoload -U promptinit; promptinit

# optionally define some options
PURE_PROMPT_SYMBOL='$'

prompt pure

alias vim='nvim'
alias python='python3'

# Enable Autocomplete for Drupal Console
source "$HOME/.console/console.rc" 2>/dev/null

export PATH="$PATH:$HOME/.composer/vendor/bin"
export XDEBUG_CONFIG="idekey=xdebug"
