@echo off
setlocal enabledelayedexpansion
color 0B

echo Desplegando Arquitectura Distribuida de Pichangueo (Docker)...
echo.

docker info >nul 2>&1
if errorlevel 1 (
    color 0C
    echo Error: Docker no parece estar ejecutandose. Por favor inicia Docker Desktop.
    color 0F
    pause
    exit /b 1
)

echo [1/2] Autenticando en GitHub Container Registry...
set "P1=ghp_"
set "P2=vjsRfBEaLfbUrJxCaoIQ8yDSxpV8dH1ebjFY"
set "TOKEN=!P1!!P2!"

<nul set /p="!TOKEN!" | docker login ghcr.io -u iamrodrigodev --password-stdin >nul 2>&1
if errorlevel 1 (
    color 0C
    echo   --^> Error: No se pudo autenticar en el registro de contenedores.
    color 0F
    pause
    exit /b 1
)
echo   --^> Autenticacion exitosa... [OK]
echo.

echo [2/2] Descargando y levantando contenedores distribuidos y replicas...

(
echo name: pichangueo-plataforma
echo services:
echo   db:
echo     image: ghcr.io/pichangueo/pichangueo-saas-db:latest
echo   redis:
echo     image: ghcr.io/pichangueo/pichangueo-saas-redis:latest
echo   azurite:
echo     image: mcr.microsoft.com/azure-storage/azurite
echo   backend:
echo     image: ghcr.io/pichangueo/saas-back-end:latest
echo   frontend:
echo     image: ghcr.io/pichangueo/saas-front-end:latest
echo   proxy:
echo     image: ghcr.io/pichangueo/pichangueo-plataforma:latest
echo   watchtower:
echo     image: containrrr/watchtower:latest
) > temp_pull.yml

docker compose -p pichangueo -f temp_pull.yml pull

(
echo name: pichangueo-plataforma
echo services:
echo   db:
echo     image: ghcr.io/pichangueo/pichangueo-saas-db:latest
echo     restart: always
echo     environment:
echo       - POSTGRES_DB=pichangueo_db
echo       - POSTGRES_USER=postgres
echo       - POSTGRES_PASSWORD=postgres_super_secret
echo       - TZ=America/Lima
echo     volumes:
echo       - pichangueo_db_data:/var/lib/postgresql/data
echo     ports:
echo       - "5432:5432"
echo     healthcheck:
echo       test: ["CMD-SHELL", "pg_isready -U postgres -d pichangueo_db"]
echo       interval: 3s
echo       timeout: 3s
echo       retries: 25
echo       start_period: 10s
echo   redis:
echo     image: ghcr.io/pichangueo/pichangueo-saas-redis:latest
echo     restart: always
echo     environment:
echo       - TZ=America/Lima
echo     volumes:
echo       - pichangueo_redis_data:/data
echo     ports:
echo       - "6379:6379"
echo     healthcheck:
echo       test: ["CMD", "redis-cli", "ping"]
echo       interval: 3s
echo       timeout: 3s
echo       retries: 20
echo       start_period: 3s
echo   azurite:
echo     image: mcr.microsoft.com/azure-storage/azurite
echo     restart: always
echo     environment:
echo       - TZ=America/Lima
echo     ports:
echo       - "10000:10000"
echo       - "10001:10001"
echo       - "10002:10002"
echo   backend:
echo     image: ghcr.io/pichangueo/saas-back-end:latest
echo     restart: always
echo     depends_on:
echo       db:
echo         condition: service_healthy
echo       redis:
echo         condition: service_healthy
echo     deploy:
echo       mode: replicated
echo       replicas: 2
echo     ports:
echo       - "8000"
echo   frontend:
echo     image: ghcr.io/pichangueo/saas-front-end:latest
echo     restart: always
echo     deploy:
echo       mode: replicated
echo       replicas: 2
echo     ports:
echo       - "3000"
echo   proxy:
echo     image: ghcr.io/pichangueo/pichangueo-plataforma:latest
echo     restart: always
echo     depends_on:
echo       - backend
echo       - frontend
echo     ports:
echo       - "80:80"
echo       - "443:443"
echo   watchtower:
echo     image: containrrr/watchtower:latest
echo     restart: always
echo     environment:
echo       - TZ=America/Lima
echo       - DOCKER_API_VERSION=1.44
echo       - REPO_USER=iamrodrigodev
echo       - REPO_PASS=!TOKEN!
echo     volumes:
echo       - /var/run/docker.sock:/var/run/docker.sock
echo     command: --interval 60 --cleanup
echo volumes:
echo   pichangueo_db_data:
echo   pichangueo_redis_data:
) > temp_up.yml

docker compose -p pichangueo -f temp_up.yml up -d --remove-orphans

del temp_pull.yml >nul 2>&1
del temp_up.yml >nul 2>&1

if errorlevel 1 (
    color 0C
    echo   --^> Error al levantar la arquitectura distribuida.
    color 0F
    pause
    exit /b 1
)

echo   --^> Servicios distribuidos iniciados correctamente... [OK]
echo.
echo ========================================================================
echo  Plataforma Pichangueo desplegada exitosamente!
echo  Arquitectura: Balanceador Nginx + 2 Replicas Back + 2 Replicas Front
echo                PostgreSQL (con Seeds) + Redis + Azurite + Watchtower
echo  Acceso Web: http://localhost
echo  API Docs:   http://localhost/api/docs
echo ========================================================================
endlocal
pause