#!/usr/bin/env bash

group=0

# Procesar el primer argumento si es -g
if [ "$1" = '-g' ]; then
    group=1
    shift
fi

# Verificar número de argumentos
if [ $# -ne 2 ]; then
    echo 'Wrong number of arguments. Usage: ./wsaction.sh [-g] <dispatcher> <workspace>'
    exit 1
fi

# Obtener espacio de trabajo activo
active_ws=$(hyprctl activeworkspace -j | jq -r '.id')

if [ $group -eq 1 ]; then
    # Mover a grupo
    hyprctl dispatch "$1" $(( (($2 - 1) * 10 + $active_ws % 10) ))
else
    # Mover a espacio de trabajo en grupo
    hyprctl dispatch "$1" $(( (($active_ws - 1) / 10) * 10 + $2 ))
fi 