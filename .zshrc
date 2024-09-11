# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode disabled  # disable automatic updates

plugins=(
	git
    history
	zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# load the user specific config if available
if [ -e ~/.zshrc_extra ]
then
    source ~/.zshrc_extra
fi

# vim
alias v="vim"

# kubectl
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias klf="kubectl logs -f"
alias kdn="kubectl describe nodes"
alias kdp="kubectl describe pods"

# kubectl autocomplete
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias f="fzf"
alias fv='vim "$(fzf)"'

if command -v fd &> /dev/null
then
    # setting fd as the default source for fzf if fd exists
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

PREVIEW_NAVIGATION_BIND=" \
--bind 'ctrl-p:preview-up,ctrl-n:preview-down' \
--bind 'ctrl-b:preview-page-up,ctrl-f:preview-page-down' \
--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' \
--bind 'ctrl-y:preview-top,ctrl-e:preview-bottom'"

export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}' ${PREVIEW_NAVIGATION_BIND}"

export FZF_CTRL_R_OPTS="
  --preview 'echo {2..} | bat --color=always -pl sh'
  --preview-window up:5:hidden:wrap
  --bind 'ctrl-v:toggle-preview'
  ${PREVIEW_NAVIGATION_BIND}"

export FZF_ALT_C_OPTS=${FZF_CTRL_R_OPTS}

# git
git config --global core.editor "vim"
git config --global diff.mnemonicPrefix true

# eza
if command -v eza &> /dev/null
then
    # using eza instead of ls if eza exists
    alias ls='eza'
    alias l='eza -lbF'
    alias ld='eza -lD'
    alias lf='eza -lf --color=always | grep -v /'
    alias ll='eza -al --group-directories-first'
    alias lt='eza -al --sort=modified'
fi

# bat
alias bd="git diff --name-only --relative --diff-filter=d | xargs bat --diff"

