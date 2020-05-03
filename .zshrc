export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="risto"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  git
  fzf
  fasd
)

source $ZSH/oh-my-zsh.sh

export FZF_BASE=$(where fzf)

eval "$(fasd --init posix-alias zsh-hook)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig="nano ~/.zshrc"
alias xo="xdg-open"
alias vim="nvim"

# OPAM configuration
. /home/eduucaldas/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias config='/usr/bin/git --git-dir=/home/eduucaldas/.cfg/ --work-tree=/home/eduucaldas'
