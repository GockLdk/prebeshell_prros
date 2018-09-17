#!/usr/bin/env bash
ROJO='\033[01;31m'
VERDE='\033[01;32m'
CYAN='\033[01;36m'		#definicion de colores
BLANCO='\033[37m'
AMARILLO='\033[33m'

ScoreJUG=0 # Puntuacion total del jugador
ScorePC=0 # Puntuacion total del PC 

rondas=-1 # Numero de rondas

turnoJUG=-1 # Eleccion del Jugador 
turnoPC=-1 # Eleccion de la Pc

RONDA=1 # Ronda actiual

Escogido_JUG=-1 
Escogido_PC=-1 # Aca se almacenara si elijio piedra, papel o tijera

re='^[0-9]+$'

clear
echo -ne "${AMARILLO}\n\n\t\t..::Piedra, Papel o Tijeras::..\n"

while : 
do #ciclo infinito
  echo -ne "${BLANCO}\n\tCuantas rondas quieres jugar?  \c  "
  echo -ne "${CYAN}\c" 
  read -r rondas  #numero de rondas a jugar

  if ! [[ $rondas =~ $re ]] ; then 
     echo -ne "${ROJO}\n\tNumero invalido!" 
     echo -ne "${CYAN}\n\tIntente de nuevo\n"
  elif [ $rondas == 0 ]; then #obligando al usuario que elija al menos una ronda
    echo -ne "${ROJO}\n\tTienes que elegir almenos una ronda"
  else
    echo -ne "\n\t${CYAN}Duelo a muerte a $rondas rondas!\n"
    break
  fi
done

re='^[rps]+$'
while [ $rondas -gt 0 ]; do #si rondas es diferente de 0
  clear
  echo -ne "${AMARILLO}\n\tRonda: $RONDA\n"
  echo -ne "${AMARILLO}\n\tElige tu arma...\n"
  turnoPC=$(shuf -i 1-3 -n 1)   #se escoge un numero al azar del 1-3 para la PC
  [ "$turnoPC" == "1" ] && turnoPC="r"
  [ "$turnoPC" == "2" ] && turnoPC="p"    #dependiendo del numero se le asigna una letra que simboliza una piedra, papel o tijera
  [ "$turnoPC" == "3" ] && turnoPC="s"
  echo -ne "${CYAN}\n\tPiedra (r), Papel (p) o Tijeras (s): "
  echo -ne "${BLANCO}\c"
  read -r turnoJUG #guarda la opcion del jugador
  if ! [[ "$turnoJUG" =~ $re ]] || [ "${#turnoJUG}" != "1" ]; then #si no es una opcion permitida
     echo -ne "${ROJO}\n\tEso no esta permitido!"
     echo -ne "\n\tIntente de nuevo en un momento\n"
  else

    [ "$turnoJUG" == "r" ] && Escogido_JUG="Piedra"
    [ "$turnoJUG" == "p" ] && Escogido_JUG="Papel"
    [ "$turnoJUG" == "s" ] && Escogido_JUG="Tijeras"
    													#Dependiendo de la letra se le asigna el valor Piedra, Papel o Tijera
    [ "$turnoPC" == "r" ] && Escogido_PC="Piedra"
    [ "$turnoPC" == "p" ] && Escogido_PC="Papel"
    [ "$turnoPC" == "s" ] && Escogido_PC="Tijeras"

    clear
    echo -ne "\n\n\t${BLANCO}Escogiste: ${CYAN} $Escogido_JUG !\n"
    echo -ne "\n\t${BLANCO}La PC escogio:${CYAN}  $Escogido_PC !"
    echo -e "\n"										#Imprime las opciones elegidas del jugador y de la PC

    PC_won=0  
    JUG_won=0  #contadores de las rondas ganadas del PC y el Jugador

    if [ "$turnoJUG" == "r" ]; then
      [ "$turnoPC" == "p" ] && PC_won=1
      [ "$turnoPC" == "s" ] && JUG_won=1
    fi
    if [ "$turnoJUG" == "p" ]; then
      [ "$turnoPC" == "r" ] && PC_won=1     # Define que opcion le gana a cual
      [ "$turnoPC" == "s" ] && JUG_won=1
    fi
    if [ "$turnoJUG" == "s" ]; then
      [ "$turnoPC" == "r" ] && PC_won=1
      [ "$turnoPC" == "p" ] && JUG_won=1
    fi
    if [ "$PC_won" == "0" ] && [ "$JUG_won" == "0" ]; then #si ninguno gano empatan
      echo -ne "\n\t${AMARILLO}Empataron :s"
    elif [ "$JUG_won" == 1 ]; then
      echo -ne "${VERDE}\n\tGanaste :)"
      ((ScoreJUG++))
    elif [ "$PC_won" == 1 ]; then
      echo -ne "${ROJO}\n\tGano la PC :("
      ((ScorePC++))
    fi
    
  	if [ $rondas != 1 ]; then
    echo -ne "\n${BLANCO}\tCargando la siguiente ronda...\n"
	fi
    ((rondas--))   #reduce la ronda para saber cuantas van 
    ((RONDA++))    #Aumenta para imprimir la ronda que se juega

  fi
  sleep 2
done

sleep 3 
clear
echo -ne "\n\t${BLANCO}Eso fue todo amigo!\n"
echo -ne "\n\t${CYAN}Tu puntaje:${BLANCO} $ScoreJUG"
echo -ne "\n\t${CYAN}Puntaje de la PC:${BLANCO} $ScorePC"    #imprime los resultados finales 
echo -e "\n"

if [ $ScorePC -gt $ScoreJUG ]; then
  echo -ne "\n\t${ROJO}Perdiste :s"
elif [ $ScoreJUG -gt $ScorePC ]; then
  echo -ne "\n\t${VERDE}Ganaste <3"
elif [ $ScorePC -eq $ScoreJUG ]; then
  echo -ne "\n\t${AMARILLO}Un simple empate..."
fi

sleep 3
clear
echo -ne "\n\t${VERDE}Gracias por Jugar"

exit
