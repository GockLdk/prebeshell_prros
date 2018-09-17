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

#Atrapamos comandos ctrl+z y ctrl+c
trap 'salir' 2 20 

#mandamos respuesta a ctrl+z y ctrl+c
salir(){
echo -ne "\t\t\tDigita 'salir' para terminar el programa\n\c  "
echo -ne "\n\t${blanco}Elige una opcion: \c"
echo -ne "${cyan}\c"
} 

echo -e "\n\n\n\t${amarilloc}..:: BIENVENIDO AL MENU DE JUEGOS ::..\n\n"
echo -e "\n\t${cyanc}a -> ${blanco}Piedra, papel o tijeras: "
echo -e "\n\t${cyanc}b -> ${blanco}Gato: "
echo -e "\n\t${cyanc}c -> ${blanco}Salir: \n"


while [ "$opcion" != "c" ]; do

echo -ne "\n\t${blanco}Elige una opcion: \c"
echo -ne "${cyan}\c"
read opcion
case "$opcion" in 
	"a" )
		$PWD/piedra.sh
		echo -e "\n\n\n\t${amarilloc}..:: BIENVENIDO AL MENU DE JUEGOS ::..\n\n"
		echo -e "\n\t${cyanc}a -> ${blanco}Piedra, papel o tijeras: "
		echo -e "\n\t${cyanc}b -> ${blanco}Gato: "
		echo -e "\n\t${cyanc}c -> ${blanco}Salir: \n"
		;;
	"b" )
                $PWD/gato1.sh 
		echo -e "\n\n\n\t${amarilloc}..:: BIENVENIDO AL MENU DE JUEGOS ::..\n\n"
		echo -e "\n\t${cyanc}a -> ${blanco}Piedra, papel o tijeras: "
		echo -e "\n\t${cyanc}b -> ${blanco}Gato: "
		echo -e "\n\t${cyanc}c -> ${blanco}Salir: \n"
                ;;
	
	"limpiar" )
		clear
		;;
	"c" )
		echo -ne "\n\t\t${amarillo}Vuelve pronto :) \n"
		;;
	"salir" )
		echo -ne "\n\t\t${amarillo}Vuelve pronto :) \n"
		exit
		;;
	* )
		echo -ne "${amarillo}\t\t\t\tOpcion invalida\n"
		;;
esac
done

