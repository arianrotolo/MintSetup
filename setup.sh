#!/usr/bin/env bash

option="normal";
update="no";

update () {
    echo 'Initialize updating'
    sudo apt full-upgrade -y
    sudo apt update -y
    sudo apt upgrade -y
}

read -p "Update packages (y:yes ; n:no): " update
if [[ $update == "y" ]] || [[ $update == "yes" ]]; then
    update
fi

echo $'\nOh My Zsh packages (z:zsh): '
echo "Plugins."

echo $'\nNormal packages (n:normal): '
echo $'...\n'

echo "Full packages (f:full): "
echo "All packages."

echo $'\nExtra packages (e:extra): '
echo "LAMP (Linux, Apache, MySQL, PHP)."
echo "Spyder IDE."
echo "Texmaker LaTeX."
echo "Java Kit: Maven and Gradle."

echo $'\nPython packages (p:python): '
echo $'Pip packages.\n'

read -p "Enter option (normal by default): " option

if [[ $option == "f" ]] || [[ $option == "full" ]]; then
    option="full";
elif [[ $option == "e" ]] || [[ $option == "extra" ]]; then
    option="extra";
elif [[ $option == "z" ]] || [[ $option == "zsh" ]]; then
    option="zsh";
elif [[ $option == "p" ]] || [[ $option == "python" ]]; then
    option="python";
else
    option="normal";
fi

echo "Selected option for installation: $option!"

alias version="grep UBUNTU_CODENAME /etc/os-release | grep -o --colour=never \"[a-z-]*$\""

if [ $option == "zsh" ]; then
    echo "Iniciando instalacion Oh My Zsh"

    # install zsh shell
    sudo apt install -y zsh
    sudo chsh -s $(which zsh)
    
    # install Oh My Zsh (copiar .zshrc a /home)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    # install theme
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
    
    # install plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    sudo apt update -y
    echo "Instalacion finalizada. El equipo se reiniciara para terminar con la correcta instalacion."
    sudo reboot
fi

if [ $option == "normal" ]; then
    xargs -a ./packages/normal.txt sudo apt-get install
    echo 'Enable firewall'
    sudo ufw enable
fi

if [ $option == "extra" ]; then
    echo "Iniciando instalacion de paquetes extra..."
    xargs -a ./packages/extra.txt sudo apt-get install
fi

if [ $option == "python" ]; then
    echo "Iniciando instalacion de paquetes Python..."
    xargs -a ./packages/python.txt sudo apt-get install
    pip3 --version
    sudo pip3 install --upgrade pip
    echo "Iniciando instalacion de paquetes pip..."
    xargs -a ./packages/pip.txt sudo pip install
fi

if [ $option == "full" ]; then
    
    echo "Iniciando instalacion de paquetes full..."
    
    # install AMD drivers (OpenGL, Vulkan, Mesa)
    #sudo add-apt-repository ppa:oibaf/graphics-drivers
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install libvulkan1 mesa-vulkan-drivers vulkan-utils 
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf 

    # install Neovim
    #sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update -y
    sudo apt install -y neovim
    
    # install Calibre
    sudo apt update -y
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

    # install Chrome
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update -y
    sudo apt install -y google-chrome-stable
    
    # install VSCode
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update -y
    sudo apt install -y code

    # install Spotify
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update -y
    sudo apt install -y spotify-client
    
    # install Brave
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser
    
fi

<<'COMMENT'
    Esto es un comentario multilinea
COMMENT

update

#unistalling
echo "Iniciando desinstalacion paquetes..."
#sudo apt purge -y hexchat
#sudo apt purge -y rhythmbox

#cleaning
echo "Iniciando limpieza de basura..."
sudo apt autoremove -y
sudo apt clean -y all
rm -rf ~/.cache/thumbnails/*
sudo du -sh /var/cache/apt

update

echo $'\n'"*** Finalizado. Reinicia el sistema! ***"
