#!/usr/bin/env bash
# TODO: 

<<'COMMENT'
    Esto es un comentario multilinea
COMMENT

declare -A dictionary
option="normal";
update="no";
reboot="no";
package="n"
alias version="grep UBUNTU_CODENAME /etc/os-release | grep -o --colour=never \"[a-z-]*$\""

isInstalled() {
    dpkg-query -Wf'${db:Status-abbrev}' $1 2>/dev/null | grep -q '^i'
}

installPackage () {
    eval ${dictionary[$1]}
}

checkPackage() {
    if isInstalled $1; then
        printf 'Yes, the package %s is installed!\n' "$1"
    else
        printf 'No, the package %s is not installed!\n' "$1"
        read -p "Install package? (y/N): " option
        if [[ $option == "y" ]]; then
            installPackage $1
        fi
    fi
}

getDictionary () {
    while IFS='=' read -r -u 3 key value || [ -n "$key" ]; do #read last line if not empty
        if [ -n "${key}" ]; then
            dictionary[$key]=$value
        fi
    done 3< $1 #file descriptor
}

readPackages () {
    while IFS= read -r -u 3 line || [ -n "$line" ]; do #read last line if not empty
        if [ -n "${line}" ]; then
            checkPackage $line
        fi
    done 3< $1 #file descriptor
}

askUpdate () {
    read -p "Update packages? (y/N): " update
    if [[ $update == "y" ]] || [[ $update == "yes" ]]; then
        sudo apt update -y
        sudo apt upgrade -y
    fi
}

uninstall () {
    #sudo apt purge -y hexchat
    #sudo apt purge -y rhythmbox
}

askClean () {
    read -p "Clean? (y/N): " option
    if [[ $option == "y" ]] || [[ $option == "yes" ]]; then
        echo "Iniciando limpieza de basura..."
        sudo apt autoremove -y
        sudo apt clean -y all
        rm -rf ~/.cache/thumbnails/*
        sudo du -sh /var/cache/apt
        sudo apt upgrade -y
        #sudo apt full-upgrade -y
    fi
}

askReboot () {
    read -p "Reboot system? (y/N): " reboot
    if [[ $reboot == "y" ]] || [[ $reboot == "yes" ]]; then
        echo "El equipo se reiniciara para finalizar la instalacion."
        sudo reboot
    fi
}

printOptions () {
    echo 'Oh My Zsh packages [z:zsh]: '
    echo 'Normal packages [n:normal]: '
    echo "All packages [f:full]: "
    echo 'Extra: LAMP, Spyder, Textmaker and JavaKit (Maven and Gradle) [e:extra]: '
    echo 'Python and pip packages [p:python]: '
}

installFull () {
    # install AMD drivers (OpenGL, Vulkan, Mesa)
    #sudo add-apt-repository ppa:oibaf/graphics-drivers
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install libvulkan1 mesa-vulkan-drivers vulkan-utils 
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf 
    # install Neovim
    # install Calibre
    sudo apt update -y
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
    # install Chrome
    # install VSCode
    # install Spotify
    # install Brave
}

installZsh () {
    read -p "Install zsh first time? (y/N): " option

    if [[ $option == "y" ]] || [[ $option == "yes" ]]; then
        echo "Install zsh shell"
        sudo apt install -y zsh
        sudo chsh -s $(which zsh)
        
        echo "install Oh My Zsh (copiar .zshrc a /home con stow)"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"        
    else
        echo "install theme"
        git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
        ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
        
        echo "install plugins"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
}

installNpm () {
    xargs -a ./packages/npm.txt npm -g install
}

checkOptions () {
    if [[ $option == "z" ]] || [[ $option == "zsh" ]]; then
        echo "Iniciando instalacion Oh My Zsh"
        installZsh
    elif [[ $option == "n" ]] || [[ $option == "normal" ]]; then
        xargs -a ./packages/normal.txt sudo apt install
        echo 'Enable firewall'
        sudo ufw enable
    elif [[ $option == "e" ]] || [[ $option == "extra" ]]; then
        echo "Iniciando instalacion de paquetes extra..."
        xargs -a ./packages/extra.txt sudo apt install
    elif [[ $option == "p" ]] || [[ $option == "python" ]]; then
        echo "Iniciando instalacion de paquetes Python..."
        xargs -a ./packages/python.txt sudo apt install
        pip3 --version
        sudo pip3 install --upgrade pip
        echo "Iniciando instalacion de paquetes pip..."
        xargs -a ./packages/pip.txt sudo pip install
    elif [[ $option == "f" ]] || [[ $option == "full" ]]; then
        echo "Iniciando instalacion de paquetes full..."
        getDictionary "./packages/dictionary.txt"
        readPackages "./packages/full.txt"
    elif [[ $option == "n" ]] || [[ $option == "npm" ]]; then
        installNpm
    elif [[ $option == "u" ]] || [[ $option == "uninstall" ]]; then
        echo "Iniciando desinstalacion paquetes..."
        uninstall
    fi
}

# Main
printOptions
read -p "Enter option (normal by default): " option
checkOptions
askUpdate
askClean
askReboot