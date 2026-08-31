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

echo [1/3] Autenticando en GitHub Container Registry...
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

echo [2/3] Descargando especificacion moderna compose.yaml y configuraciones...
curl -sSL -H "Authorization: token !TOKEN!" https://raw.githubusercontent.com/iamrodrigodev/saas-infraestructura/master/compose.yaml -o compose.yaml
curl -sSL -H "Authorization: token !TOKEN!" https://raw.githubusercontent.com/pichangueo/saas-configuraciones/main/.env -o .env

echo [3/3] Descargando imagenes y levantando servicios replicados...
docker compose pull
docker compose up -d --remove-orphans

if errorlevel 1 (
    color 0C
    echo   --^> Error al levantar la arquitectura distribuida.
    color 0F
    exit /b 1
)

echo   --^> Servicios iniciados correctamente... [OK]
echo.
echo ========================================================
echo  Plataforma Pichangueo desplegada exitosamente!
echo  Arquitectura: Balanceador Nginx + Replicas + Microservicios
echo  Acceso Web: http://localhost
echo  API Docs:   http://localhost/api/docs
echo ========================================================
endlocal
pause