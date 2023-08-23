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

instalar_dropbear() {
    clear
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO} INSTALANDO DROPBEAR ${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo ""
    echo "Instalando Dropbear SSH..."
    echo -n "Ingrese el puerto para Dropbear (por defecto 442): "
    read puerto
    puerto=${puerto:-442}  # Utiliza 22 por defecto si no se especifica otro puerto

    # Instalar Dropbear SSH
    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install dropbear -y
    # Configurar el puerto en /etc/default/dropbear
    sudo sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=$puerto/" /etc/default/dropbear

    # Iniciar Dropbear SSH
    sudo service dropbear start
    clear
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO} DROPBEAR SE INSTALO CORRECTAMENTE /\${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo "Dropbear SSH se ha instalado y configurado en el puerto $puerto."
    sleep 3s
    clear
    menu
}

# Función para activar Dropbear SSH
activar_dropbear() {
    echo "Activando Dropbear SSH..."
    sudo service dropbear start
    echo "Dropbear SSH se ha activado."
    sleep 2s
    clear
    source /etc/ivandx/dropbear/dropbear.sh
}

# Función para desactivar Dropbear SSH
desactivar_dropbear() {
    echo "Desactivando Dropbear SSH..."
    sudo service dropbear stop
    echo "Dropbear SSH se ha desactivado."
    sleep 2s
    clear
    source /etc/ivandx/dropbear/dropbear.sh
}

# Función para desinstalar Dropbear SSH
desinstalar_dropbear() {
    echo "Desinstalando Dropbear SSH..."
    sudo apt-get remove dropbear --purge > /dev/null 2>&1
    echo "Dropbear SSH se ha desinstalado."
    sleep 2s
    clear
    source /etc/ivandx/dropbear/dropbear.sh
}

cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AMARILLO} INSTALADOR DE DROPBEAR${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do
    echo -e "${CYAN}      BADVPN${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶ ${AMARILLO}Instalar DROPBEAR${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶ ${AMARILLO}ACTIVAR DROPBEAR${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶ ${AMARILLO}DESACTIVAR DROPBEAR${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ ${AMARILLO}DESINSTALAR DROPBEAR${RESTAURAR}"
    echo -e "${GRIS}[0]${RESTAURAR} ▶ ${ROJO}REGRESAR${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

    echo -e "${AMARILLO}Selecciona una opción:${RESTAURAR} \c"
    read opcion

    case $opcion in
        1)
            instalar_dropbear
            ;;
        2)
            activar_dropbear
            ;;
        3)
            desactivar_dropbear
            ;;
        4)
            desinstalar_dropbear
            ;;
        0)
            menu
            ;;
    esac
done
