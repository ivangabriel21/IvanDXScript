#/bin/bash

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

# Restaurar ajustes originales
RESTAURAR="\e[0m" 

verif_ptrs() {
    PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
    for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
        svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
        echo -e "${CYAN}$svcs${RESTAURAR}: ${AMARILLO}$pton${RESTAURAR}"
    done
 }


clear && clear 
ifconfig=$(curl -s ifconfig.me) 
so=$(uname -s) fecha=$(date "+%d-%m-%Y %H:%M:%S") 
total_ram=$(free -m | grep -i "mem:" | awk '{print $2}') 
libre_ram=$(free -m | grep -i "mem:" | awk '{print $7}')
usada_ram=$(free -m | grep -i "mem:" | awk '{print $3}') 
uso_ram=$(free | awk 'NR==2{printf "%.2f", $3/$2*100}') 
uso_cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')
cache_usada=$(free -m | grep -i "mem:" | awk '{print $6}')
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
echo -e "${AZUL}▶ IP:${RESTAURAR}${CYAN} $ifconfig${RESTAURAR} ${AMARILLO}S.O: $so FECHA: $fecha${RESTAURAR}" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
verif_ptrs
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AMARILLO}⭐IVANDX${RESTAURAR}${AMARILLO}⭐ ${RESTAURAR}${VERDE}ESTAS EN LA VERSION :${RESTAURAR} 1.0 " 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
echo -e "\e[33m▶ TOTAL: $total_ramM ▶ LIBRE: ${libre_ram}M ▶ USADA: $usada_ram" 
echo -e "▶ Uso RAM: ${uso_ram}% ▶ Uso CPU: ${uso_cpu}% Cache: ${cache_usada}M" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 

function administrar_usuarios() {
    echo "Ejecutando el script de administración de usuarios..."
    source /etc/ivandx/adminuser.sh
}

function borrar_script() {
    read -p "¿Estás seguro de remover el script? (y/n): " confirmacion
    if [ "$confirmacion" = "y" ]; then
        echo "Removiendo el script..."
        $(rm -rf /etc/ivandx/)
        exit
    else
        echo "Operación cancelada."
    fi
}

function opcion_invalida() { 
  echo "Opción inválida, por favor selecciona una opción válida."
}

obtener_version_desde_github() {
    # URL de GitHub
    local url="https://raw.githubusercontent.com/ivangabriel21/IvanDXScript/main/info"

    # Utiliza curl para obtener el contenido del archivo
    local contenido=$(curl -s "$url")

    # Busca la línea que contiene "version:" y extrae la versión
    local version_github=$(echo "$contenido" | grep -o "version:[[:space:]]*[0-9.]*" | cut -d ':' -f 2 | tr -d '[:space:]')

    # Compara la versión con la versión almacenada localmente
    local version_local=$(cat /etc/ivandx/info/version)

    if [ -n "$version_github" ] && [ "$version_github" != "$version_local" ] && [ "$(echo "$version_github > $version_local" | bc -l)" -eq 1 ]; then
        return 0 # La versión en GitHub es mayor que la versión local
    else
        return 1 # La versión en GitHub no es mayor que la versión local
    fi
}

nodis_version() {
  echo ""
  echo -e "${AMARILLO}No Hay Version Disponible En Este momento"
  echo -e "Presiona Enter Para Regresar al Script${RESTAURAR} \c"
  read enter
  menu
}

mostrar_menu() {
   local salir=false

   while ! $salir; do 
      echo -e "${GRIS}[1]${RESTAURAR} ▶${AZUL} ADMINISTRAR USUARIOS${RESTAURAR}"
      echo -e "${GRIS}[2]${RESTAURAR} ▶${AMARILLO} HERRAMIENTAS${RESTAURAR}"
      echo -e "${GRIS}[3]${RESTAURAR} ▶${ROJO} [!] REMOVE SCRIPT IVANDX${RESTAURAR}"
      echo -e "${GRIS}[4]${RESTAURAR} ▶ ${FONDO_VERDE}EJECUTAR LA SCRIPT AL ENTRAR${RESTAURAR}"
      echo -e "${GRIS}[5]${RESTAURAR} ▶ ${AMARILLO}PROTOCOLOS"
      echo -e "${GRIS}[6]${RESTAURAR} ▶ ${FONDO_AMARILLO}Actualizar Script${RESTAURAR}"
      echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

      echo -e "${AMARILLO_CLARO}Escoge una opción: \c"
      read opcion

      if obtener_version_desde_github; then
         echo -e "${GRIS}[7]${RESTAURAR} ▶${VERDE} ACTUALIZAR SCRIPT${RESTAURAR}"
      fi

        case $opcion in
          1) administrar_usuarios ;;
          2) herramientas ;; 
          3) borrar_script ;;
          4) ejecutar_iniciar ;;
          5) protocolos ;;
          6) echo "Saliendo de la Script" ; exit ;;
          7) if obtener_version_desde_github; then actualizar_script; else nodis_version; fi ;;
          0) echo "Saliendo de la Script" ; salir=true ;;
          *) opcion_invalida ;;

      esac
     done
}

actualizar_script() {
    echo "Realizando la actualización..."
    # Aquí puedes agregar el código para actualizar tu script desde GitHub.
    # Esto podría incluir la descarga del nuevo script y la sobrescritura del script actual.
    echo "Script actualizado con éxito."
}

mostrar_menu
