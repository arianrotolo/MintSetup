#!/usr/bin/env bash

echo '*** Creando Copia ***'

mkdir -p ~/Desktop/backup/home
touch ~/Desktop/backup/home/list.txt

cp -v ~/.zshrc ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/.bashrc ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt
cp -v ~/.gitconfig ~/Desktop/backup/home >> ~/Desktop/backup/home/list.txt

mkdir -p ~/Desktop/backup/dconf
touch ~/Desktop/backup/dconf/used-config.txt
echo $'Path: /org/cinnamon/\nsounds\ntheme\ndesktop/keybindings/' > ~/Desktop/backup/dconf/used-config.txt

dconf dump /org/cinnamon/ > ~/Desktop/backup/dconf/cinnamon-settings.txt

echo '*** Copia Finalizada ***'

