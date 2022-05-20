#!/bin/bash

echo "Installing oh my zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Configuring zsh..."
mv $HOME/.zshrc $HOME/.zshrc_backup
ln -s $PWD/.zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Install Pure theme..."
git clone https://github.com/sindresorhus/pure.git "$HOME/.dotfiles/plugins/pure"

echo "Linking gitconfig..."
rm -rf $HOME/.gitconfig
ln -s $PWD/.gitconfig $HOME/.gitconfig

echo "Installing tools..."

if ! command -v thefuck &> /dev/null; then
  echo "Installing thefuck via pip3..."
  sudo pip3 install thefuck
fi

echo "Installing spin specific tools..."
if [ $SPIN ]; then
  echo "Ensure dirmngr daemon is started..."
  gpgconf --launch dirmngr
  echo "Configure gpg keys..."
  gpg --keyserver keys.openpgp.org --recv 22509CFFD8AEA2F404589F301105B38A086E6447
fi