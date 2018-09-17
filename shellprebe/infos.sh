#!/bin/bash
verde="\e[1;32m"
rojoc='\e[1;91m'
cyan='\e[1;36m'
blanco='\e[1;97m'
azul='\e[1;34m'
negro='\e[1;30m'
amarillo='\e[1;33m'
magenta='\e[1;35m'
grisc='\e[1;37m'
grisf='\e[1;90m'
rojof='\e[1;31m'
verdec='\e[1;92m'
amarilloc='\e[1;93m'
azulc='\e[1;94m'
magentac='\e[1;95m'
cyanc='\e[1;96m'

clear
#Equipo
eqnombre=$HOSTNAME
fabricanteq=$(sudo dmidecode -s system-manufacturer)
nombreprod=$(sudo dmidecode -s system-product-name)
versionprod=$(sudo dmidecode -s system-version)
numeroserie=$(sudo dmidecode -s system-serial-number)

proc=$( cat /proc/cpuinfo | grep 'model name' | head -n 1 | sed -e 's/model name	://g' )
arqui=$(uname -m)

memlibre=`cat /proc/meminfo | grep "MemFree" | grep "[1-9].*" -o`
memtotal=`cat /proc/meminfo | grep "MemTotal"| grep "[1-9].*" -o`
kernel=$(uname -sr)
ram=$( free -h | grep Mem | awk '{print $2}' )
sistemaop=$( cat /etc/*release | grep DISTRIB_ID | awk -F'=' '{print $2}' )
version=$( cat /etc/*release | grep DISTRIB_RELEASE | awk -F'=' '{print $2}' )

user=$USER

echo -e "\n\n\n\t${amarilloc}..:: INFORMACION DEL SISTEMA ::..\n\n"
echo -e "\n\t${blanco}-> Usuario activo: ${rojoc} $user"
echo -e "\n\t${blanco}-> Nombre del equipo: ${rojoc} $eqnombre"
echo -e "\n\t${blanco}-> Fabricante del equipo: ${magenta} $fabricanteq"
echo -e "\n\t${blanco}-> Nombre y version del producto: ${magentac} $nombreprod  $versionprod"
echo -e "\n\t${blanco}-> Numero de serie: ${azul} $numeroserie"
echo -e "\n\t${blanco}-> Sistema Operativo: ${azulc} $sistemaop $version"
echo -e "\n\t${blanco}-> Kernel: ${cyan} $kernel"
echo -e "\n\t${blanco}-> Procesador: ${cyanc} $proc"
echo -e "\n\t${blanco}-> Arquitectura: ${verde} $arqui"
echo -e "\n\t${blanco}-> RAM: ${verdec} $ram"
echo -e "\n\t${blanco}-> Memoria Total: ${amarilloc} $memtotal"
echo -e "\n\t${blanco}-> Memoria Libre: ${amarilloc} $memlibre\n\n"



