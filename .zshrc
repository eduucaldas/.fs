export ZSH=$HOME/.oh-my-zsh
export FZF_BASE=$(where fzf)

ZSH_THEME="risto"

# Not show update prompt
DISABLE_UPDATE_PROMPT=true

# History management:
## Addition of the history file
setopt APPEND_HISTORY

## Ignore all repetitions of commands
setopt HIST_IGNORE_ALL_DUPS

## Do not display the string found earlier
setopt HIST_FIND_NO_DUPS

## Ignore rows if they are duplicates
setopt HIST_IGNORE_DUPS

## Delete empty lines from history file
setopt HIST_REDUCE_BLANKS

## Ignore a record starting with a space
setopt HIST_IGNORE_SPACE

## Do not add history and fc commands to the history
setopt HIST_NO_STORE

plugins=(
  git
  fzf
  fasd
)

source $ZSH/oh-my-zsh.sh

eval "$(fasd --init posix-alias zsh-hook)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Aliases
alias xo="xdg-open"
alias vim="nvim"

