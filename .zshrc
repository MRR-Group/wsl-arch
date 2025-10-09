# ─── Oh My Zsh setup ────────────────────────────────────────────────
export ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  docker
  sudo
  command-not-found
  z
)

source $ZSH/oh-my-zsh.sh

# ─── Prompt ─────────────────────────────────────────────────────────
# Minimal Powerlevel10k theme config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─── Aliases ────────────────────────────────────────────────────────
alias ll="ls -alF --color=auto"
alias la="ls -A"
alias l="ls -CF"
alias dc="docker compose"
alias ..="cd .."

# ─── Quality of life ────────────────────────────────────────────────
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
HISTSIZE=5000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# ─── Fast directory jumping ─────────────────────────────────────────
. /usr/share/zsh/plugins/z/z.sh 2>/dev/null || true

# ─── Colors & LS_COLORS ─────────────────────────────────────────────
autoload -U colors && colors
export LS_COLORS='di=1;34:ln=36:so=35:pi=33:ex=1;32:bd=1;33:cd=1;33:su=37;41:sg=30;43:tw=30;42:ow=34;42'

# ─── Greeting ───────────────────────────────────────────────────────
echo -e "\e[0;36mWelcome to MMR Arch, $USER\e[0m"
