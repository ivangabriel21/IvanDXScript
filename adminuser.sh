#/bin/bash

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

# Restaurar ajustes originales
RESTAURAR="\e[0m"

clear && clear
total_usuarios=$(awk -F: '($3 >= 1000) {print}' /etc/passwd | wc -l)
cat /etc/ivandx/calls
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
echo -e "USER: ${total_usuarios}"
echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

function create_user() {
    read -p "Ingresa el nombre del nuevo usuario: " nuevo_usuario
    sudo useradd "$nuevo_usuario"

    read -s -p "Ingrese la contraseña para ${nuevo_usuario}: " usuario_pass
    echo ""

    echo "$nuevo_usuario:$usuario_pass" | sudo chpasswd

    echo "Usuario '$nuevo_usuario' creado exitosamente con la contraseña especificada." >> /var/log/usuarios_creados.log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Usuario '$nuevo_usuario' creado" >> /var/log/usuarios_creados.log

    read -p "Presiona Enter para continuar..."
    clear  # Limpia la pantalla antes de volver al menú
    bash /etc/ivandx/adminuser.sh
}

function delete_user() {
  read -p "Ingrese el Nombre del Usuario A eliminar: " eliminar_user
  read -p "¿Estás seguro de Eliminar el Usuario $eliminar_user? (y/n): " confirmacion
  if [ "$confirmacion" = "y" ]; then
    echo "Removiendo el usuario $eliminar_user"
    sudo userdel -r "$eliminar_user" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "Usuario '$eliminar_user' eliminado exitosamente."
      read -p "Presiona Enter para continuar..."
      clear  # Limpia la pantalla antes de volver al menú
      bash /etc/ivandx/adminuser.sh
    fi
    fi
}

function read_create() {
  echo "USUARIOS [$(grep -c 'Usuario' /var/log/usuarios_creados.log)]\t\tFecha:\t\t\t\t\tTiempo:"
  echo "=============================================================================="
  
  while IFS= read -r line; do
    if [[ $line == *"Usuario '*'" ]]; then
      usuario=$(echo "$line" | awk -F "'" '{print $2}')
      fecha=$(echo "$line" | awk '{print $1}')
      tiempo=$(echo "$line" | awk '{print $2}')
      printf "%-50s %-35s %-15s\n" "$usuario" "$fecha" "$tiempo"
    fi
  done < /var/log/usuarios_creados.log
  
  read -p "Presiona Enter para continuar..."
  clear && clear
  bash /etc/ivandx/adminuser.sh
}

opcion_invalida() {
 echo -e "Opcion Invalida \c"
 echo ""
 sleep 0,999s
 clear
 bash /etc/ivandx/adminuser.sh
}

while true; do 
    echo -e "🔐 ${CYAN}Opciones de Usuarios SSH${RESTAURAR} 🔐"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"
    echo -e "${GRIS}[1]${RESTAURAR} ▶${AMARILLO} CREAR NUEVO USUARIO SSH${RESTAURAR}"
    echo -e "${GRIS}[2]${RESTAURAR} ▶${VERDE} ELIMINAR USUARIO SSH${RESTAURAR}"
    echo -e "${GRIS}[3]${RESTAURAR} ▶${CYAN} MOSTRAR USUARIOS CREADOS${RESTAURAR}"
    echo -e "${GRIS}[4]${RESTAURAR} ▶ ${FONDO_VERDE}MOSTRAR USUARIOS CONECTADOS${RESTAURAR}"
    echo -e "${GRIS}[5]${RESTAURAR} ▶ ${FONDO_AMARILLO}AGREGAR BANNER DROPBEAR${RESTAURAR}"
    echo -e "${GRIS}[6]${RESTAURAR} ▶ ${ROJO}REGRESAR${RESTAURAR}"
    echo -e "${VERDE}•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••${RESTAURAR}"

    echo -e "${AMARILLO}Selecciona una opción:${RESTAURAR} \c"
    read opcion


  case $opcion in 
      1) create_user ;;
      2) delete_user ;;
      3) read_create ;;
      4) read_connect ;;
      5) banner_vps ;;
      6) return ;;
      0) return ;;
      *) opcion_invalida ;;

  esac

done
