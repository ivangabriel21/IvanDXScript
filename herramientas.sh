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
    if [ -d "/etc/ivandx/parpaya-a" ]; then
        echo "Irparpaya está instalado."
        ejecutar_script_irparpaya
    else
        echo "Irparpaya no está instalado."
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
    bash /etc/ivandx/parpaya-a/real-host-v2.sh
}

descargar_irparpaya() {
    echo "Descargando Irparpaya..."
    apt update
    apt install nmap
    apt install wget
    apt install curl
    apt install git
    https://github.com/ivangabriel21/IvanDXScript/tree/main/parpaya-a /etc/ivandx/parpaya-a
    chmod +x /etc/ivandx/parpaya-a/real-host-v2.sh
    if [ $? -eq 0 ]; then
        echo "Irparpaya se ha descargado con éxito en /etc/ivandx."
        echo -e "PRESIONA ENTER PARA CONTINUAR \c"
        read enter
        ejecutar_script_irparpaya
    else
        echo "Hubo un error al descargar Irparpaya."
    fi
}

fix_root() {
    if ! dpkg -l | grep -q "openssh-server"; then
        sudo apt-get update
        sudo apt-get install openssh-server
    fi
    if systemctl --version &>/dev/null; then
        # Utiliza systemctl si está disponible
        sudo systemctl start ssh
    else
        # Utiliza service si systemctl no está disponible
        sudo service ssh start
    fi
    cp /etc/ivandx/sshd_config /etc/ssh/sshd_config
    if systemctl --version &>/dev/null; then
        # Utiliza systemctl si está disponible
        sudo systemctl restart ssh
    else
        # Utiliza service si systemctl no está disponible
        sudo service ssh restart
    fi
   echo "ROOT FIXEADO CORRECTAMENTE"
   echo -e "Deseas ponerle una Contraseña Al Root ? (y/n) \c"
   read passroot
   if [ "$passroot" = "y" ]; then
     sudo passwd root
     echo "Contraseña Cambiada, Regresando A La Script ..."
     sleep 1
     menu
   else
     echo "Regresando A La Script"
     sleep 1
     menu
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
      echo -e "${GRIS}[3]${RESTAURAR} ▶ Fix Root (Quitar Acceso Con Achivo Key)"
      echo -e "${GRIS}[0]${RESTAURAR} ▶ ${FONDO_ROJO}Regresar${RESTAURAR}"
      echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

      echo -e "${AMARILLO_CLARO}Escoge una opción: \c"
      read opcion

        case $opcion in
          1) ascii ;;
          2) verificar_irparpaya ;;
          3) fix_root ;;
          0) menu ;;
          *) opcion_invalida ;;

      esac
     done
}
