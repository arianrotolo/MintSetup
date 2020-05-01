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

#upstream-lsb gets ubuntu release codename
alias upstream-lsb="grep DISTRIB_CODENAME /etc/upstream-release/lsb-release | grep -o --colour=never \"[a-z-]*$\""

#updating
sudo apt dist-upgrade -y
sudo apt update -y
sudo apt upgrade -y

#install pip
#sudo apt install -y python-pip
#sudo apt install -y python3-pip
#sudo pip install --upgrade pip

#install a bunch of "essentials" for python3
#sudo apt install -y python3 python-dev python3-dev python3-distutils python3-pyqt5 build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
#sudo python3 -m pip install setuptools wheel

#install system utilities
sudo apt install -y curl
sudo apt install -y apt-transport-https

#install G++
sudo apt install -y g++

#install cmake
sudo apt install -y cmake

#install git
sudo apt install -y git
git config --global user.name "kilianpolkov"
git config --global user.email "kilianpolkov@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

#install htop
sudo apt install -y htop

#install putty
sudo apt install -y putty
sudo apt install -y putty-tools

#install filezilla
sudo apt install -y filezilla

#install VLC
sudo apt install -y vlc

#install neofetch
sudo apt install -y neofetch

#install lm-sensors
sudo apt install -y lm-sensors

#install gtkhash decrypt sha256
sudo apt install -y gtkhash

#install seahorse passwords
sudo apt install -y seahorse

#install spotify
#sudo apt install -y spotify-client

#install Chrome
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
#sudo apt update -y
#sudo apt install -y google-chrome-stable

<<'COMMENT'
if [ $fullinstallation == "true" ]; then

    # VirtualEnv
    sudo pip install virtualenv

    # pytest and matplotlib and python-tk
    sudo apt install -y python3-tk python-pytest python-matplotlib python3-matplotlib

    #install Spyder
    sudo apt install -y spyder
    sudo apt install -y spyder3

    # OpenGL API, Mesa Off-screen rendering extension, and other fun stuff for [mujoco-py](https://github.com/openai/mujoco-py#install-mujoco)
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf

    # install MiKTeX
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb [arch=amd64] http://miktex.org/download/ubuntu $(upstream-lsb) universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    sudo apt update -y
    sudo apt install -y miktex
    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
    sudo apt install -y -y texlive-latex-extra
    sudo mpm --admin --verbose --package-level=complete --upgrade

    # install texstudio
    sudo apt install -y texstudio

    # install JDK
    sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu $(upstream-lsb) main" | tee -a     /etc/apt/sources.list
    sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu $(upstream-lsb) main" | tee -a /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt update -y
    sudo apt install -y oracle-java8-installer
    sudo apt install -y oracle-java8-set-default
    #add .desktop file

    #Gradle
    sudo add-apt-repository -y ppa:cwchien/gradle
    sudo apt update -y
    sudo apt upgrade -y gradle

    #Maven
    sudo apt install -y maven

    #Grip
    sudo pip install grip

    #install R
    sudo apt install -y r-base-code
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu $(upstream-lsb)-cran35/"  | sudo tee -a /etc/apt/sources.list
    sudo apt update -y
    sudo apt install -y r-base r-base-dev r-recommended r-doc-html r-doc-pdf ess
    sudo R -e 'install.packages("mosaic", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("rmarkdown", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("ggformula", repos="http://cran.us.r-project.org")'

    #install RStudio
    wget "https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb"
    sudo apt install -y ./rstudio-xenial-1.1.463-amd64.deb
    rm rstudio-xenial-1.1.463-amd64.deb

    # qgis
    echo "deb https://qgis.org/ubuntu $(upstream-lsb) main"  | sudo tee -a /etc/apt/sources.list
    echo "deb-src https://qgis.org/ubuntu $(upstream-lsb) main"  | sudo tee -a /etc/apt/sources.list

    # ownCloud sync

    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_18.10/ /' > /etc/apt/sources.list.d/isv:ownCloud:desktop.list"
    sudo apt-get update
    sudo apt-get install owncloud-client

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
