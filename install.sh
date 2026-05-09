#!/bin/bash
mkdir -p ~/.config/quickshell
cp -r * ~/.config/quickshell
sudo pacman -S qt6 qt5 git --noconfirm
git clone https://aur.archlinux.org/quickshell-git.git
cd quickshell-git
makepkg -si
