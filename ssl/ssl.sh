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
ROJO_OS="\033[31m"

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

# Restaurar ajustes originales
RESTAURAR="\e[0m"

salir() {
    menu
    exit 0
}

refresh() {
    clear
    source /etc/ivandx/ssl/ssl.sh
}

function activarSSL() {
    # Verificar si SSL ya está activado
    if [ -e /etc/nginx/sites-available/default ]; then
        # Verificar si ya está habilitado
        if [ -e /etc/nginx/sites-enabled/default ]; then
            echo "La configuración SSL ya está activada y habilitada."
            sleep 2s
            clear
            source /etc/ivandx/ssl/ssl.sh
        else
            # Habilitar el sitio SSL en Nginx
            ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

            # Reiniciar Nginx para aplicar la configuración
            systemctl restart nginx

            echo "La configuración SSL ha sido habilitada en Nginx."
            sleep 2s
            clear
            source /etc/ivandx/ssl/ssl.sh
        fi
    else
        echo "La configuración SSL no está presente. Por favor, configura SSL primero."
        sleep 3s
        clear
        source /etc/ivandx/ssl/ssl.sh
    fi
}

function desactivarSSL() {
    # Verificar si SSL ya está desactivado
    if [ ! -e /etc/nginx/sites-available/default ]; then
        echo "SSL ya está desactivado."
        sleep 2s
        clear
        source /etc/ivandx/ssl/ssl.sh
    fi

    # Deshabilitar el sitio SSL en Nginx
    rm /etc/nginx/sites-enabled/default

    # Reiniciar Nginx para aplicar la configuración
    systemctl restart nginx

    # Eliminar los archivos de certificado y clave

    echo "SSL ha sido desactivado."
    sleep 2s
    clear
    source /etc/ivandx/ssl/ssl.sh
}

#!/bin/bash

function desinstalarSSL() {
    # Solicitar confirmación para desinstalar SSL
    read -p "¿Estás seguro de desinstalar SSL? (y/n): " confirmacion
    if [ "$confirmacion" != "Y" ] && [ "$confirmacion" != "y" ]; then
        echo "Desinstalación de SSL cancelada."
        sleep 2s
        clear
        source /etc/ivandx/protocolos.sh
    fi

    # Solicitar confirmación para desinstalar Nginx
    read -p "¿Estás seguro de desinstalar Nginx? (y/n): " confirmacion
    if [ "$confirmacion" != "Y" ] && [ "$confirmacion" != "y" ]; then
        echo "Desinstalación de Nginx cancelada."
        sleep 2s
        clear
        source /etc/ivandx/ssl/ssl.sh
    fi

    # Desinstalar paquetes relacionados con SSL
    apt-get remove --purge -y openssl
    apt-get autoremove --purge -y

    # Eliminar archivos de configuración y directorios
    rm -rf /etc/ssl

    echo "SSL ha sido desinstalado y los archivos de configuración han sido eliminados."
    sleep 2s
    clear
    source /etc/ivandx/ssl/ssl.sh
}

verif_ptrs() {
    PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
    port_count=0
    ports=""

    for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
        svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
        ports="${ports}${svcs}: ${AMARILLO}${pton}${RESTAURAR}\t"

        ((port_count++))

        # Mostrar dos puertos por línea
        if [ $((port_count % 2)) -eq 0 ]; then
            echo -e "$ports"
            ports=""
        fi
    done

    # Mostrar el último puerto si no se ha mostrado ya
    if [ -n "$ports" ]; then
        echo -e "$ports"
    fi
}

cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
echo -e "▶ IP:${ROJO_OS} $ifconfig${RESTAURAR} S.O: ${ROJO_OS}$so${RESTAURAR} FECHA: ${ROJO_OS}$fecha${RESTAURAR}" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
verif_ptrs
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AMARILLO}⭐Instalador Y Configurador De SSL⭐${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do

      echo -e "${GRIS}[1]${RESTAURAR} ▶${BLANCO} ACTIVAR SSL${RESTAURAR}"
      echo -e "${GRIS}[2]${RESTAURAR} ▶${VERDE} DESACTIVAR SSL${RESTAURAR}"
      echo -e "${GRIS}[3]${RESTAURAR} ▶${AZUL} DESINSTALAR SSL${RESTAURAR}"
      echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

      echo -e "${AMARILLO_CLARO}Escoge una opción: \c"
      read opcion

        case $opcion in
          1) activarSSL ;;
          2) desactivarSSL ;;
          3) desinstalarSSL ;;
          0) salir  ;;
          6) refresh
      esac
     done