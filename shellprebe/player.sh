#!/bin/bash

#Programa reproductor de musica

clear

while : 
do 
  menu=$(zenity --title="..:: Reproductor musical ::.." --text "Que desea hacer?\n\n 1.- Instrucciones\n 2.- Reproducir una cancion\n 3.- Reproducir carpeta de canciones\n 4.- Salir\n" --entry);
  
case $menu in
	1) clear ; ruta=$(zenity --title="..:: Reproductor musical ::.." --info --text "(d)____________________________________Cancion anterior\n(f)______________________________________Cancion siguiente\n(Barra espaciadora)_____Pausa/Play\n(q)______________________Salir\n(+)_____________________________Subir volumen\n(-)_____________________________Bajar volumen\n\nPresiona OK o ENTER para continuar"); clear;;
	2) clear ; ruta=$(zenity --title="..:: Reproductor musical ::.." --text "***Dame la ruta de cancion***\nEj. /home/usuario/carpeta.../nombreconsuextension.mp3" --entry);
	   mpg123 -vC $ruta ;;
	3) clear ; ruta=$(zenity --title="..:: Reproductor musical ::.." --text "***Dame la ruta de la carpeta***\nEj. /home/usuario/carpeta.../carpetademusica" --entry);
           cd $ruta;
	   mpg123 -vC *.mp3 ;;
	4) clear ; exit ;;
	*) clear ; zenity --info --title="..:: Reproductor musical ::.." --text "No valida tu opcion man" ;;
esac 

done 
