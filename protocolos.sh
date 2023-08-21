#!/bin/bash

# Colores de texto
NEGRO="\e[30m"
ROJO="\e[31m"
VERDE="\e[32m"
AMARILLO="\e[33m"
AMARILLO_CLARO="\e[93m"
AZUL="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BLANCO="\e[37m"
GRIS="\e[90m"

# Colores de fondo
FONDO_NEGRO="\e[40m"
FONDO_ROJO="\e[41m"
FONDO_VERDE="\e[42m"
FONDO_AMARILLO="\e[43m"
FONDO_AZUL="\e[44m"
FONDO_MAGENTA="\e[45m"
FONDO_CYAN="\e[46m"
FONDO_BLANCO="\e[47m"

# Estilos de texto
NEGRITA="\e[1m"
SUBRAYADO="\e[4m"
INVERTIDO="\e[7m"
COLORES=("\e[31m" "\e[32m" "\e[33m" "\e[34m" "\e[35m" "\e[36m" "\e[37m")

# Aqui El Instalador De Cada Protocolo Y menu

badvpn() {
  clear && clear
  source /etc/ivandx/badvpn/badvpn.sh
}

squidproxy() {
 clear && clear
 source /etc/ivandx/squidp/squid.sh
}
# los $
badstatus="badvpn status"
# Aqui El Texto Del Menu
clear && clear
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AZUL}▶ IP:${RESTAURAR}${CYAN} $ifconfig${RESTAURAR} ${AMARILLO}S.O: $so FECHA: $fecha${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do
    echo -e "${CYAN}INSTALADOR DE PROTOCOLOS${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶ ${AMARILLO}BADVPN [${badstatus}]${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶ ${AMARILLO}PROXY SQUID [${squidstatus}]${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶ ${AMARILLO}DropBear [${dropstatus}]${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ ${AMARILLO}PROXY PYTHON [${pystatus}]${RESTAURAR}"
    echo -e "${GRIS}[5]${RESTAURAR} ▶ ${AMARILLO}SSL [${sslstatus}]${RESTAURAR}"
    echo -e "${GRIS}[0]${RESTAURAR} ▶ ${ROJO}REGRESAR${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

    echo -e "${AMARILLO}Selecciona una opción:${RESTAURAR} \c"
    read opcion


  case $opcion in
      1) badvpn ;;
      2) squidproxy ;;
      3) dropbear ;;
      4) pyproxy ;;
      5) ssl ;;
      0) menu ;;
      *) opcion_invalida ;;

  esac

done
