#!/bin/bash
verde="\e[1;32m"
rojo='\e[1;31m'
cyan='\e[1;36m'
blanco='\e[1;37m'
amarillo='\e[1;33m'
blancoc='\e[1;7;37m'

buscar()
{
clear
echo -e "${blanco}\t ……….Cargando resultados obtenidos de la busqueda.……… \r"

resultado=$(find $3 -iname $2 -type $1)  #el resultdo va a ser lo que encuentre find en el la ruta, con nombre y tipos indicados 

if test -z "${resultado}" #si no se guardo nada en resultados (osea no se encontro nada)
then
clear
echo -e "${rojo}\t ……….No se encontraron resultados.………"
sleep 2.5
clear
echo -e "${cyan}\t\t Termino la busqueda... \r"
echo -ne "\n\n"
else
clear
echo -e "${verde}La ruta absoluta de lo que busca es :"
echo " "
echo $resultado > busquedaOutput.txt #se crea un archivo para guardar de forma escrita la ruta del archivo
for linea in $(cat busquedaOutput.txt);
do
echo "$linea" ; #se imprime la ruta guardada en el archivo
done
rm -rf busquedaOutput.txt #se elimina el archivo
sleep 2.5
echo " "
echo -e "${cyan}\t\t Termino la busqueda... \r"
echo -ne "\n\n"
fi
}

#Main
clear
echo  -ne "\n\n\t${amarillo}..:: Busqueda ::..\n"
echo  -ne "\n\t${blanco}Que quieres buscar?\n\n" 
echo -ne "\t f -> file "
echo -ne "\n\t d -> directorio \n"
echo -ne "\n\t${cyan}Elige una opcion: \c"
read tipo
clear
echo  -ne "Introduce el nombre del archivo (con extension si es un file): "
read archivo

clear
echo -e "${blanco}Seleccion la ruta en la que desea realizar la busqueda "
echo "1 – Home"
echo "2 – Ruta actual"
echo "3 – Todo el sistema"
echo "4 – Ruta personalizada"
echo -n "Opcion: "
read opc

case $opc in
1) ruta=$HOME ;;
2) ruta=$PWD ;;
3) ruta=/ ;;
4) clear
   echo -e "${verde}***Ingrese la ruta absoluta en donde se va a realizar la busqueda***\nEj./home/usuario/carpetas.../carpetafinal"
   read p
   ruta=$p ;;
*) clear
   echo -e "${rojo}Seleción erronea…."
   sleep 3
   clear
   echo -e "${cyan}Se realizara la busqueda en la ruta actual"
   ruta=$PWD ;;
esac


buscar $tipo $archivo $ruta
