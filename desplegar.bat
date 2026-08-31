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

if "%TOKEN%"=="" (
    set /p "TOKEN=Ingrese su Token de GitHub (o presione Enter si la imagen es publica): "
)

if not "%TOKEN%"=="" (
    echo [1/2] Autenticacion en GitHub Container Registry...
    echo !TOKEN! | docker login ghcr.io -u iamrodrigodev --password-stdin >nul 2>&1
    if errorlevel 1 (
        color 0C
        echo   --^> Error: No se pudo iniciar sesion. Verifique el token.
        color 0F
        exit /b 1
    )
    echo   --^> Sesion iniciada correctamente... [OK]
    echo.
)

echo [2/2] Descargando y levantando aplicacion...
docker stop pichangueo >nul 2>&1
docker rm pichangueo >nul 2>&1
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
