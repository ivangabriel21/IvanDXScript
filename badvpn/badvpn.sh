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

instalar_badvpn() {
echo "#!/bin/bash
if [ "'$1'" == uninstall ]
then
echo 'Desinstalando badvpn'
rm /bin/badvpn && rm /bin/badvpn-udpgw
echo 'Desinstalacion completa'
fi
if [ "'$1'" == start ]
then
screen -dmS bad7100 badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 1000 --client-socket-sndbuf 0 --udp-mtu 9000
screen -dmS bad7200 badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 1000 --client-socket-sndbuf 0 --udp-mtu 9000
screen -dmS bad badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 1000 --client-socket-sndbuf 0 --udp-mtu 9000
echo 'Badvpn iniciando en el puerto 7300,7200 Y 7100'
fi
if [ "'$1'" == stop ]
then
badvpnpid="'$(ps x |grep badvpn |grep -v grep |awk '"{'"'print $1'"'})
kill -9 "'"$badvpnpid" >/dev/null 2>/dev/null
kill $badvpnpid > /dev/null 2> /dev/null
kill "$badvpnpid" > /dev/null 2>/dev/null''
kill $(ps x |grep badvpn |grep -v grep |awk '"{'"'print $1'"'})
killall badvpn-udpgw
fi" > /bin/badvpn
chmod +x /bin/badvpn
if [ -f /bin/badvpn-udpgw ]; then
echo -e "\033[1;32mBadvpn ya esta instalado\033[0m"
rm -rf easyinstall >/dev/null 2>/dev/null
exit
else
clear
fi
echo -e "\033[1;31m           Instalador Badvpn\n\033[0m"
echo -e "Descargando Badvpn"
wget -O /bin/badvpn-udpgw https://raw.githubusercontent.com/powermx/badvpn/master/badvpn-udpgw &>/dev/null
chmod +x /bin/badvpn-udpgw
echo -e "\033[1;32m  Instalacion completa\033[0m" 
echo -e "\033[1;37mComandos:\n\033[1;31m badvpn start\033[1;37m para iniciar badvpn"
echo -e "\033[1;31m badvpn stop \033[1;37m para parar badvpn\033[0m"
echo -e "\033[1;31m badvpn uninstall \033[1;37m para desinstalar badvpn\033[0m"
rm -rf easyinstall >/dev/null 2>/dev/null
sleep 3s
clear
source /etc/ivandx/badvpn/badvpn.sh
cp /bin/badvpn /etc/ivandx/badvpn/badvpn
chmod +x /etc/ivandx/badvpn/badvpn
}

activar_badvpn() {
  echo -e "ACTIVANDO BADVPN"
  /bin/badvpn start
  sleep 2s
  clear
  source /etc/ivandx/badvpn/badvpn.sh
}

desactivar_badvpn() {
  echo -e "DESACTIVANDO BADVPN"
  /bin/badvpn stop
  sleep 2s
  clear
  source /etc/ivandx/badvpn/badvpn.sh
}

puerto1=7300
puerto2=7200

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
      1) instalar_badvpn ;;
      2) activar_badvpn ;;
      3) desactivar_badvpn ;;
      4) desinstalar_badvpn ;;
      0) menu ;;
      *) opcion_invalida ;;

  esac

done
