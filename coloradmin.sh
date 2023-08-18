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

# Estilos de texto
NEGRITA="\e[1m"
SUBRAYADO="\e[4m"
INVERTIDO="\e[7m"

# Restaurar ajustes originales
RESTAURAR="\e[0m"

clear && clear
ifconfig=$(curl -s ifconfig.me)
so=$(uname -s)
fecha=$(date "+%d-%m-%Y %H:%M:%S")
puertos_en_uso=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d ':' -f2)
total_ram=$(free -m | grep -i "mem:" | awk '{print $2}')
libre_ram=$(free -m | grep -i "mem:" | awk '{print $7}')
usada_ram=$(free -m | grep -i "mem:" | awk '{print $3}')
uso_ram=$(free | awk 'NR==2{printf "%.2f", $3/$2*100}')
uso_cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')
cache_usada=$(free -m | grep -i "mem:" | awk '{print $6}')

echo -e "${AZUL}"
cat /etc/ivandx/calls
echo -e "${RESTAURAR}"

echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "▶ IP: $ifconfig S.O: $so FECHA: $fecha"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "Puertos En Mantenimiento"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "${AMARILLO}⭐${RESTAURAR} IVANDX ${AMARILLO}⭐ ${RESTAURAR}ESTAS EN LA VERSION : \"VERSION\""
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

function administrar_usuarios() {
    echo -e "${CYAN}Ejecutando el script de administración de usuarios...${RESTAURAR}"
    bash /etc/ivandx/adminuser.sh
}

function borrar_script() {
    read -p "$(echo -e ${ROJO}¿Estás seguro de remover el script? (y/n):${RESTAURAR} )" confirmacion
    if [ "$confirmacion" = "y" ]; then
        echo -e "${ROJO}Removiendo el script...${RESTAURAR}"
        $(rm -rf /etc/ivandx/)
        exit
    else
        echo -e "${VERDE}Operación cancelada.${RESTAURAR}"
    fi
}

function opcion_invalida() {
    echo -e "${ROJO}Opción inválida, por favor selecciona una opción válida.${RESTAURAR}"
}

while true; do
    echo -e "${NEGRITA}[1] ▶ ADMINISTRAR USUARIOS"
    echo -e "▶2 HERRAMIENTAS"
    echo -e "▶3 REMOVE SCRIPT IVANDX"
    echo -e "▶4 EJECUTAR LA SCRIPT AL ENTRAR"
    echo -e "▶5 INSTALAR PUERTOS"
    echo -e "▶6 SALIR DE LA SCRIPT${RESTAURAR}"

    read -p "$(echo -e ${AMARILLO}Escoge una opción: ${RESTAURAR})" opcion

    case $opcion in
        1) administrar_usuarios ;;
        2) herramientas ;;
        3) borrar_script ;;
        4) ejecutar_iniciar ;;
        5) protocolos ;;
        6) echo -e "${AMARILLO}Saliendo de la Script${RESTAURAR}" ; exit ;;
        0) echo -e "${AMARILLO}Saliendo de la Script${RESTAURAR}" ; exit ;;
        *) opcion_invalida ;;
    esac
done
