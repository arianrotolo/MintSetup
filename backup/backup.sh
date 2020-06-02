#!/usr/bin/env bash

echo '*** Creando Copia ***'

#crea carpetas y fichero de texto
mkdir -p ~/Desktop/backup/home
mkdir -p ~/Desktop/backup/dconf
mkdir -p ~/Desktop/backup/Calibre\ Library/
touch ~/Desktop/backup/home/list.txt
touch ~/Desktop/backup/dconf/config.txt

#crea copia archivos ~/ o HOME
cp -v ~/.zshrc ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/.bashrc ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/.profile ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/.gitconfig ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/Calibre\ Library/metadata.db ~/Desktop/backup/home/Calibre\ Library/ >> ~/Desktop/backup/home/list.txt

#crea copia archivos org.cinnamon
echo $'Path: /org/cinnamon/\nsounds\ntheme\ndesktop/keybindings/' > ~/Desktop/backup/dconf/used-config.txt
dconf dump /org/cinnamon/ > ~/Desktop/backup/dconf/cinnamon-settings.txt

echo '*** Copia Finalizada ***'
