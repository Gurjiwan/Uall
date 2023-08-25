#!/bin/sh
# Script to run all update commands

# Using \033[{ANSI escae code}m format to define colors for printf.
# Similar to how \n is used for new line \033[ is used fro ANSI colors
# some ANSI codes are [RED] 0;31 [Blue] 0;34 [Yellow] 1;33 [Cyan] 0;36

Cyan='\033[0;36m' # Simple shell variables to hold color values
Yellow='\033[1;33m' # shell variables can be called by ${Variable name}
NC='\033[0m' # No color
RED='\033[0;31m' # RED color value
aur='0' #Variable to store the AUR Helper command
super='0' # variable to check between sudo and doas

if [[ $EUID == 0 ]];then
    super=''
elif command -v doas > /dev/null;then
    super='doas'
elif command -v sudo > /dev/null;then
    super='sudo'
fi

printf "${Yellow} Running ${NC}${super} pacman -Syu \n"
command ${super} pacman -Syu
printf "${Cyan} ---	END	---\n"

#if statement to decide which aur helper is present
if command -v paru > /dev/null; then
    aur='paru -Sua'
elif command -v yay > /dev/null; then
    aur='yay -Sua'
fi

if [[ $aur == 0 ]]; then
    printf "${Yellow}yay and paru are the only supported AUR helpers\n"
elif [[ $EUID == 0 ]]; then #will prevent the aur helper like yay and paru from running as root
    printf "${Yellow} Running ${NC}${aur} \n"
    sudo -u nobody $aur #if running as root run aur helper command as nobody user
    printf "${Cyan} ---	END	---\n" 
else
    printf "${Yellow} Running ${NC}${aur} \n"
    command $aur
    printf "${Cyan} ---	END	---\n" 
fi

if command -v flatpak > /dev/null; then
    printf "${Yellow} Running ${NC}flatpak update......\n"
    flatpak update
    printf "${Cyan} ---	END	---\n" 
fi
