#!/usr/bin/env bash

echo '*** Creando Copia ***'

#crea carpetas
mkdir -p ~/Desktop/backup/dconf
mkdir -p ~/Desktop/backup/home
mkdir -p ~/Desktop/backup/home/Calibre\ Library/
#crea ficheros de texto
touch ~/Desktop/backup/dconf/cinnamon-settings.txt
touch ~/Desktop/backup/logs.txt

#crea copia archivos ~/ o HOME
cp -v ~/.zshrc ~/Desktop/backup/home >> ~/Desktop/backup/logs.txt
cp -v ~/.bashrc ~/Desktop/backup/home >> ~/Desktop/backup/logs.txt
cp -v ~/.profile ~/Desktop/backup/home >> ~/Desktop/backup/logs.txt
cp -v ~/.gitconfig ~/Desktop/backup/home >> ~/Desktop/backup/logs.txt
cp -v ~/Calibre\ Library/metadata.db ~/Desktop/backup/home/Calibre\ Library/ >> ~/Desktop/backup/logs.txt

#crea copia archivos org.cinnamon
echo $'\nPaths: /org/cinnamon/\nsounds\ntheme\ndesktop/keybindings/' >> ~/Desktop/backup/logs.txt
dconf dump /org/cinnamon/ > ~/Desktop/backup/dconf/cinnamon-settings.txt

echo '*** Copia Finalizada ***'
