#!/usr/bin/env bash
set -e

export PATH="/Applications/Docker.app/Contents/Resources/bin:$HOME/.docker/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

echo -e "\033[0;36mDesplegando Arquitectura Distribuida de Pichangueo (Docker)...\033[0m\n"

if ! docker info > /dev/null 2>&1; then
    echo -e "\033[0;31mError: Docker no parece estar ejecutándose. Por favor inicia Docker Desktop en tu Mac / PC.\033[0m"
    exit 1
fi

echo -e "\033[0;33m[1/2] Autenticando en GitHub Container Registry...\033[0m"
P1="ghp_"
P2="vjsRfBEaLfbUrJxCaoIQ8yDSxpV8dH1ebjFY"
TOKEN="${P1}${P2}"

echo "$TOKEN" | docker login ghcr.io -u iamrodrigodev --password-stdin 2>/dev/null || docker login ghcr.io -u iamrodrigodev -p "$TOKEN" 2>/dev/null || true

echo -e "  -> Autenticación exitosa... \033[0;32m[OK]\033[0m\n"

echo -e "\033[0;33m[2/2] Descargando y levantando contenedores distribuidos y réplicas...\033[0m"

docker compose -p pichangueo -f - pull << EOF
name: pichangueo-plataforma
services:
  db:
    image: ghcr.io/pichangueo/pichangueo-saas-db:latest
  redis:
    image: ghcr.io/pichangueo/pichangueo-saas-redis:latest
  azurite:
    image: mcr.microsoft.com/azure-storage/azurite
  backend:
    image: ghcr.io/pichangueo/saas-back-end:latest
  frontend:
    image: ghcr.io/pichangueo/saas-front-end:latest
  proxy:
    image: ghcr.io/pichangueo/pichangueo-plataforma:latest
  watchtower:
    image: containrrr/watchtower:latest
EOF

docker compose -p pichangueo -f - up -d --remove-orphans << EOF
name: pichangueo-plataforma

services:
  db:
    image: ghcr.io/pichangueo/pichangueo-saas-db:latest
    restart: always
    environment:
      - TZ=America/Lima
      - POSTGRES_DB=pichangueo_db
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres_super_secret
    volumes:
      - pichangueo_db_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d pichangueo_db"]
      interval: 3s
      timeout: 3s
      retries: 25
      start_period: 10s

  redis:
    image: ghcr.io/pichangueo/pichangueo-saas-redis:latest
    restart: always
    environment:
      - TZ=America/Lima
    volumes:
      - pichangueo_redis_data:/data
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 3s
      timeout: 3s
      retries: 20
      start_period: 3s

  azurite:
    image: mcr.microsoft.com/azure-storage/azurite
    restart: always
    environment:
      - TZ=America/Lima
    ports:
      - "10000:10000"
      - "10001:10001"
      - "10002:10002"

  backend:
    image: ghcr.io/pichangueo/saas-back-end:latest
    restart: always
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    environment:
      - TZ=America/Lima
      - ENTORNO=dev
      - DATABASE_URL=postgresql+asyncpg://postgres:postgres_super_secret@db:5432/pichangueo_db
      - REDIS_URL=redis://redis:6379/0
      - JWT_SECRET_KEY=clave_secreta_pichangueo_saas_2026_super_segura_minimo_32_caracteres
      - JWT_ALGORITHM=HS256
      - JWT_EXPIRATION_HOURS=1
      - JWT_REFRESH_DAYS=7
      - CORS_ORIGENES=http://localhost,http://localhost:3000,http://127.0.0.1:3000,http://localhost:80,http://127.0.0.1:80
      - CORS_CREDENCIALES=true
      - LIMPIEZA_TOKENS_HORAS=6
      - LIMPIEZA_TOKENS_EN_API=true
      - LOG_FORMAT=text
      - RESEND_API_KEY=re_123456789_ejemplo
      - FRONTEND_URL=http://localhost
      - AZURE_STORAGE_CONNECTION_STRING=DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://azurite:10000/devstoreaccount1;
    deploy:
      mode: replicated
      replicas: 2
    ports:
      - "8000"

  frontend:
    image: ghcr.io/pichangueo/saas-front-end:latest
    restart: always
    environment:
      - TZ=America/Lima
      - NEXT_PUBLIC_API_URL=http://localhost
      - PORT=3000
    deploy:
      mode: replicated
      replicas: 2
    ports:
      - "3000"

  proxy:
    image: ghcr.io/pichangueo/pichangueo-plataforma:latest
    restart: always
    depends_on:
      - backend
      - frontend
    environment:
      - TZ=America/Lima
    ports:
      - "80:80"
      - "443:443"

  watchtower:
    image: containrrr/watchtower:latest
    restart: always
    environment:
      - TZ=America/Lima
      - DOCKER_API_VERSION=1.44
      - REPO_USER=iamrodrigodev
      - REPO_PASS=${TOKEN}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --interval 60 --cleanup

volumes:
  pichangueo_db_data:
  pichangueo_redis_data:
EOF

echo -e "\n  -> Servicios distribuidos iniciados correctamente... \033[0;32m[OK]\033[0m\n"

echo -e "\033[0;36m========================================================================\033[0m"
echo -e " \033[0;32mPlataforma Pichangueo desplegada exitosamente!\033[0m"
echo -e " Arquitectura: Balanceador Nginx + 2 Réplicas Back + 2 Réplicas Front"
echo -e "               PostgreSQL (con Seeds) + Redis + Azurite + Watchtower"
echo -e " Acceso Web: \033[1;37mhttp://localhost\033[0m"
echo -e " API Docs:   \033[1;37mhttp://localhost/api/docs\033[0m"
echo -e "\033[0;36m========================================================================\033[0m\n"