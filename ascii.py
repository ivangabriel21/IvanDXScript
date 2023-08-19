import pyfiglet
import os

# Colores disponibles en formato ANSI
COLORES = {
    "rojo": "\033[31m",
    "verde": "\033[32m",
    "amarillo": "\033[33m",
    "azul": "\033[34m",
    "magenta": "\033[35m",
    "cyan": "\033[36m",
    "blanco": "\033[37m"
}

# Restaurar ajustes originales
RESTAURAR = "\033[0m"

# Pide al usuario que ingrese el nombre y el texto
texto = input(f'{COLORES["verde"]}Ingresa el texto para generar arte ASCII:{RESTAURAR} ')

# Pide al usuario que elija un color
print("Elige un color para el texto:")
for color in COLORES.keys():
    print(color)
color_elegido = input("Color: ").lower()

# Verifica si el color elegido es válido
if color_elegido in COLORES:
    # Agrega el color elegido en formato de variable
    color_variable = f'{color_elegido.upper()}="{COLORES[color_elegido]}"'

    # Genera el arte ASCII con el color elegido
    ascii_art = f'{COLORES[color_elegido]}{pyfiglet.figlet_format(texto)}{RESTAURAR}'

    # Ruta del archivo calls
    archivo_calls = "/etc/ivandx/calls"

    # Elimina el contenido actual del archivo calls y escribe el arte ASCII con el color variable
    with open(archivo_calls, "w") as archivo:
        archivo.write(f'{ascii_art}\n')

    print(f"Arte guardado Con el color {color_elegido}")
else:
    print("Color no válido. Saliendo del programa.")
