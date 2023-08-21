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

instalar_bad() {
  echo -e "INSTALANDO BADVPN ESPERE UN MOMENTO"
  sleep 1s
  apt update
  wget https://raw.githubusercontent.com/powermx/badvpn/master/easyinstall -O /etc/ivandx/badvpn/easyinstall
  chmod +x /etc/ivandx/badvpn/easyinstall
  bash /etc/ivandx/badvpn/easyinstall
  cp /bin/badvpn /etc/ivandx/badvpn/badvpn
  chmod +x /etc/ivandx/badvpn/badvpn
  clear && clear
  source /etc/ivandx/badvpn/badvpn.sh
}

activar_bad() {
  echo -e "ACTIVANDO BADVPN ESPERE UN MOMENTO"
  bash /etc/ivandx/badvpn/badvpn start
  sleep 2s
  clear && clear
  source /etc/ivandx/badvpn/badvpn.sh
}

desactivar_bad() {
  echo -e "Desactivando BadVPN ..."
   bash /etc/ivandx/badvpn/badvpn stop
  echo -e "BADVPN DESACTIVADO"
  sleep 2s
  clear && clear
  source /etc/ivandx/badvpn/badvpn.sh
}

desinstalar_bad() {
   bash /etc/ivandx/badvpn/badvpn uninstall
   sudo rm -rf /etc/ivandx/badvpn/badvpn > /dev/null 
   sleep 2s
   clear && clear
   source /etc/ivandx/badvpn/badvpn.sh
}

clear && clear
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${CYAN} INSTALADOR DE BADVPN ${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do
    echo -e "${CYAN}      BADVPN${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶ ${AMARILLO}Instalar BadVPN${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶ ${AMARILLO}ACTIVAR BADVPN${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶ ${AMARILLO}DESACTIVAR BADVPN${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ ${AMARILLO}DESINSTALAR BADVPN${RESTAURAR}"
    echo -e "${GRIS}[0]${RESTAURAR} ▶ ${ROJO}REGRESAR${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

    echo -e "${AMARILLO}Selecciona una opción:${RESTAURAR} \c"
    read opcion


  case $opcion in
      1) instalar_bad ;;
      2) activar_bad ;;
      3) desactivar_bad ;;
      4) desinstalar_bad ;;
      0) menu ;;
      *) opcion_invalida ;;

  esac

done
