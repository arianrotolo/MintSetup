#!/usr/bin/env bash
# Change checkOptions is redundant

<<'COMMENT'
    Esto es un comentario multilinea
COMMENT

declare -A dictionary

option="normal";
update="no";
reboot="no";
package="n"

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
    echo "Iniciando desinstalacion paquetes..."
    sudo apt purge -y hexchat
    sudo apt purge -y rhythmbox
}

askClean () {
    read -p "Clean? (y/N): " option
    if [[ $option == "y" ]] || [[ $option == "yes" ]]; then
        echo "Iniciando limpieza de basura..."
        sudo apt autoremove -y
        sudo apt clean -y all
        rm -rf ~/.cache/thumbnails/*
        sudo du -sh /var/cache/apt
        sudo apt full-upgrade -y
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

checkOptions () {
    if [[ $option == "f" ]] || [[ $option == "full" ]]; then
        option="full";
    elif [[ $option == "e" ]] || [[ $option == "extra" ]]; then
        option="extra";
    elif [[ $option == "z" ]] || [[ $option == "zsh" ]]; then
        option="zsh";
    elif [[ $option == "p" ]] || [[ $option == "python" ]]; then
        option="python";
    elif [[ $option == "npm" ]]; then
        option="npm";
    else
        option="normal";
    fi
}

installFull () {
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

# Main

printOptions
read -p "Enter option (normal by default): " option
checkOptions
echo "Selected option for installation: $option!"
alias version="grep UBUNTU_CODENAME /etc/os-release | grep -o --colour=never \"[a-z-]*$\""

if [ $option == "zsh" ]; then
    echo "Iniciando instalacion Oh My Zsh"
    installZsh
    askUpdate
    askReboot
elif [ $option == "normal" ]; then
    xargs -a ./packages/normal.txt sudo apt install
    echo 'Enable firewall'
    sudo ufw enable
elif [ $option == "extra" ]; then
    echo "Iniciando instalacion de paquetes extra..."
    xargs -a ./packages/extra.txt sudo apt install
elif [ $option == "python" ]; then
    echo "Iniciando instalacion de paquetes Python..."
    xargs -a ./packages/python.txt sudo apt install
    pip3 --version
    sudo pip3 install --upgrade pip
    echo "Iniciando instalacion de paquetes pip..."
    xargs -a ./packages/pip.txt sudo pip install
elif [ $option == "full" ]; then
    
    echo "Iniciando instalacion de paquetes full..."
    getDictionary "./packages/dictionary.txt"
    readPackages "./packages/full.txt"
elif [ $option == "npm" ]; then
    
    installNpm
fi

askUpdate
#uninstall
askClean
askUpdate
askReboot