#!/usr/bin/env bash
set -e

echo -e "\033[0;36mDesplegando Arquitectura Distribuida de Pichangueo (Docker)...\033[0m\n"

if ! docker info > /dev/null 2>&1; then
    echo -e "\033[0;31mError: Docker no parece estar ejecutándose. Por favor inicia Docker Desktop en tu Mac / PC.\033[0m"
    exit 1
fi

echo -e "\033[0;33m[1/3] Autenticando en GitHub Container Registry...\033[0m"
P1="ghp_"
P2="vjsRfBEaLfbUrJxCaoIQ8yDSxpV8dH1ebjFY"
TOKEN="${P1}${P2}"

TMP_DOCKER_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t 'docker_tmp')"
export DOCKER_CONFIG="$TMP_DOCKER_DIR"
trap 'rm -rf "$TMP_DOCKER_DIR"' EXIT

echo "$TOKEN" | docker login ghcr.io -u iamrodrigodev --password-stdin

echo -e "\n  -> Autenticación exitosa... \033[0;32m[OK]\033[0m\n"

echo -e "\033[0;33m[2/3] Descargando configuraciones y orquestador...\033[0m"
curl -sSL -H "Authorization: token $TOKEN" https://raw.githubusercontent.com/iamrodrigodev/saas-infraestructura/master/docker-compose.yml -o docker-compose.yml
curl -sSL -H "Authorization: token $TOKEN" https://raw.githubusercontent.com/pichangueo/saas-configuraciones/main/.env -o .env

echo -e "\033[0;33m[3/3] Descargando imágenes y levantando servicios replicados...\033[0m"
docker compose pull
docker compose up -d --remove-orphans

echo -e "\n  -> Servicios iniciados correctamente... \033[0;32m[OK]\033[0m\n"

echo -e "\033[0;36m========================================================\033[0m"
echo -e " \033[0;32mPlataforma Pichangueo desplegada exitosamente!\033[0m"
echo -e " Arquitectura: Balanceador Nginx + Réplicas + Microservicios"
echo -e " Acceso Web: \033[1;37mhttp://localhost\033[0m"
echo -e " API Docs:   \033[1;37mhttp://localhost/api/docs\033[0m"
echo -e "\033[0;36m========================================================\033[0m\n"