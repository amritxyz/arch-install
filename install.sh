cat <<"EOF"
#################################################
    _          _        _     ___
   /_\  _ _ __| |_    _| |_  |   \__ __ ___ __
  / _ \| '_/ _| ' \  |_   _| | |) \ V  V / '  \
 /_/ \_\_| \__|_||_|   |_|   |___/ \_/\_/|_|_|_|

#################################################
EOF

# Disable Wifi-Power Saver
read -rep 'Would you like to disable wifi powersave? (Y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" || -z $WIFI ]]; then
	LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
	echo -e "The following has been added to $LOC.\n"
	echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
	echo -e "\n"
	echo -e "Restarting NetworkManager service...\n"
	sudo systemctl restart NetworkManager
	sleep 3
fi

sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 5/" /etc/pacman.conf

### Install all of the imp pacakges ####
read -rep 'Would you like to install the packages? (Y,n)' INST
if [[ $INST == "Y" || $INST == "y" || -z $INST ]]; then
	sudo pacman -S xorg-xbacklight xwallpaper xorg-xset xdotool libxinerama libxft xclip \
		htop lf pulsemixer ttf-font-awesome ttf-hack ttf-hack-nerd noto-fonts-emoji \
		xcompmgr fastfetch firefox nsxiv neovim mpv newsboat bleachbit unzip \
		xf86-video-intel zathura zathura-pdf-poppler scrot man-db tmux bc rust go \
		ripgrep hugo adwaita-icon-theme bluez bluez-utils gimp wget transmission-cli
fi
# gimp obs-studio
# sudo pacman -Sy --needed base-devel && \
# xorg-xinit xorg-xmodmap
# zed xdg-desktop-portal-gtk xdg-desktop-portal-lxqt
# vulkan-intel bluez bluez-utils
# xorg-setxkbmap

# Clone dotfiles repository
git clone --depth=1 https://gitlab.com/NyxVoid/archrice.git/ $HOME/archrice

# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src $HOME/.local/bin $HOME/.local/hugo-dir $HOME/.local/dox $HOME/.local/vids

# Copy configuration files
cat <<"EOF"

=> copying configs from dotfiles"

EOF
cp -r $HOME/archrice/.local/share/* $HOME/.local/share
cp $HOME/archrice/.local/bin/* $HOME/.local/bin
cp -r $HOME/archrice/.config/* $HOME/.config
cp $HOME/archrice/.bashrc $HOME/.bashrc
cp $HOME/archrice/.inputrc $HOME/.inputrc
cp $HOME/archrice/.xinitrc $HOME/.xinitrc

# NeoVim
git clone --depth=1 https://gitlab.com/NyxVoid/nvim.git $HOME/.config/nvim

# Dev
git clone --depth=1 https://gitlab.com/NyxVoid/dev.git/ $HOME/.local/dev

# Clone walls
git clone --depth=1 https://gitlab.com/NyxVoid/void-wall.git/ $HOME/.local/share/void-wall

# Clone and build dwm environment
git clone --depth=1 https://gitlab.com/NyxVoid/arch-dwm.git/ $HOME/.local/src/arch-dwm

sudo make -C ~/.local/src/arch-dwm/dwm/ clean install
sudo make -C ~/.local/src/arch-dwm/dmenu/ clean install
sudo make -C ~/.local/src/arch-dwm/st/ clean install
sudo make -C ~/.local/src/arch-dwm/slstatus/ clean install
sudo make -C ~/.local/src/arch-dwm/slock/ clean install

# Better performance
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/20-intel.conf /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/hosts /etc/hosts

# Clean home directory
mkdir -p $HOME/.local/git-repos
mv $HOME/archrice $HOME/.local/git-repos
mv $HOME/arch-install $HOME/.local/git-repos

# Bluetooth services
sudo systemctl enable bluetooth.service

cat <<"EOF"
####################################
Installation completed successfully.
####################################
EOF

sleep 3
reboot

# End of script
