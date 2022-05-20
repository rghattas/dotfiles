# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME=""

plugins+=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
fpath+=$HOME/.dotfiles/plugins/pure

autoload -U promptinit; promptinit
prompt pure

# User configuration

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
# From https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

eval $(thefuck --alias)

alias amend="git commit --amend --no-edit"

if [[ $(command -v spin) ]]; then
  source <(spin completion)
fi

# if $HOME/zsh_extras directory exists, source all files in $HOME/zsh_extras if any exist
if [[ -d $HOME/zsh_extras ]]; then
  # return early if no files exist
  if [[ ! "$(ls -A $HOME/zsh_extras)" ]]; then
    return
  fi
  for file in $HOME/zsh_extras/*.sh; do
    if [[ -f $file ]]; then
      source $file
    fi
  done
fi

if [[ $(command -v vim) ]]; then
  export EDITOR=vim
fi