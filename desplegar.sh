#!/usr/bin/env bash
set -e

echo -e "\033[0;36mDesplegando Imagen para la tarea de Arquitectura de Aplicaciones Web...\033[0m\n"

if ! docker info > /dev/null 2>&1; then
    echo -e "\033[0;31mError: Docker no parece estar ejecutandose. Por favor inicia Docker Desktop / Engine.\033[0m"
    exit 1
fi

if [ -z "$TOKEN" ]; then
    read -rsp "Ingrese su Token de GitHub (o presione Enter si la imagen es publica): " TOKEN
    echo ""
fi

if [ -n "$TOKEN" ]; then
    echo -e "\033[0;33m[1/2] Autenticacion en GitHub Container Registry...\033[0m"
    if ! echo "$TOKEN" | docker login ghcr.io -u iamrodrigodev --password-stdin > /dev/null 2>&1; then
        echo -e "  -> \033[0;31mError: No se pudo iniciar sesion. Verifique el token.\033[0m"
        exit 1
    fi
    echo -e "  -> Sesion iniciada correctamente... \033[0;32m[OK]\033[0m\n"
fi

echo -e "\033[0;33m[2/2] Descargando y levantando aplicacion...\033[0m"
docker stop pichangueo > /dev/null 2>&1 || true
docker rm pichangueo > /dev/null 2>&1 || true
docker run -d -p 80:80 --name pichangueo ghcr.io/pichangueo/pichangueo-plataforma:latest

echo -e "  -> Contenedor iniciado correctamente... \033[0;32m[OK]\033[0m\n"

echo -e "\033[0;36m========================================================\033[0m"
echo -e " \033[0;32mPlataforma Pichangueo desplegada exitosamente!\033[0m"
echo -e " Acceso Web: \033[1;37mhttp://localhost\033[0m"
echo -e " API Docs:   \033[1;37mhttp://localhost/api/docs\033[0m"
echo -e "\033[0;36m========================================================\033[0m\n"
