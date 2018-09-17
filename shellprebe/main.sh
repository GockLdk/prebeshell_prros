#!/bin/bash

echo -e "\n\t\033[1;36m" | cat tux.txt #impresion de imagen

echo -e "\t\033[1;30m" #negro
#revisamos e instalamos paquetes necesarios
gawk=$(dpkg -s gawk | grep Status) 
mpg=$(dpkg -s mpg123 | grep Status)
whois=$(dpkg -s whois | grep Status)

sudo cp ayuda.1 /usr/share/man/es/man1/ 
cd ..
sudo chmod -R 777 prebesh
cd shellprebe

if [ "$gawk" = "Status: install ok installed" ]; then 
echo ""
else
	echo -e "\n\t\033[1;36m" #cyan
	echo -e "\n\tPara el buen funcionamiento de la prebe-shell es necesario instalar algunos paquetes"
	echo -e "\n\tInstalando 'gawk'...\n"
	echo -e "\n\t\033[1;30m" #negro	
	sudo apt-get install gawk
fi
	 
    if [ "$mpg" = "Status: install ok installed" ]; then
    echo ""
	else 
		echo -e "\n\t\033[1;36m" #cyan
		echo -e "\n\tInstalando 'mpg123'...\n"
		echo -e "\n\t\033[1;30m" #negro
		sudo apt-get install mpg123
		echo -e "\n\t\033[1;36m" #cyan
		echo -e "\n\t\033[1;36mGracias por tu paciencia ... \n"  
    fi
            
    if [ "$whois" = "Status: install ok installed" ]; then
    echo ""
    else 
		echo -e "\n\t\033[1;36m" #cyan
        echo -e "\n\t\033[1;96m Instalando 'whois'...\n\n"
		echo -e "\033[1;30m" #negro
        sudo apt-get install whois
		echo -e "\n\t\033[1;96m"
		echo -e "\n\t\033[1;96mGracias por tu paciencia ... \n"
	fi

#Atrapamos comandos ctrl+z y ctrl+c
 
#mandamos respuesta a ctrl+z y ctrl+c

echo -e "\t\033[1;32m" #verde
cat bienvenido.txt

intento=0
while [ $intento != "salida" ];do
#se piden los datos
echo -e "\t\033[1;96m"
echo -e "\n\tIngresa tu ...\n\t\t"
echo -e "\t\033[1;97m"
echo -n -e "\tUsuario: \c"
echo -e "\033[1;95m\c"
read usuario

userbien=$(grep $usuario /etc/passwd)

if [ -z "$userbien" ]; then
	echo -e "\t\033[1;32m"
	echo -e "\n\t Tu usuario es incorrecto :(. Intenta de nuevo"
else 
	STTY_SAVE=`stty -g`
	stty -echo
 
	echo -e "\033[1;97m"
	echo -n -e "\tContrasenia: \c"
	read contra

	stty $STTY_SAVE
	echo

	contracomp=$(sudo -S grep -r $usuario /etc/shadow) #contrasena sacada de shadow
	sudo -S grep -r $usuario /etc/shadow > ejemplo.txt #pasamos a fichero para comparar
	salt=$(awk -F'$' '{print $3}' ejemplo.txt) #comparamos para sacar el 'salt'
	contramk=$(mkpasswd --method=sha-512 --salt=$salt $contra) #convertimos $contra 
	
	contrayes=$(echo "$contracomp" | cut -d ":" -f 2 );
	if [ "$contrayes" = "$contramk" ]; then #verificamos que coincidan
	echo -e "\t\033[1;32m"
	echo -e "\n\tLogin exitoso :)"
	intento="salida"
	else 	
	echo -e "\t\033[1;32m"
	echo -e "\n\tLa contrasena es incorrecta :(. Intenta de nuevo"
	fi
fi
done

trap 'salir' 2 20
salir(){
echo -e "\tDigita 'salir' para terminar el programa\n"
} 

echo -e "\033[1;96m"
echo -e "\n\tHola \033[1;35m $usuario"
echo -e "\033[1;97m"
echo -n -e "\tDeseas configurar tu propio apodo dentro de la prebe-shell? s=1, n=2:  \c"
echo -e "\033[1;95m\c"
read res
if [ $res -eq 1 ] ; then
	echo -e "\n\033[1;97m"
	echo -n "\tComo te gustaria que te llamara? \c"
	echo -e "\033[1;95m\c"
	read apodo
	echo -e "\033[1;37m"
	echo -e "\n\tPerfecto, \033[1;35m $apodo!!\033[1;32m Todo listo para que uses nuestra Prebeshell\n"

elif [ $res -eq 2 ]; then
	apodo=$(whoami)
	echo -e "\033[1;32m"
	echo -e "\n\tTodo listo para usar la prebeshell\n\n"
else 
	$res
fi

sleep 1
while [ "$orden" != "salir" ]; do
prompt="\033[40m\033[1;36m├─ $PWD ─┤├─ \033[1;35m $apodo ─┤▶ \033[0m"
echo  -e -n "$prompt\c  "
echo -e "\033[1;32m\c"
read orden
case "$orden" in 
	"fecha" )
		$PWD/fecha.sh
		;;
	"hora" )
                $PWD/hora.sh
                ;;

	"arbol" )             	
		$PWD/arbolito.sh
                ;;
	"buscar" )
                $PWD/buscar.sh
                ;;
	"infosis" )
                $PWD/infos.sh
                ;;
	"creditos" )
        clear
		echo -e "\n\t\033[1;97m"
                cat creditos.txt
                ;;
	"reproductor" )
                $PWD/player.sh
		sleep 1
		clear
		echo -e "\t\033[1;97m" #blanco
		cat tux.txt #impresion de imagen
		echo -e "\n\n"
                ;;
	"juegos" )
               $PWD/menujuegos.sh
		sleep 1
		clear
		echo -e "\t\033[1;97m" | cat tux.txt #impresion de imagen
		echo -e "\n\n"		
                ;;
	"ayuda" )
		man ayuda
		echo -e  "\n\n" 
		;;
	"limpiar" )
		clear
		;;
	"salir" )
		echo -e "\n\tEsperemos que la hayas disfrutado.... (Y que nos pongas 10).\n"
		;;
	* )
		echo -e "\t\033[1;97m"
		echo -e "\n\t\t***** Puedes digitar 'ayuda' para mas informacion *****\n"
	;;

esac
done


