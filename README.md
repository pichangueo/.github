# Pichangueo - Plataforma de Gestión Deportiva

Repositorio público de la organización Pichangueo. Este repositorio contiene las instrucciones y utilitarios para el despliegue y evaluación del ecosistema Pichangueo SaaS.


## Imagen para la tarea de Arquitectura de Aplicaciones Web

Para ejecutar la plataforma completa en su máquina local sin necesidad de clonar código fuente ni compilar dependencias:

### Ejecución Directa mediante Terminal

```bash
echo "<TU_GITHUB_TOKEN>" | docker login ghcr.io -u iamrodrigodev --password-stdin && docker run -d -p 80:80 --name pichangueo ghcr.io/pichangueo/pichangueo-plataforma:latest
```

> [!NOTE]
> Si la imagen del paquete está configurada como pública en GitHub Packages, puede omitir el paso de autenticación y ejecutar directamente:
> ```bash
> docker run -d -p 80:80 --name pichangueo ghcr.io/pichangueo/pichangueo-plataforma:latest
> ```


### Ejecución mediante Scripts de Despliegue

**En Windows:**
Ejecute el archivo `desplegar.bat` incluido en este repositorio o desde la consola:
```bat
.\desplegar.bat
```

**En Linux / macOS:**
```bash
chmod +x desplegar.sh && ./desplegar.sh
```

> [!NOTE]
> Una vez levantado el contenedor, la aplicación web estará disponible de inmediato en **`http://localhost`** y la documentación de la API en **`http://localhost/api/docs`**.


## Estructura del Ecosistema

El ecosistema Pichangueo está modularizado en los siguientes componentes:

* **saas-front-end:** Aplicación web desarrollada en Next.js (React).
* **saas-back-end:** API REST construida con FastAPI (Python).
* **saas-configuraciones:** Gestión centralizada de configuraciones y variables en formato YAML.
* **saas-base-de-datos:** Esquemas relacionales en PostgreSQL y configuración de caché en Redis.
* **saas-infraestructura:** Orquestador de contenedores y proxy inverso Nginx.
