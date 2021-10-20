#!/usr/bin/env bash
# TODO: 

<<'COMMENT'
    Esto es un comentario multilinea
COMMENT

declare -A dictionary
option="normal";
update="no";
reboot="no";
uninstallnode="no";
installnpmPackages="no";
installDotfiles="no";
package="n"
alias version="grep UBUNTU_CODENAME /etc/os-release | grep -o --colour=never \"[a-z-]*$\""

isInstalled() {
    #dpkg-query -Wf'${db:Status-abbrev}' $1 2>/dev/null | grep -q '^i'
    which $1 > /dev/null 
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
            checkPackage $key
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
    echo 'test'
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
    echo '-----OPTIONS-----'
    echo '[n:normal] packages'
    echo '[f:full] packages'
    echo '[z:zsh] packages'
    echo '[d:dotfiles] files'
    echo '[node] packages'
    echo '[e:extra] packages'
    echo '[p:python] and pip packages'
    echo '[u:uninstall] packages'
    echo
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
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
        ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
        
        echo "install plugins"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
}

askReinstallNode () {
    read -p "Replace node with new version? (y/N): " uninstallnode
    if [[ $uninstallnode == "y" ]] || [[ $uninstallnode == "yes" ]]; then
        nvm install "lts/*" --reinstall-packages-from="$(nvm current)"
        echo "NVM new version installed. Uninstalling the old version..."
        eval "nvm uninstall $currentNodeVersion"
    fi
}

askInstallnpmPackages () {
    read -p "Install/update npm packages? (y/N): " installnpmPackages
    if [[ $installnpmPackages == "y" ]] || [[ $installnpmPackages == "yes" ]]; then
        xargs -a ./packages/npm.txt npm -g install
    fi
}

installNode () {
    export NVM_DIR="$HOME/.nvm"
    source $NVM_DIR/nvm.sh
    currentNodeVersion=$(eval "nvm current")
    printf 'Current Node Version is %s\n' "$currentNodeVersion"
    askReinstallNode
    printf 'Current npm global packages\n'
    npm list -g --depth 0
    askInstallnpmPackages
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
        getDictionary "./packages/full.txt"
    elif [[ $option == "node" ]]; then
        installNode
    elif [[ $option == "u" ]] || [[ $option == "uninstall" ]]; then
        echo "Iniciando desinstalacion paquetes..."
        uninstall
    elif [[ $option == "d" ]] || [[ $option == "dotfiles" ]]; then
        echo "Iniciando instalacion dotfiles (modo simulacion)..."
        stow -n -v -S -t ~ git bash zsh
        read -p "Todo ok? Instalar sin modo simulacion? (y/N): " installDotfiles
        if [[ $installDotfiles == "y" ]] || [[ $installDotfiles == "yes" ]]; then
            stow -v -S -t ~ git bash zsh
        fi
    else
        echo "Opcion incorrecta. Se procede con actualizacion y limpieza."
    fi
}

# Main
printOptions
read -p "Enter option (normal): " option
checkOptions
askUpdate
askClean
askReboot
