#!/bin/bash
cyan='\e[1;36m'
blanco='\e[1;97m'
rojoc='\e[1;3;91m'

echo -n -e "\n\t\t\t\t\t\t${blanco}Son las ─┤▶ ${rojoc}"
date | gawk '{print $(NF-2)}'
echo -ne "\n"


