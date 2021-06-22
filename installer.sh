#!/bin/sh

# shellcheck disable=SC2086

echo "Installing Dependencies and settings fonts and folders"

sudo xbps-install -Su xdg-utils xdg-user-dirs
xdg-user-dirs-update

echo "Entering Downloads direcotory"

cd ~/Downloads || exit

sudo xbps-install -Su libX11-devel lm_sensors libXinerama-devel suckless-tools libXft-devel xwallpaper wget curl zip unzip firefox starship zsh zsh-syntax-highlighting zsh-autosuggestion && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip && unzip JetBrainsMono.zip && mkdir -p $HOME/.local/share/fonts/JetBrainsMono && mv -- *.ttf $HOME/.local/share/fonts/JetBrainsMono && fc-cache -f -v

echo "Setting zsh shell"

chsh $USER
zdot=~/.config/zsh
wget https://raw.githubusercontent.com/ashincoder/dotfiles/master/.zshenv
mkdir -p $zdot
cd $zdot || exit
wget https://raw.githubusercontent.com/ashincoder/dotfiles/master/.config/zsh/.zshrc

echo "Setting up directories"

mkdir -p $HOME/.local/bin
scripts=~/.local/bin/

mkdir -p $HOME/.local/share/dwm
autostart=~/.local/share/dwm

echo "downloading autostart script"

cd $autostart || exit
wget https://raw.githubusercontent.com/ashincoder/dotfiles/master/.local/share/dwm/autostart.sh
chmod +x autostart.sh
cd || exit

echo "Cloning Builds and Scripts"
cd $scripts || exit
git clone https://github.com/ashincoder/scripts.git .
rm -rf .git

config=~/.config/suckless
cd $config || exit

echo "Compiling Dwm"
git clone https://github.com/ashincoder/dwm-ashin.git
cd dwm-ashin || exit
sudo make clean install
cd ..

echo "Compiling St"
git clone https://github.com/ashincoder/st-ashin.git
cd st-ashin || exit
sudo make clean install
cd ..

echo "Compiling Dmenu"
git clone https://github.com/ashincoder/dmenu-ashin.git
cd dmenu-ashin || exit
sudo make clean install
cd || exit
