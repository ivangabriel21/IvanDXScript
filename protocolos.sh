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

dropbear() {
 clear && clear
 source /etc/ivandx/dropbear/dropbear.sh
}

function verificarSSL() {
    if [ -e /etc/ssl/certs/server.crt ] && [ -e /etc/ssl/private/server.key ]; then
        clear && clear
        source /etc/ivandx/ssl/ssl.sh
    else
        clear && clear
        echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
        echo -e "${AMARILLO}⭐Instalando Y Configurando SSL, En Curso⭐${RESTAURAR}"
        echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
        echo ""
        echo "SSL no está instalado."
        read -p "¿Deseas instalar SSL? (y/n): " respuesta
        if [ "$respuesta" == "y" ] || [ "$respuesta" == "y" ]; then
            instalarSSL
        else
            echo "No se ha instalado SSL. Regresando Al Menu ..."
            sleep 1s
            clear && clear 
            source /etc/ivandx/protocolos.sh
        fi
    fi
}

#!/bin/bash

function instalarSSL() {
    # Instalar paquetes necesario 
    clear && clear
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO}⭐ Instalador y Configurador de SSL ⭐${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo ""
    apt-get update -y
    apt-get install -y openssl
    echo -e "Los Paquetes Se Instalaron Correctamente ✅"
    sleep 1s

    # Solicitar al usuario que ingrese el dominio SSL
    clear && clear
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO}⭐ Instalador y Configurador de SSL ⭐${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo ""
    read -p "Introduce tu dominio SSL (ejemplo.com): " dominio
    echo ""

    # Generar una clave privada y un certificado autofirmado
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt -subj "/CN=$dominio"

    # Descargar la configuración de Nginx desde GitHub (reemplaza 'URL_DE_GITHUB_SSL' con la URL real)
    wget -O /etc/nginx/sites-available/default "URL_DE_GITHUB_SSL"
    curl -L -o /etc/nginx/sites-available/default -k "https://dl.dropboxusercontent.com/scl/fi/wax2io6fewamd6t6lpqzf/default?rlkey=jmv7h8co3sqn4qnj3p6g5a17d&dl=0"

    # Cambiar el nombre del dominio en la configuración
    sed -i "s/server_name dominio/server_name $dominio/g" /etc/nginx/sites-available/default

    # Habilitar el sitio SSL en Nginx
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

    # Reiniciar Nginx para aplicar la configuración
    systemctl restart nginx

    echo "SSL instalado y configurado correctamente para el dominio $dominio."
    sleep 2s
    clear && clear
    source /etc/ivandx/ssl/ssl.sh
}

verificar_estado_squid() {
    if sudo systemctl is-active --quiet squid; then
        squidstatus="ON"
    else
        squidstatus="OFF"
    fi
}

verificar_dropbear() {
    if sudo service dropbear status | grep -q "Active: active (exited)"; then
        dropstatus="ON"
    else
        dropstatus="OFF"
    fi
}

verificar_badvpn() {
    if dir /bin/badvpn | grep -q "/bin/badvpn"; then
        badstatus="ON"
    else
        badstatus="OFF"
    fi
}

salir() {
  menu
  exit 0
}

# Aqui El Texto Del Menu
clear && clear
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AZUL}▶ IP:${RESTAURAR}${CYAN} $ifconfig${RESTAURAR} ${AMARILLO}S.O: $so FECHA: $fecha${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
verificar_estado_squid
verificar_dropbear

while true; do
    echo -e "${CYAN}INSTALADOR DE PROTOCOLOS${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶ ${AMARILLO}BADVPN [$badstatus]${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶ ${AMARILLO}PROXY SQUID [$squidstatus]${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶ ${AMARILLO}DropBear [$dropstatus]${RESTAURAR}"
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
      5) verificarSSL ;;
      0) salir ;;
      *) opcion_invalida ;;

  esac

done
