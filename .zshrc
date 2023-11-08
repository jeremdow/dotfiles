# zmodload zsh/zprof

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=10000
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/jeremiah.dow/.zshrc'
# End of lines added by compinstall

# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C

fpath=( "$HOME/.zsh" $fpath )
export LC_COLLATE="POSIX"

# case insensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
#setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# color setup for ls on OS X / FreeBSD:
export CLICOLOR=1
# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# For my own and others sanity
# %F => color dict
# %f => reset color %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
PROMPT='%F{blue}%~%f %# '

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

alias vim='nvim'
alias python='python3'

# Prompt for password on terminal when code signing
export GPG_TTY=$(tty)

# # Enable Autocomplete for Drupal Console
# source "$HOME/.console/console.rc" 2>/dev/null
# export PATH="$PATH:$HOME/.composer/vendor/bin"

# Acquia BLT
function blt() {
  if [[ ! -z ${AH_SITE_ENVIRONMENT} ]]; then
    PROJECT_ROOT="/var/www/html/${AH_SITE_GROUP}.${AH_SITE_ENVIRONMENT}"
  elif [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    PROJECT_ROOT=$(git rev-parse --show-cdup)
  else
    PROJECT_ROOT="."
  fi

  if [ -f "$PROJECT_ROOT/vendor/bin/blt" ]; then
    $PROJECT_ROOT/vendor/bin/blt "$@"

  # Check for local BLT.
  elif [ -f "./vendor/bin/blt" ]; then
    ./vendor/bin/blt "$@"

  else
    echo "You must run this command from within a BLT-generated project."
    return 1
  fi
}

# # Add every binary that requires nvm, npm or node to run to an array of node globals
# NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")

# # Lazy-loading nvm + npm on node globals call
# load_nvm () {
#   export NVM_DIR=~/.nvm
#   [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
# }

# # Making node global trigger the lazy loading
# for cmd in "${NODE_GLOBALS[@]}"; do
#   eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
# done

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Use Aliases instead of NVM
# https://notiz.dev/blog/how-to-manage-multiple-node-versions-on-mac
alias node14='export PATH="/usr/local/opt/node@14/bin:$PATH"'
alias node16='export PATH="/usr/local/opt/node@16/bin:$PATH"'

# https://getcomposer.org/doc/articles/troubleshooting.md#memory-limit-errors
export COMPOSER_MEMORY_LIMIT=-1

# This doesn't really work well.... check the version on the repo?
# function vault-login {
#   unset VAULT_ADDR
#   kill -9 $(ps aux | grep 'port-forward service/vault' | grep -v 'grep' | awk '{print $2}') || true
#   kubectl port-forward service/vault 8200:8202 >/dev/null &
#   export VAULT_SKIP_VERIFY=true
#   vault login -method=github token=$GITHUB_TOKEN
# }

export GITHUB_TOKEN=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

export VAULT_GITHUB_TOKEN=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
export VAULT_SKIP_VERIFY=true
export AWS_REGION=us-east-1

function login-vault {
    unset VAULT_ADDR; export VAULT_ADDR=https://vault.nonprod.pfx-nonprod.com;
    vault login -header=user-agent=pfx-vault -method=oidc token=$VAULT_GITHUB_TOKEN
}

function login-aws {
    local EKS_NAME=$1
    local IS_OPERATOR=$2

    local VAULT_ROLE="kubernetes"
    [[ "$IS_OPERATOR" = true ]] && VAULT_ROLE="kubernetes-operator";

    AWS_CREDS=$(vault read -header=user-agent=pfx-vault -format=json "${EKS_NAME}/creds/${VAULT_ROLE}")

    AWS_ACCESS_KEY_ID=$(echo $AWS_CREDS | jq -r '.data.access_key // empty');
    AWS_SECRET_ACCESS_KEY=$(echo $AWS_CREDS | jq -r '.data.secret_key // empty');
    AWS_SESSION_TOKEN=$(echo $AWS_CREDS | jq -r '.data.security_token // empty');

    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set region $AWS_REGION

    # Session token does not exists for every aws login type, so configure it only if it exists
    if [[ ! -z $AWS_SESSION_TOKEN ]]
    then
        aws configure set aws_session_token $AWS_SESSION_TOKEN
    fi

    # Remove env vars to prevent conflict with aws profile
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN;
}

function login-eks {
    local EKS_NAME=$1
    local IS_OPERATOR=$2

    login-vault
    login-aws $EKS_NAME $IS_OPERATOR

    aws eks update-kubeconfig --name "$EKS_NAME" --alias "$EKS_NAME"

    # unset public vault address to access private vault
    unset VAULT_ADDR
}

# Aliases
# Developer
alias nonprod_eks_developer='login-eks nonprod'
alias prod_eks_developer='login-eks prod'
alias cde_nonprod_eks_developer='login-eks nonprod-cde'
alias cde_prod_eks_developer='login-eks prod-cde'

# Operator
alias nonprod_eks_operator='login-eks nonprod true'
alias prod_eks_operator='login-eks prod true'
alias cde_nonprod_eks_operator='login-eks nonprod-cde true'
alias cde_prod_eks_operator='login-eks prod-cde true'

# function eks-developer {
#     if [[ -z $1 ]]; then
#         echo "Env is missing"
#         echo "Usage example: eks-developer <nonprod|prod>"
#         return 1
#     fi
#     developer eks $1
# }

# function cde-developer {
#     if [[ -z $1 ]]; then
#         echo "Env is missing"
#         echo "Usage example: cde-developer <nonprod|prod>"
#         return 1
#     fi
#     developer cde $1
# }

# function developer {
#     if [[ -z $1 ]] || [[ -z $2 ]]; then
#         echo "One or more parameters are missing"
#         echo "Usage example: developer <eks|cde> <nonprod|prod>"
#         return 1
#     fi
#     export VAULT_ADDR=https://vault.nonprod.pfx-nonprod.com
#     vault login -method=oidc
#     if [[ "$1" = "eks" ]]; then
#         eval "$(kubernetes-creds $2)"
#         aws eks update-kubeconfig --region us-east-1 --name "$2" --alias "$2"
#     fi
#     if [[ "$1" = "cde" ]]; then
#         eval "$(kubernetes-creds $2-cde)"
#         aws eks update-kubeconfig --region us-east-1 --name "$2-cde" --alias "$2-cde"
#     fi
#     unset VAULT_ADDR
# }

# function kubernetes-creds {
#   local environment=${1}
#   vault read -format=json ${environment}/creds/kubernetes \
#     | jq '.data.access_key, .data.secret_key, .data.security_token' -r \
#     | paste -d '=' <(echo -en "AWS_ACCESS_KEY_ID\nAWS_SECRET_ACCESS_KEY\nAWS_SESSION_TOKEN\n") - \
#     | sed -e 's/^/export /' \
#     | sed -e 's/$/;/'
# }

export PATH="/user/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH="$PATH:/usr/local/opt/node@14/bin"

# zprof
