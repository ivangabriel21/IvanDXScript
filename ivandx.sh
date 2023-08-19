#/bin/bash

# Colores de texto
NEGRO="\e[30m"
ROJO="\e[31m"
VERDE="\e[32m"
AMARILLO="\e[33m"
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
        echo -e "\033[1;37m$svcs\033[0m: \033[1;33m$pton"
    done
 }

clear && clear 
ifconfig=$(curl -s ifconfig.me) 
so=$(uname -s) fecha=$(date "+%d-%m-%Y %H:%M:%S") puertos_en_uso=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d ':' -f2)
total_ram=$(free -m | grep -i "mem:" | awk '{print $2}') 
libre_ram=$(free -m | grep -i "mem:" | awk '{print $7}')
usada_ram=$(free -m | grep -i "mem:" | awk '{print $3}') 
uso_ram=$(free | awk 'NR==2{printf "%.2f", $3/$2*100}') 
uso_cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')
cache_usada=$(free -m | grep -i "mem:" | awk '{print $6}')
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
echo -e "${ROJO}▶ IP:${RESTAURAR}${AZUL} $ifconfig${RESTAURAR} S.O: $so FECHA: $fecha" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
verif_ptrs
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AMARILLO}⭐${RESTAURAR} IVANDX ${AMARILLO}⭐ ${RESTAURAR}ESTAS EN LA VERSION : "VERSION"" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
echo -e "▶ TOTAL: $total_ram ▶ LIBRE: ${libre_ram}M ▶ USADA: $usada_ram" 
echo -e "▶ Uso RAM: ${uso_ram}% ▶ Uso CPU: ${uso_cpu}% Cache: ${cache_usada}M" 
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}" 
function administrar_usuarios() {
    echo "Ejecutando el script de administración de usuarios..."
    bash /etc/ivandx/adminuser.sh
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

while true; do 
    echo -e "${GRIS}[1]${RESTAURAR} ▶${AZUL} ADMINISTRAR USUARIOS${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶${AMARILLO} HERRAMIENTAS${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶${ROJO} [!] REMOVE SCRIPT IVANDX${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ EJECUTAR LA SCRIPT AL ENTRAR"
    echo -e "${GRIS}[5]${RESTAURAR} ▶ INSTALAR PUERTOS"
    echo -e "${GRIS}[6]${RESTAURAR} ▶ SALIR DE LA SCRIPT"
    echo -e "${GRIS}[7]${RESTAURAR} ▶ Actualizar Script"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

read -p "Escoge una opción: " opcion

    case $opcion in
        1) administrar_usuarios ;;
        2) herramientas ;; 
        3) borrar_script ;;
	4) ejecutar_iniciar ;;
        5) protocolos ;;
        6) echo "Saliendo de la Script" ; break ;;
        0) echo "Saliendo de la Script" ; break ;;
        *) opcion_invalida ;;

    esac
done
