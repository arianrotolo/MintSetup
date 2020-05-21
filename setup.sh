#!/usr/bin/env bash

fullinstallation="false";
if [[ $1 = "-f" ]] || [[ $1 = "--full" ]]; then
    fullinstallation="true";
    echo "Full installation selected."
elif [[ $2 = "-f" ]] || [[ $2 = "--full" ]]; then
    fullinstallation="true";
    echo "Full installation selected."
else
    echo "Normal (not full) installation will proceed by default."
fi

# upstream-lsb gets ubuntu release codename
alias upstream-lsb="grep DISTRIB_CODENAME /etc/upstream-release/lsb-release | grep -o --colour=never \"[a-z-]*$\""

# updating
sudo apt full-upgrade -y
sudo apt update -y
sudo apt upgrade -y

# install system utilities
sudo apt install -y build-essential
sudo apt install -y software-properties-common
sudo apt install -y curl
sudo apt install -y apt-transport-https
sudo apt install -y openssl libssl-dev
sudo apt install -y openssh-server
sudo apt install -y checkinstall
sudo apt install -y 7zip unrar zip unzip
sudo apt install -y synaptic gdebi
sudo apt install -y cmake
sudo apt install -y alien
sudo apt install -y tree

# install python tools
sudo apt install -y python3 python-dev python3-dev 
sudo apt install -y python3-setuptools python3-distutils python3-pyqt5
sudo apt install -y libffi-dev libxml2-dev libxslt1-dev zlib1g-dev      #librerias necesarias para compilar ultimo Python
sudo apt install -y python3-tk python-pytest 
sudo apt install -y python-matplotlib python3-matplotlib

# install pip
sudo apt install -y python-pip python3-pip
sudo pip install --upgrade pip

# install pip packages
sudo pip install setuptools wheel
sudo pip install virtualenv 
sudo pip install grip
sudo pip install numpy

# install firewall
sudo apt install -y ufw gufw
sudo ufw enable

# install git
sudo apt install -y git
git config --global user.name "kilianpolkov"
git config --global user.email "kilianpolkov@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# install neofetch
sudo apt install -y neofetch

# install htop
sudo apt install -y htop

# install putty
sudo apt install -y putty
sudo apt install -y putty-tools

# install filezilla
sudo apt install -y filezilla

# install VLC
sudo apt install -y vlc

# install lm-sensors
sudo apt install -y lm-sensors

# install gtkhash checksum
sudo apt install -y gtkhash

# install seahorse passwords
sudo apt install -y gnupg
sudo apt install -y seahorse

# install neovim
#sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update -y
sudo apt install -y neovim

# install vscode
#curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
#sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
#sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update -y
sudo apt install -y code

# install spotify (checked)
#curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
#echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# install Chrome (checked)
#wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update -y
sudo apt install -y google-chrome-stable

# install zsh shell
sudo apt install -y zsh
sudo chsh -s $(which zsh)

<<'COMMENT'
if [ $fullinstallation == "true" ]; then
    
    # LAMP (Linux, Apache, MySQL, PHP)
    sudo apt install apache2 php libapache2-mod-php phpmyadmin php-mysql mysql-server
    
    # Texmaker LaTeX editor
    sudo apt install -y texmaker 
    
    # install Spyder IDE for scientifics
    sudo apt install -y spyder spyder3
    
    # Gradle
    sudo apt install -y gradle
    
    # Maven
    sudo apt install -y maven
    
    # OpenGL API, Mesa Off-screen rendering extension, and stuff for [mujoco-py](https://github.com/openai/mujoco-py#install-mujoco)
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf

fi
COMMENT

#updating
sudo apt dist-upgrade -y
sudo apt update -y
sudo apt upgrade -y

#unistalling
echo "Comenzando desinstalacion programas que no utilizo..."
sudo apt remove -y  pidgin
sudo apt remove -y  hexchat
sudo apt remove -y  rhythmbox
sudo apt remove -y  mopidy
sudo apt remove -y  xplayer
sudo apt purge -y pidgin
sudo apt purge -y hexchat
sudo apt purge -y rhythmbox
sudo apt purge -y mopidy
sudo apt purge -y xplayer

#cleaning
echo "Comenzando limpieza de basura..."
sudo apt autoremove -y
sudo apt clean -y all
rm -rf ~/.cache/thumbnails/*
sudo du -sh /var/cache/apt

#updating
sudo apt update -y
sudo apt upgrade -y

echo $'\n'$"*** Finalizado. Reinicia el sistema! ***"
