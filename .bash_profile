PROMPT_DIRTRIM=2
PS1="[\u@\h \w]$ "
cd /mu2e/app/users/roneil/
LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
#if [ -z "$SSH_AUTH_SOCK" ] ; then
#  eval `ssh-agent -s`
#  ssh-add
#fi
SSH_ENV="$HOME/.ssh/environment"

function start_agent 
{
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

MANPATH=~/local/share/man:$MANPATH
PATH=~/local/bin/:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/local/lib

alias scone='scons'
alias tmux='LD_LIBRARY_PATH=$HOME/local/lib $HOME/local/bin/tmux'

EDITOR=vim
PATH=$PATH:~/.local/bin
TERM=xterm-256color

powerline-daemon -q

if [ ! -z "$TMUX" ]; then
powerline-config tmux setup
echo "Setting up tmux powerline..."

fi

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

. ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

source /cvmfs/fermilab.opensciencegrid.org/products/common/etc/setups
