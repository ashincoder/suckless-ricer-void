#!/bin/sh

# shellcheck disable=SC2086

echo "Installing Dependencies and folders"

sudo xbps-install -Su xdg-utils xdg-user-dirs
xdg-user-dirs-update

sudo xbps-install -S zathura zathura-pdf-mupdf exa bat dust xrandr libX11-devel libXinerama-devel python3 python3-pip libXft-devel xwallpaper wget curl zip unzip firefox starship zsh zsh-syntax-highlighting zsh-autosuggestions cmake

echo "Setting fonts"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
mkdir -p $HOME/.local/share/fonts/JetBrainsMono && mv -- *.ttf $HOME/.local/share/fonts/JetBrainsMono
echo "Font cache"
fc-cache -f -v
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
sudo xbps-reconfigure -f fontconfig

echo "Setting zsh shell"

chsh $USER
cd || exit
zdot=~/.config/zsh/
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
sleep 5
cd dwm-ashin || exit
sudo make clean install
cd ..

echo "Compiling St"
git clone https://github.com/ashincoder/st-ashin.git
sleep 5
cd st-ashin || exit
sudo make clean install
cd ..

echo "Compiling Dmenu"
git clone https://github.com/ashincoder/dmenu-ashin.git
sleep 5
cd dmenu-ashin || exit
sudo make clean install
cd .. || exit

echo "Compiling Slstatus"
git clone https://github.com/ashincoder/slstatus-ashin.git
sleep 5
cd slstatus-ashin || exit
sudo make clean install
cd .. || exit

echo "Compiling Sxiv"
git clone https://github.com/ashincoder/sxiv-ashin.git
sleep 5
cd sxiv-ashin || exit
sudo make clean install
cd || exit

echo "Downloading Wallpapers"

cd /usr/share/backgrounds/ || exit
sudo wget https://raw.githubusercontent.com/ashincoder/wallpapers/main/neon.png
sudo wget https://raw.githubusercontent.com/ashincoder/wallpapers/main/0023.jpg
mv 0023.jpg nature.jpg
sleep 5

echo "Neovim installation"
cd ~/Downloads || exit
git clone https://github.com/neovim/neovim.git
sleep 4
cd neovim || exit
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
sleep 5
cd .. || exit
git clone https://github.com/ashincoder/AshVim
sleep 5
cd AshVim || exit
./install.sh
