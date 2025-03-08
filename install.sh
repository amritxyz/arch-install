cat << "EOF"

/****************************************************************
 *								*
 *		ARCH LINUX INSTALLATION SCRIPT			*
 *								*
 ****************************************************************
 */

EOF

# Cleanup first
sudo rm -rf $HOME/.[!.]*

# Disable Wifi-Power Saver
read -rep ':: Would you like to disable wifi powersave? [Y/n] ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" || -z $WIFI ]]; then
	LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
	echo -e "The following has been added to $LOC.\n"
	echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
	echo -e "\n"
	echo -e "Restarting NetworkManager service...\n"
	sudo systemctl restart NetworkManager
	sleep 3
fi

# read -rep ':: Would you like to enable "ParallelDownloads = 3" [Y/n] ' WIFI
# if [[ $WIFI == "Y" || $WIFI == "y" || -z $WIFI ]]; then
# 	sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 3/" /etc/pacman.conf
# fi

### Install all of the imp pacakges ####
read -rep 'Would you like to install the packages? [Y/n] ' INST
if [[ $INST == "Y" || $INST == "y" || -z $INST ]]; then
	sudo pacman -S xwallpaper xorg-xset xorg-xrandr xdotool libxinerama libxft xclip brightnessctl \
		htop lf pulsemixer ttf-font-awesome ttf-hack ttf-hack-nerd noto-fonts-emoji \
		picom git-lfs ffmpeg fastfetch firefox nsxiv neovim mpv newsboat bleachbit unzip \
		zathura zathura-pdf-poppler scrot man-db tmux bc fzf curl cmatrix imagemagick \
		ripgrep hugo adwaita-icon-theme bluez bluez-utils gimp wget deluge-gtk \
		rust-analyzer go jdk21-openjdk clang pyright nodejs npm maven
fi
# mesa vulkan-intel intel-media-driver \
# libva-intel-driver.xcompmgr
# obs-studio transmission-cli
# sudo pacman -Sy --needed base-devel && \
# xorg-xinit xorg-xmodmap
# zed xdg-desktop-portal-gtk xdg-desktop-portal-lxqt
# vulkan-intel bluez bluez-utils
# xorg-setxkbmap

# Clone dotfiles repository
git clone --depth=1 https://github.com/amritxyz/archrice.git/ $HOME/archrice

# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src $HOME/.local/bin $HOME/.local/hugo-dir $HOME/.local/dox $HOME/.local/vids $HOME/.local/music $HOME/.local/audio

# Copy configuration files
cat <<"EOF"

/****************************************************
 *						    *
 *		CONFIGURING DOTFILES		    *
 *						    *
 ****************************************************
 */

EOF

cp -r $HOME/archrice/.local/share/* $HOME/.local/share
cp $HOME/archrice/.local/bin/* $HOME/.local/bin
cp -r $HOME/archrice/.config/* $HOME/.config
cp $HOME/archrice/.bashrc $HOME/.bashrc
cp $HOME/archrice/.bash_profile $HOME/.bash_profile
cp $HOME/archrice/.inputrc $HOME/.inputrc
cp $HOME/archrice/.xinitrc $HOME/.xinitrc

# NeoVim
git clone --depth=1 https://github.com/amritxyz/kickstart-nvim.git $HOME/.config/nvim

# Dev
git clone --depth=1 https://github.com/amritxyz/dev.git/ $HOME/.local/dev

# Clone walls
git clone --depth=1 https://github.com/amritxyz/void-wall.git/ $HOME/.local/share/void-wall

cat << "EOF"

/************************************************************
 *							    *
 *		INSTALLING SUCKLESS SOFTWARE		    *
 *							    *
 ************************************************************
 */

EOF

# Clone and build dwm environment
git clone --depth=1 https://github.com/amritxyz/arch-dwm.git/ $HOME/.local/src/arch-dwm

sudo make -C $HOME/.local/src/arch-dwm/dwm/ clean install
sudo make -C $HOME/.local/src/arch-dwm/dmenu/ clean install
sudo make -C $HOME/.local/src/arch-dwm/st/ clean install
sudo make -C $HOME/.local/src/arch-dwm/slstatus/ clean install
sudo make -C $HOME/.local/src/arch-dwm/slock/ clean install

# Better performance
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/10-modesetting.conf /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/40-libinput.conf /etc/X11/xorg.conf.d/
sudo cp $HOME/archrice/.local/share/hosts /etc/hosts

# Clean home directory
mkdir -p $HOME/.local/git-repos
mv $HOME/archrice $HOME/.local/git-repos
mv $HOME/arch-install $HOME/.local/git-repos

# Bluetooth services
sudo systemctl enable bluetooth.service

sudo rm -rf $HOME/.cache
mkdir -p $HOME/.cache
sudo chown void:void $HOME/.cache

cat << "EOF"

/********************************************************
 *							*
 *		SUCCESSFULLY CONFIGURED			*
 *							*
 ********************************************************
 */

EOF

sleep 3
reboot

# End of script
