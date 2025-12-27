#!/bin/bash

# =========================================
# InspectorBin v1.0 - Herramienta de diagnóstico
# Fecha: 2025-12-27
# =========================================

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
MAGENTA="\033[0;35m"
NC="\033[0m" 

mostrar_logo() {
    echo -e "${CYAN}"
    echo " _                           _             _     _       "
    echo "(_)_ __  ___ _ __   ___  ___| |_ ___  _ __| |__ (_)_ __  "
    echo "| | '_ \/ __| '_ \ / _ \/ __| __/ _ \| '__| '_ \| | '_ \ "
    echo "| | | | \__ \ |_) |  __/ (__| || (_) | |  | |_) | | | | |"
    echo "|_|_| |_|___/ .__/ \___|\___|\__\___/|_|  |_.__/|_|_| |_|"
    echo -e "${NC}"
    echo -e "${MAGENTA}         🔍 InspectorBin v1.0 - Herramienta de diagnóstico${NC}\n"

    duration=4
    interval=1
    loops=$((duration / interval))

    for ((i=0;i<loops;i++)); do
        case $((i % 3)) in
            0) puntos=".";;
            1) puntos="..";;
            2) puntos="...";;
        esac
        echo -ne "\r${MAGENTA}Realizando consulta${puntos}${NC}"
        sleep $interval
    done

    echo -e "\r${MAGENTA}Realizando consulta... ¡Listo!${NC}\n"


}



verificar_comando() {
    for cmd in "$@"; do
        echo
        if ! command -v "$cmd" &> /dev/null; then
            echo -e "\n${RED}❌ Error:${NC} El comando '${YELLOW}$cmd${NC}' no existe"
        else
            local ruta
            ruta=$(command -v "$cmd")
            echo -e "\n${GREEN}✅ Comando encontrado:${NC} '${YELLOW}$cmd${NC}' → Ruta: ${CYAN}$ruta${NC}"
        fi
    done
    echo
}

verificar_directorio() {
    local dir_script
    dir_script=$(dirname "$(realpath "$0")")
    echo

    case "$dir_script" in
        /tmp*|/var/tmp*|/dev/shm*)
            echo -e "\n${RED}⚠️ ADVERTENCIA:${NC} El script está en un directorio inseguro: ${YELLOW}$dir_script${NC}"
            ;;
        *)
            echo -e "\n${GREEN}✅ Directorio seguro:${NC} ${CYAN}$dir_script${NC}"
            ;;
    esac
    echo
}

informacion_sistema() {
    echo -e "${MAGENTA}\n==================== INFORMACIÓN DEL SISTEMA ====================${NC}\n"

    echo -e "${BLUE}Usuario actual:${NC} $(whoami)"
    echo -e "${BLUE}Hostname:${NC} $(hostname)"
    echo -e "${BLUE}Sistema operativo:${NC} $(uname -a)"
    echo -e "${BLUE}Versión de Bash:${NC} $(bash --version | head -n1)"
    echo -e "${BLUE}PATH del usuario:${NC} $PATH\n"
    echo -e "${MAGENTA}=================================================================${NC}\n"
}

verificar_permisos() {
    local archivo
    archivo=$(realpath "$0")
    echo
    echo -e "\n${BLUE}Permisos del script:${NC} $(ls -l "$archivo")"
    if [ ! -x "$archivo" ]; then
        echo -e "\n${RED}❌ Advertencia:${NC} El script no es ejecutable"
    else
        echo -e "\n${GREEN}✅ El script es ejecutable${NC}"
    fi
    echo
}

mostrar_ayuda() {

    echo -e "${CYAN}"
    echo " _                           _             _     _       "
    echo "(_)_ __  ___ _ __   ___  ___| |_ ___  _ __| |__ (_)_ __  "
    echo "| | '_ \/ __| '_ \ / _ \/ __| __/ _ \| '__| '_ \| | '_ \ "
    echo "| | | | \__ \ |_) |  __/ (__| || (_) | |  | |_) | | | | |"
    echo "|_|_| |_|___/ .__/ \___|\___|\__\___/|_|  |_.__/|_|_| |_|"
    echo -e "${NC}\n"
    echo -e "${MAGENTA}         🔍 InspectorBin v1.0 - Herramienta de diagnóstico${NC}\n"

    echo -e "${MAGENTA}\n==================== AYUDA DEL SCRIPT ====================${NC}\n"
    echo -e "${BLUE}Uso:${NC} $0 [OPCIONES]\n"
    echo -e "${YELLOW}Opciones disponibles:${NC}\n"
    echo -e "  -v               Verificar la seguridad del directorio del script."
    echo -e "  -c <comando(s)>  Verificar uno o más comandos. Ej: -c ls bash git"
    echo -e "  -i               Mostrar información general del sistema"
    echo -e "  -p               Verificar permisos del script"
    echo -e "  -V               Mostrar versión del script"
    echo -e "  -h               Mostrar esta ayuda detallada\n"
    echo -e "${BLUE}Ejemplos de uso:${NC}\n"
    echo -e "  $0 -v                   # Verifica el directorio del script"
    echo -e "  $0 -c ls bash git       # Verifica varios comandos"
    echo -e "  $0 -i                   # Muestra información del sistema"
    echo -e "  $0 -p                   # Verifica permisos del script"
    echo -e "  $0 -v -c bash -i -p      # Todo junto\n"
    echo -e "${MAGENTA}===========================================================${NC}\n"
    exit 0
}

mostrar_version() {
    echo -e "\n${CYAN}SysCheck v1.0${NC} - Autor: Vilware - Fecha: 2025-12-27"
    echo
    exit 0
}


if [ $# -eq 0 ]; then
    mostrar_ayuda
fi

COMANDOS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c)
            shift
            if [[ $# -eq 0 || "$1" =~ ^- ]]; then
                echo -e "\n${RED}❌ Error:${NC} Debes indicar al menos un comando después de -c"
                exit 1
            fi
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                COMANDOS+=("$1")
                shift
            done
            ;;
        -v|-i|-p|-V|-h)
            OPCIONES+=("$1")
            shift
            ;;
        *)
            echo -e "\n${RED}❌ Opción inválida:${NC} $1"
            mostrar_ayuda
            exit 1
            ;;
    esac
done

mostrar_logo

for opt in "${OPCIONES[@]}"; do
    case "$opt" in
        -v) verificar_directorio ;;
        -i) informacion_sistema ;;
        -p) verificar_permisos ;;
        -V) mostrar_version ;;
        -h) mostrar_ayuda ;;
    esac
done

if [ ${#COMANDOS[@]} -gt 0 ]; then
    verificar_comando "${COMANDOS[@]}"
fi
