#!/bin/bash
   
trap 'echo -e "\033[00;30m \n\nGracias por jugar \n"; exit 127' SIGINT
ROJO='\033[01;31m'
VERDE='\033[01;32m'
CYAN='\033[01;36m'
BLANCO='\033[37m'
AMARILLO='\e[1;33m'
MAGENTA='\e[1;35m'

   
pos=( "" "" "" "" "" "" "" "" "")
    
    Ganador () {
    echo -e "${VERDE}Felicidades $JUG tu Ganas!!\n"
    }
     
     Condiciones () {
      if [ $CELL_VALUE == "${pos[0]}" ] && [ $CELL_VALUE == "${pos[1]}" ] && [ $CELL_VALUE == "${pos[2]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[3]}" ] && [ $CELL_VALUE == "${pos[4]}" ] && [ $CELL_VALUE == "${array[5]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[6]}" ] && [ $CELL_VALUE == "${pos[7]}" ] && [ $CELL_VALUE == "${pos[8]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[0]}" ] && [ $CELL_VALUE == "${pos[3]}" ] && [ $CELL_VALUE == "${pos[6]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[1]}" ] && [ $CELL_VALUE == "${pos[4]}" ] && [ $CELL_VALUE == "${pos[7]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[2]}" ] && [ $CELL_VALUE == "${pos[5]}" ] && [ $CELL_VALUE == "${pos[8]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[0]}" ] && [ $CELL_VALUE == "${pos[4]}" ] && [ $CELL_VALUE == "${pos[8]}" ] ; then
      Ganador
      exit
      elif [ $CELL_VALUE == "${pos[2]}" ] && [ $CELL_VALUE == "${pos[4]}" ] && [ $CELL_VALUE == "${pos[6]}" ] ; then
      Ganador
      exit
      fi
     }
       
  Empate ()  {
   for k in `seq 0 $( expr ${#pos[@]} - 1) `
    do
     if [ ! -z ${pos[$k]} ] ; then
      tic_array[$k]=$k
       if [ "9"  -eq ${#tic_array[@]} ] ; then
        echo -e "${VERDE}\nTal vez tengan mejor suerte la proxima!!\n"
        exit
       fi 
     fi
    done
  }
        
  Tablero () {
   clear
   echo -e "\n\n\t${CYAN}**************************"
   echo -e "\t\t ${pos[0]:-0} | ${pos[1]:-1} | ${pos[2]:-2}"
   echo -e "\t\t____________\t"
   echo -e "\t\t ${pos[3]:-3} | ${pos[4]:-4} | ${pos[5]:-5}"
   echo -e "\t\t____________\t"
   echo -e "\t\t ${pos[6]:-6} | ${pos[7]:-7} | ${pos[8]:-8}"
   echo -e "\t**************************\n${CYAN}"
  }
         
  Celda_Vacia () {
   echo -e -n "${BLANCO}"
   read -e -p "$MSG" col
   case "$col" in
    [0-8]) if [  -z ${pos[$col]}   ]; then
    CELL_IS=empty
   else 
    CELL_IS=notempty 
   fi;;
     *) 
     echo -e "${ROJO}$JUG Por favor escribe un número entre 0 a 8 "
     Celda_Vacia;;
   esac
   echo -e -n "${BLANCO}"
  }
          
           
  Eleccion () { 
   Celda_Vacia
   if [ "$CELL_IS" == "empty" ]; then
    pos[$col]="$CELL_VALUE"
   else  
    echo -e "${ROJO}Este espacio esta ocupado, intente en otro $JUG"
    Eleccion
   fi
  }
            
   Jugadores () {
   if [ -z $JUG1 ]; then
    read -e -p "Introduce el nombre del primer jugador: " JUG1
   fi
   
   if [ -z $JUG2 ]; then
    read -e -p "Introduce el nombre del segundo jugador: " JUG2
   fi
     
   if [ -z $JUG1 ] ; then 
     echo -e "${ROJO}El nombre del jugador no puede estar vacío" 
     Jugadores
   elif [ -z $JUG2 ]; then
     echo -e "${ROJO}El nombre del jugador no puede estar vacío" 
     Jugadores
   fi
   }
     
# Main 
clear
echo -ne "\n\n\t${AMARILLO}..::Bienvenido al juego de gato::..\n\n"
#echo -e "\n\tPara su turno debe escoger la posicion que desea ocupar"
read -n 1 -p "Para continuar escribe y : " y
echo -e "\n"
     
    if  [ "$y" == "y" ]  ||  [ "$y" == "Y" ]; then
     clear
     echo -e "${BLANCO}"
     Jugadores
    else
     echo -e "${VERDE}\nLo esperaremos para la proxima!! :)"
     exit 
    fi
  i=0     
 Tablero
  while :
   do
    value=`expr $i % 2`
    if  [ "$value" == "0" ]; then
     JUG=$JUG1
     MSG="$JUG Introduce tu elección : "
     CELL_VALUE="x"
     Eleccion
    else 
     JUG=$JUG2
     MSG="$JUG Introduce tu elección : "
     CELL_VALUE="o"
     Eleccion
   fi
    ((i++))
    Tablero
    Condiciones
    Empate 
  done
