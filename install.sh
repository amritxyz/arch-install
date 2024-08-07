cat << "EOF"


-----------------------------------------------------------------------
    _          _        _     ___
   /_\  _ _ __| |_    _| |_  |   \__ __ ___ __
  / _ \| '_/ _| ' \  |_   _| | |) \ V  V / '  \
 /_/ \_\_| \__|_||_|   |_|   |___/ \_/\_/|_|_|_|

-----------------------------------------------------------------------


EOF

# Install essential packages
sudo pacman -S brightnessctl xwallpaper htop lf xorg-xset xdotool alsa-utils ttf-font-awesome ttf-hack \
	ttf-hack-nerd noto-fonts-emoji picom fastfetch firefox nsxiv neovim mpv newsboat sxhkd bleachbit unzip \
	zathura zathura-pdf-poppler libxft libxinerama scrot arc-gtk-theme arc-icon-theme

# Clone dotfiles repository
git clone --depth=1 https://gitlab.com/amrit-44404/archrice $HOME/archrice

# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src

# Copy configuration files
cat << "EOF"

=> copying configs from dotfiles"

EOF
cp -r $HOME/archrice/.local/share/* $HOME/.local/share
\cp -r $HOME/archrice/.config/* $HOME/.config
\cp $HOME/archrice/.bashrc $HOME/.bashrc
\cp $HOME/archrice/.xinitrc $HOME/.xinitrc

# Clone walls
git clone --depth=1 https://gitlab.com/amrit-44404/void-wall $HOME/.local/share/void-wall

# Clone and build dwm environment
git clone --depth=1 https://gitlab.com/amrit-44404/arch-dwm $HOME/.local/src/arch-dwm

sudo make -C ~/.local/src/arch-dwm/dwm/ clean install
sudo make -C ~/.local/src/arch-dwm/dmenu/ clean install
sudo make -C ~/.local/src/arch-dwm/st/ clean install
sudo make -C ~/.local/src/arch-dwm/slstatus/ clean install
sudo make -C ~/.local/src/arch-dwm/slock/ clean install

cat << "EOF"

=> Installation completed successfully.

EOF

# End of script
