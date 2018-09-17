#!/bin/bash
cyan='\e[1;36m'
blanco='\e[1;97m'
magenta='\e[1;35m'
rojoc='\e[1;3;91m'


echo -n -e "\n\t\t\t\t\t\t${blanco}Hoy es ─┤▶ ${rojoc}"
date | gawk '{print $(NF-3),$(NF-4),$(NF)}'
echo -ne "\n"

