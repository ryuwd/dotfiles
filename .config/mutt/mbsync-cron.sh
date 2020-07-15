#!/bin/zsh
export DISPLAY=:0.0

source $HOME/.config/mutt/tagging.sh && sync_and_tag $1
