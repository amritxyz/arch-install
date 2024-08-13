cat << "EOF"


-----------------------------------------------------------------------
    _          _        _     ___
   /_\  _ _ __| |_    _| |_  |   \__ __ ___ __
  / _ \| '_/ _| ' \  |_   _| | |) \ V  V / '  \
 /_/ \_\_| \__|_||_|   |_|   |___/ \_/\_/|_|_|_|

-----------------------------------------------------------------------


EOF

# Install essential packages
sudo pacman -S brightnessctl xwallpaper htop lf xorg-xset xdotool alsa-utils \
	ttf-font-awesome ttf-hack ttf-hack-nerd noto-fonts-emoji xcompmgr fastfetch \
	firefox nsxiv neovim mpv newsboat bleachbit unzip zathura zathura-pdf-poppler \
	libxft libxinerama scrot xf86-video-intel bluez bluez-utils

# Clone dotfiles repository
git clone --depth=1 https://gitlab.com/amrit-44404/archrice $HOME/archrice

# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src $HOME/.local/bin $HOME/.local/hugo-dir

# Copy configuration files
cat << "EOF"

=> copying configs from dotfiles"

EOF
cp -r $HOME/archrice/.local/share/* $HOME/.local/share
\cp $HOME/archrice/.local/bin/* $HOME/.local/bin
\cp -r $HOME/archrice/.config/* $HOME/.config
\cp $HOME/archrice/.bashrc $HOME/.bashrc
\cp $HOME/archrice/.inputrc $HOME/.inputrc
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

# Tearfree screen config
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/20-intel.conf /etc/X11/xorg.conf.d/

# Clean home directory
mkdir -p $HOME/.local/git-repos
mv $HOME/archrice $HOME/.local/git-repos
mv $HOME/arch-install $HOME/.local/git-repos

cat << "EOF"

=> Installation completed successfully.

EOF

# End of script
