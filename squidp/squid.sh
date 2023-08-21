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

# Instaladores De Squid PROXY

instalar_Squid() {
    echo "Instalando Squid Proxy..."

    # Verificar si Squid ya está instalado
    if ! command -v squid &> /dev/null; then
        sudo apt-get update &> /dev/null
        sudo apt-get install squid
        clear && clear
    else
        echo "Squid Proxy ya está instalado."
        sleep 2s
        clear && clear
    fi

    # Configurar los puertos de Squid

    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO}⭐INSTALANDO PROXY SQUID ⭐${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo ""
    echo -e "Ingrese los puertos para Squid (por defecto 3128): \c" 
    read puertos
    puertos=${puertos:-3128}

    # Crear una configuración personalizada para Squid
    echo "http_port $puertos" | sudo tee /etc/squid/squid.conf

    # Habilitar la autenticación básica en Squid
    sudo sed -i 's/#auth_param/auth_param/' /etc/squid/squid.conf
    sudo sed -i 's/#acl auth_users/acl auth_users proxy_auth REQUIRED/' /etc/squid/squid.conf
    sudo sed -i 's/#http_access allow auth_users/http_access allow auth_users/' /etc/squid/squid.conf

    # Reiniciar Squid para aplicar cambios
    sudo service squid restart

    echo "Squid Proxy se ha instalado y configurado en el puerto $puertos con autenticación."
    clear && clear
    source /etc/ivandx/squidp/squid.sh
}

crear_usuario_squid() {
    read -p "Ingrese el nombre de usuario: " usuario
    read -sp "Ingrese la contraseña para el usuario: " contraseña
    echo
    echo "$usuario:$contraseña" | sudo tee -a /etc/squid/passwd
    sudo service squid reload
    echo "Usuario $usuario creado y configurado para autenticación en Squid."
    sleep 2s
    clear
    source /etc/ivandx/squidp/squid.sh
}

# Función para eliminar un usuario Squid Proxy
eliminar_usuario_squid() {
    read -p "Ingrese el nombre de usuario que desea eliminar: " usuario
    sudo sed -i "/$usuario/d" /etc/squid/passwd
    sudo service squid reload
    echo "Usuario $usuario eliminado de la configuración de Squid."
    sleep 2s
    clear
    source /etc/ivandx/squidp/squid.sh
}

activar_proxy() {
    echo "Activando Squid Proxy..."
    sudo service squid start
    echo "Squid Proxy se ha activado."
    sleep 2s
    clear
    source /etc/ivandx/squidp/squid.sh
}

# Función para desactivar Squid Proxy
desactivar_proxy() {
    echo "Desactivando Squid Proxy..."
    sudo service squid stop
    echo "Squid Proxy se ha desactivado."
    sleep 2s
    clear
    source /etc/ivandx/squidp/squid.sh
}

# Función para desinstalar Squid Proxy
desinstalar_Squid() {
    echo "Desinstalando Squid Proxy..."
    sudo apt-get remove --purge squid
    sudo apt-get autoremove
    echo "Squid Proxy se ha desinstalado."
    sleep 2s
    clear
    source /etc/ivandx/squidp/squid.sh
}
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${CYAN} INSTALADOR DEL PROXY SQUID ${RESTAURAR}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

while true; do
    echo -e "${CYAN}    PROXY SQUID${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶ ${AMARILLO}Instalar PROXY SQUID${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶ ${AMARILLO}ACTIVAR PROXY SQUID${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶ ${AMARILLO}DESACTIVAR PROXY SQUID${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ ${AMARILLO}CREAR NUEVO USUARIO SQUID${RESTAURAR}"
    echo -e "${GRIS}[5]${RESTAURAR} ▶ ${AMARILLO}ELIMINAR USUARIO SQUID${RESTAURAR}"
    echo -e "${GRIS}[6]${RESTAURAR} ▶ ${AMARILLO}DESINSTALAR PROXY SQUID${RESTAURAR}"
    echo -e "${GRIS}[0]${RESTAURAR} ▶ ${ROJO}REGRESAR${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

    echo -e "${AMARILLO}Selecciona una opción:${RESTAURAR} \c"
    read opcion


  case $opcion in
      1) instalar_Squid ;;
      2) activar_proxy ;;
      3) desactivar_proxy ;;
      4) crear_usuario_squid ;;
      5) eliminar_usuario_squid ;;
      6) desinstalar_Squid ;;
      0) menu ;;
      *) opcion_invalida ;;

  esac

done
