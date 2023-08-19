#!/bin/bash
# Creado: 13/11/2018
# Actualizado: 12/01/2019
# Por: Real Strategy
# Actualización exitosa
# MENSAJE: Nunca dejes de aprender, si estás aquí es por curiosidad y para aprender shell o bash con la ayuda de la búsqueda en Google, entre otros. Te llevará tiempo, pero aprenderás aunque edites.
clear
while :
do
    # Menú banner
    clear
    echo -e "\e[1;33m(98/8)\e[1;32m"
    echo "    __  __           __     ______     __                  __             "
    echo "   / / / /___  _____/ /_   / ____/  __/ /__________  _____/ /_____  _____ "
    echo "  / /_/ / __ \/ ___/ __/  / __/ | |/_/ __/ ___/ __ \/ ___/ __/ __ \/ ___/ "
    echo " / __  / /_/ (__  ) /_   / /____>  </ /_/ /  / /_/ / /__/ /_/ /_/ / /     "
    echo "/_/ /_/\____/____/\__/  /_____/_/|_|\__/_/   \__,_/\___/\__/\____/_/      "
    echo -e "\e[1;33mV= 2.0                    (99) Español                    (98) Inglés     "
    echo ""
    echo -e "\e[1;31m[1]\e[1;32m EXTRACTOR DE HOSTS Y SSL"
    echo -e "\e[1;31m[2]\e[1;32m MOSTRAR ESTADO DE SITIOS WEB"
    echo -e "\e[1;31m[3]\e[1;32m GUARDAR HOSTS EXTRAÍDOS"
    echo -e "\e[1;31m[4]\e[1;32m CREAR PAYLOAD FUNCIONAL"
    echo -e "\e[1;31m[5]\e[1;32m VER PUERTOS DE HOST Y SITIOS WEB"
    echo -e "\e[1;31m[6]\e[1;32m VER HOSTS Y SITIOS WEB A TRAVÉS DE UN PROXY"
    echo -e "\e[1;31m[7]\e[1;32m USAR HOST MANUAL"
    echo -e "\e[1;31m[8]\e[1;32m MENSAJE DEL CREADOR"
    echo -e "\e[1;31m[0]\e[1;32m Regresar"
    echo ""
    echo -e "\e[1;36m"
    echo -n "Elige una opción: "
    read opcion

    # Lista de menú
    echo -e "\e[0m"
    case $opcion in
    1)
        echo ""
        echo -n "HOST: "
        read HOST
        bash /etc/ivandx/parpaya-a/.scan.sh $HOST
        echo ""
        echo -e "\e[0m"
        echo -e "\e[1;31mPresiona Enter para continuar con el script...!\e[0m"
        read foo
        ;;
    2)
        echo ""
        echo "Mostrando el estado de los sitios web..."
        echo ""
        bash /etc/ivandx/parpaya-a/.status.sh
        echo ""
        echo -e "\e[1;31mPresiona Enter para continuar con el script...\e[0m"
        read foo
        ;;
    3)
        echo ""
        echo -e "\e[1;33mPega el host para mostrar el estado\e[0m"
        echo -e "\e[1;31mRecuerda CTRL + C para salir\e[0m"
        echo -e "\e[1;36mHOST: \e[0m"
        cat > lista-host.txt
        ;;
    4)
        clear
        bash /etc/ivandx/parpaya-a/.payloads.ingles
        read foo
        ;;
    5)
        echo ""
        echo -ne "\e[1;31m DOMINIO(IP/WEB): "
        read MAIN
        echo -ne "\e[1;31m PUERTO(53,80):  "
        read RTS
        sleep 2
        echo -e "\e[1;32m"
        nmap -p $RTS $MAIN
        read foo
        ;;
    6)
        echo -ne "\e[1;31mSITIO WEB/IP: "
        read WEB
        echo ""
        echo -e "\e[1;32m"
        curl https://api.hackertarget.com/geoip/?q=$WEB
        read foo
        ;;
    7)
        clear
        echo -e "\e[1;32mLee todo para el uso adecuado de la herramienta..."
        sleep 2.5
        cat manualES.txt
        read foo
        ;;
    12.25)
        clear
        echo -e "\e[1;32mIngresando al menú secreto..."
        sleep 2
        bash /etc/ivandx/parpaya-a/._
        read foo
        ;;
    8)
        echo ""
        echo -e "\e[1;33mCRÉDITOS AL DESARROLLADOR\e[0m"
        echo ""
        echo -e "\e[1;31mDesarrollador: @RealStrategy y el grupo VIP RS"
        echo -e "\e[1;32m"
        echo "YOUTUBE : https://youtube.com/RealHackRWAM "
        echo "TELEGRAM: https://t.me/RealHackRWAM "
        echo "TELEGRAM: https://t.me/RealStrategyRS "
        echo "FACEBOOK: https://m.facebook.com/groups/142565756559228 "
        echo "FACEBOOK: https://m.facebook.com/RealHackRWAM "
        echo ""
        echo -e "\e[1;31mMENSAJE DE RS\e[0m"
        echo ""
        echo -e "\e[1;36mNunca dejes de aprender... :)\e[0m"
        echo ""
        read foo
        ;;
    98)
        clear
        echo "Traduciendo al idioma inglés..."
        sleep 3
        bash /etc/ivandx/parpaya-a/real-host-v2.sh
        ;;
    99)
        clear
        echo "Traduciendo al idioma español..."
        sleep 3
        bash /etc/ivandx/parpaya-a/.real-host.sh
        ;;
    0)
        clear
        menu
        ;;
    *)
        clear
        echo "Comando inválido..."
        sleep 1.5
        ;;
    esac
done
