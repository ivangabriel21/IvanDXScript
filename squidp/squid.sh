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
        source /etc/ivandx/squidp/squid.sh
        return
    fi

    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${AMARILLO}⭐ACTUALIZADOR DE LA SCRIPT IVANDX⭐${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo ""
    echo -e "Ingrese los puertos para Squid (por defecto 3128): \c" 
    read -a puertos_array  # Leer los puertos como un array

    # Verificar si los puertos están en uso
    puerto_en_uso=false
    for puerto in "${puertos_array[@]}"; do
        sudo netstat -tuln | grep ":$puerto " &> /dev/null
        if [ $? -eq 0 ]; then
            echo "El puerto $puerto está en uso. Intenta con otro puerto."
            puerto_en_uso=true
            sleep 2s
        fi
    done

    if [ "$puerto_en_uso" = true ]; then
        echo "No se pudo instalar Squid debido a conflictos de puerto."
        sleep 2s
    else
        # Crear una configuración personalizada para Squid
        for puerto in "${puertos_array[@]}"; do
            echo "http_port $puerto" | sudo tee -a /etc/squid/squid.conf
        done

        # Habilitar la autenticación básica en Squid
        sudo sed -i 's/#auth_param/auth_param/' /etc/squid/squid.conf
        sudo sed -i 's/#acl auth_users/acl auth_users proxy_auth REQUIRED/' /etc/squid/squid.conf
        sudo sed -i 's/#http_access allow auth_users/http_access allow auth_users/' /etc/squid/squid.conf

        # Reiniciar Squid para aplicar cambios
        sudo service squid restart

        echo "Squid Proxy se ha instalado y configurado en los puertos: ${puertos_array[*]} con autenticación."
    fi

    clear && clear
    source /etc/ivandx/squidp/squid.sh
}

# Función para crear un usuario Squid Proxy
crear_usuario_squid() {
    read -p "Ingrese el nombre de usuario: " usuario
    read -sp "Ingrese la contraseña para el usuario: " pass
    echo
    echo "$usuario:$pass" | sudo tee -a /etc/squid/passwd

    # Verificar si Squid está activo
    if sudo systemctl is-active --quiet squid; then
        # Recargar Squid para aplicar cambios si está activo
        sudo service squid reload
    else
        # Si Squid no está activo, iniciar el servicio
        echo -e "Proxy Squid No Esta Activado Para Crear el Usuario"
        sleep 2s
        clear && clear
        source /etc/ivandx/squidp/squid.sh
    fi

    echo "Usuario $usuario creado y configurado para autenticación en Squid."
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
