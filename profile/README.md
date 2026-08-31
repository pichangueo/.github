# Pichangueo - Plataforma de Gestión Deportiva

Repositorio público de la organización Pichangueo. Este repositorio contiene las instrucciones y utilitarios para el despliegue y evaluación del ecosistema Pichangueo SaaS.


## Imagen para la tarea de Arquitectura de Aplicaciones Web

Para ejecutar la plataforma completa en su máquina local sin necesidad de clonar código fuente ni compilar dependencias:


### Descarga Directa de Scripts (1 Clic)

Descargue el script correspondiente a su sistema operativo haciendo clic en los siguientes enlaces:

* [Descargar desplegar.bat (Windows)](https://raw.githubusercontent.com/pichangueo/.github/master/desplegar.bat)
* [Descargar desplegar.sh (Linux / macOS)](https://raw.githubusercontent.com/pichangueo/.github/master/desplegar.sh)

**Instrucciones de Ejecución:**

**En Windows:**
Haga doble clic sobre el archivo descargado `desplegar.bat` (o ejecútelo desde la terminal mediante `.\desplegar.bat`).

**En Linux / macOS:**
Otorgue permisos de ejecución y ejecute el script:
```bash
chmod +x desplegar.sh && ./desplegar.sh
```

> [!NOTE]
> El script se autentica automáticamente en GitHub Container Registry, descarga la imagen y levanta el contenedor. Al finalizar, la aplicación web estará disponible de inmediato en **`http://localhost`** y la documentación de la API en **`http://localhost/api/docs`**.


### Ejecución Directa mediante Terminal (Sin Descargar Scripts)

Si prefiere ejecutar directamente desde su terminal:

```bash
echo "<TOKEN_DE_GITHUB>" | docker login ghcr.io -u iamrodrigodev --password-stdin && docker run -d -p 80:80 --name pichangueo ghcr.io/pichangueo/pichangueo-plataforma:latest
```


## Estructura del Ecosistema

El ecosistema Pichangueo está modularizado en los siguientes componentes:

* **saas-front-end:** Aplicación web desarrollada en Next.js (React).
* **saas-back-end:** API REST construida con FastAPI (Python).
* **saas-configuraciones:** Gestión centralizada de configuraciones y variables en formato YAML.
* **saas-base-de-datos:** Esquemas relacionales en PostgreSQL y configuración de caché en Redis.
* **saas-infraestructura:** Orquestador de contenedores y proxy inverso Nginx.
