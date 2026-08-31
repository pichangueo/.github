@echo off
setlocal enabledelayedexpansion
color 0B

echo Desplegando Imagen para la tarea de Arquitectura de Aplicaciones Web...
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
set "P2=XyJQX4NnRKUC1qVLSnRFHZUPe3qYIs2zEVsW"
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

echo [2/2] Descargando y ejecutando contenedor...
docker stop pichangueo >nul 2>&1
docker rm pichangueo >nul 2>&1
docker pull ghcr.io/pichangueo/pichangueo-plataforma:latest
docker run -d -p 80:80 --name pichangueo ghcr.io/pichangueo/pichangueo-plataforma:latest

if errorlevel 1 (
    color 0C
    echo   --^> Error al iniciar el contenedor.
    color 0F
    exit /b 1
)

echo   --^> Contenedor iniciado correctamente... [OK]
echo.
echo ========================================================
echo  Plataforma Pichangueo desplegada exitosamente!
echo  Acceso Web: http://localhost
echo  API Docs:   http://localhost/api/docs
echo ========================================================
endlocal
pause
