# dotfiles
Config files for vim, zsh, bash, etc

## Install

```bash
alias dotfiles='git --git-dir=$HOME/.dfcfg/ --work-tree=$HOME'

git clone --bare git@github.com:ryuwd/dotfiles $HOME/.dfcfg
dotfiles checkout

dotfiles submodule update --init
```


