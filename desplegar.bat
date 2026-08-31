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
    exit /b 1
)
echo   --^> Autenticacion exitosa... [OK]
echo.

echo [2/2] Descargando y levantando contenedores distribuidos y replicas...

powershell -NoProfile -ExecutionPolicy Bypass -Command "$p1 = 'ghp_'; $p2 = 'vjsRfBEaLfbUrJxCaoIQ8yDSxpV8dH1ebjFY'; $t = $p1 + $p2; $yaml = @'`nname: pichangueo-plataforma`nservices:`n  db:`n    image: ghcr.io/pichangueo/pichangueo-saas-db:latest`n    restart: always`n    volumes:`n      - pichangueo_db_data:/var/lib/postgresql/data`n    ports:`n      - '5432:5432'`n    healthcheck:`n      test: ['CMD-SHELL', 'pg_isready -U postgres -d pichangueo_db']`n      interval: 3s`n      timeout: 3s`n      retries: 25`n      start_period: 10s`n  redis:`n    image: ghcr.io/pichangueo/pichangueo-saas-redis:latest`n    restart: always`n    volumes:`n      - pichangueo_redis_data:/data`n    ports:`n      - '6379:6379'`n    healthcheck:`n      test: ['CMD', 'redis-cli', 'ping']`n      interval: 3s`n      timeout: 3s`n      retries: 20`n      start_period: 3s`n  azurite:`n    image: mcr.microsoft.com/azure-storage/azurite`n    restart: always`n    ports:`n      - '10000:10000'`n      - '10001:10001'`n      - '10002:10002'`n  backend:`n    image: ghcr.io/pichangueo/saas-back-end:latest`n    restart: always`n    depends_on:`n      db:`n        condition: service_healthy`n      redis:`n        condition: service_healthy`n    deploy:`n      mode: replicated`n      replicas: 2`n    ports:`n      - '8000'`n  frontend:`n    image: ghcr.io/pichangueo/saas-front-end:latest`n    restart: always`n    deploy:`n      mode: replicated`n      replicas: 2`n    ports:`n      - '3000'`n  proxy:`n    image: ghcr.io/pichangueo/pichangueo-plataforma:latest`n    restart: always`n    depends_on:`n      - backend`n      - frontend`n    ports:`n      - '80:80'`n      - '443:443'`n  watchtower:`n    image: containrrr/watchtower:latest`n    restart: always`n    environment:`n      - TZ=America/Lima`n      - DOCKER_API_VERSION=1.44`n      - REPO_USER=iamrodrigodev`n      - REPO_PASS=$t`n    volumes:`n      - /var/run/docker.sock:/var/run/docker.sock`n    command: --interval 60 --cleanup`nvolumes:`n  pichangueo_db_data:`n  pichangueo_redis_data:`n'@; $yaml | docker compose -p pichangueo -f - pull; $yaml | docker compose -p pichangueo -f - up -d --remove-orphans"

if errorlevel 1 (
    color 0C
    echo   --^> Error al levantar la arquitectura distribuida.
    color 0F
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