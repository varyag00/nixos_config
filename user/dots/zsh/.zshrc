echo "loading zshrc"


#!/bin/bash

# required by completions
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# NOTE: commented
#if [[ -r "${XDG_CAC#HE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

export SRC="/usr/local/src"
export WORK="$SRC/work"
export DOTSDIR="$HOME/.config"
export ZSH_PLUGINS="$ZDOTDIR/plugins"
export KUBECONFIG="$HOME/.kube/config"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
# bob nvim version manager
export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
# doom emacs
export PATH=$HOME/.emacs.d/bin:$PATH

if type "devbox" &> /dev/null; then
  eval "$(devbox global shellenv)"
  export DEVBOX_GLOBAL_PATH="$(devbox global path)/devbox.json"
fi

# Go Global variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# zshrc history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p $ZSH_CACHE_DIR/completions

if [ -e $ZDOTDIR/.p10k.zsh ]; then
	source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
fi

# NOTE: See https://github.com/catppuccin/zsh-syntax-highlighting
# tl;dr if present, it must be sourced before loading zsh-syntax-highlighting
# add a new `themes/selected_theme` dir and copy selected theme
if [ -e $ZSH_PLUGINS/catppuccin-zsh-syntax-highlighting.zsh ]; then
	source $ZSH_PLUGINS/catppuccin-zsh-syntax-highlighting.zsh
fi
if [ -e $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
	source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# fzf-tab
if [ -e $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh ]; then
	source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh
fi

plugins=(
git
vi-mode
command-not-found
sudo
zsh-autosuggestions
kubectx
kubectl
)
for plugin in $plugins; do
	source $ZSH_PLUGINS/$plugin*.zsh
done


if [ ! -z $INSIDE_EMACS ]; then
	# only run in emacs shells
  true
fi

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# NOTE: User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# NOTE: NOT VERSION CONTROLLED
# current workstation-specific configuration
if [ -e $HOME/pls-gitignore-wks.sh ]; then
	source $HOME/pls-gitignore-wks.sh
fi

# aliases
if [ -e $ZDOTDIR/aliases.sh ]; then
	source $ZDOTDIR/aliases.sh
fi

if [ -e $HOME/.profile ]; then
	source $HOME/.profile
fi

if [ -e $HOME/.ssh_hosts ]; then
	source $HOME/.ssh_hosts
fi


# fzf
if [ ! command -v fzf &> /dev/null ]; then
	echo "fzf is not installed, see bootstrap.sh"
	exit
else
	# fzf
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

	[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
	[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

  # custom extensions
	[ -f $ZDOTDIR/fzf-custom.zsh ] && source $ZDOTDIR/fzf-custom.zsh
fi

# WSL2 XServer

#export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
#export DISPLAY=192.168.1.201:0

# last working DISPLAY
#export DISPLAY=$(ip route | awk '{print $3; exit}'):0

# from https://www.youtube.com/watch?v=YxQMDBnrMws
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# 4/26/2021 - testing removing this to see if UI scaling is improved emacs
#export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
#export GDK_SCALE=2

# some other options
# export GDK_SCALE=0.5
# export GDK_DPI_SCALE=2

# fix wsl2 interop, allowing emacs to launch windows programs
fix_wsl2_interop() {
	for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
		if [[ -e "/run/WSL/${i}_interop" ]]; then
			export WSL_INTEROP=/run/WSL/${i}_interop
		fi
	done
}

# ~/.emacs.d/bin/doom env > /dev/null 2>&1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
POWERLEVEL9K_INSTANT_PROMPT=quiet

export PNPM_HOME="/home/dan/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# NOTE: fzf-tab completions config
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with lsd when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# ctrl- arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
