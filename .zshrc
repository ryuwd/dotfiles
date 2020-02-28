# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/ryuwd/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
#
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	exec startx
#fi
#

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
. /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
#powerline-daemon -q
#. /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
#
export PATH=/home/ryuwd/.local/bin:$PATH
export CLION_JDK=/opt/intellij-idea-ce/jbr/

alias mu2egpvm01='ssh -AK -l roneil mu2egpvm01.fnal.gov'
alias mu2egpvm_sshfs='mkdir -p ~/mu2egpvm01/ && sshfs roneil@mu2egpvm01.fnal.gov:/mu2e/app/users/roneil/ ~/mu2egpvm01'
alias mu2egpvm_socks='ssh -D 8383 -AK -l roneil mu2egpvm01.fnal.gov'
alias please='sudo'
