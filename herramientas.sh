#!/bin/bash

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

ascii() {
   echo -e "(NO ESCRIBAS NOMBRE LARGO, PUEDE EXPIRIMENTAR CARGA LENTA DEL SCRIPT O NO ENTRAR)"
   python3 /etc/ivandx/ascii.py
   menu
}

verificar_irparpaya() {
    if [ -d "/etc/ivandx/Irparpaya-a" ]; then
        echo "Irparpaya está instalado en /etc/ivandx."
        ejecutar_script_irparpaya
    else
        echo "Irparpaya no está instalado en /etc/ivandx."
        read -p "¿Deseas descargar Irparpaya ahora? (y/n): " respuesta
        if [ "$respuesta" = "y" ]; then
            descargar_irparpaya
        else
            echo "Operación cancelada."
        fi
    fi
}

ejecutar_script_irparpaya() {
    clear && clear
    echo "Ejecutando Irparpaya..."
    bash /etc/ivandx/Irparpaya-a/real-host-v2.sh
}

descargar_irparpaya() {
    echo "Descargando Irparpaya..."
    apt update
    apt install nmap
    apt install wget
    apt install curl
    apt install git
    git clone https://github.com/HackeRStrategy/Irparpaya-a.git /etc/ivandx/Irparpaya-a
    chmod +x /etc/ivandx/Irparpaya-a/real-host-v2.sh
    if [ $? -eq 0 ]; then
        echo "Irparpaya se ha descargado con éxito en /etc/ivandx."
        echo -e "PRESIONA ENTER PARA CONTINUAR \c"
        read enter
        ejecutar_script_irparpaya
    else
        echo "Hubo un error al descargar Irparpaya."
    fi
}

clear && clear
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "IVANDX HERRAMIENTAS ONLINE"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do
      echo -e "${GRIS}[1]${RESTAURAR} ▶ Cambiar Nombre Del Servidor (ASCII)"
      echo -e "${GRIS}[2]${RESTAURAR} ▶ Scaneo De Host Y Subdominios"
      echo -e "${GRIS}[0]${RESTAURAR} ▶ ${FONDO_ROJO}Regresar${RESTAURAR}"
      echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

      echo -e "${AMARILLO_CLARO}Escoge una opción: \c"
      read opcion

        case $opcion in
          1) ascii ;;
          2) verificar_irparpaya ;;
          0) menu ;;
          *) opcion_invalida ;;

      esac
     done
}
