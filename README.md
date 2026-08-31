# Pichangueo - Plataforma de Gestión Deportiva

Plataforma integral para la administración, reserva de canchas deportivas y gestión de complejos deportivos.

![Next.js](https://img.shields.io/badge/Next.js-black?style=for-the-badge&logo=next.js&logoColor=white) ![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB) ![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white) ![Tailwind](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white) ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white) ![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) ![NGINX](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)

## Arquitectura del Sistema

El proyecto esta construido bajo una arquitectura N-Capas avanzado orientado a dominios (Modular Monolith) e incluye las siguientes tecnologias y componentes:

### 1. Infraestructura y Despliegue
La plataforma utiliza una arquitectura basada en contenedores gestionada con Docker y Docker Compose, disenada para alta disponibilidad mediante replicacion de servicios.
- Proxy Inverso: Nginx, enrutando el trafico hacia el frontend y backend.
- Base de Datos: PostgreSQL.
- Cache y Mensajeria: Redis.
- Almacenamiento (Object Storage): Azurite (emulador local de Azure Storage).
- CI/CD y Actualizaciones Automatizadas: Jenkins y Watchtower para el despliegue continuo de imagenes desde GitHub Container Registry.

### 2. Frontend
Aplicacion web moderna construida con el ecosistema de React.
- Framework: Next.js (App Router) y React 19.
- Lenguaje: TypeScript.
- Estilos y Componentes: Tailwind CSS v4, Shadcn UI y Radix UI.
- Gestion de Estado y Peticiones: React Query.
- Formularios: React Hook Form y Zod.
- Herramientas: Biome para linting y formateo.
- Estructura Modular: Organizada por dominios en la capa de features (autenticación, clientes, empresas, sucursales, usuarios, planes, etc.).

### 3. Backend
API RESTful construida como un monolito modular implementando principios de Clean Architecture y Domain-Driven Design (DDD).
- Framework: FastAPI y Uvicorn.
- Lenguaje: Python.
- Base de Datos y ORM: SQLAlchemy y Alembic para las migraciones.
- Estructura Modular: Dividido por dominios de negocio (canchas, autenticacion, rbac, clientes, empresas, planes, etc.).
- Capas Internas: Cada modulo encapsula controladores, logica de dominio, repositorios, servicios, mappers y esquemas (Pydantic), invirtiendo las dependencias mediante interfaces.

### 4. Estructura de Directorios (Ejemplo)
A continuación se muestra cómo se organizan físicamente las capas y dominios dentro del proyecto:

```text
pichangueo/
├── saas-back-end/                  # Backend principal
│   └── app/
│       ├── api/                    # Enrutadores globales
│       ├── core/                   # Configuraciones, excepciones, seguridad
│       ├── db/                     # Conexión principal a base de datos
│       └── modules/                # Módulos de dominio (N-Capas Avanzado)
│           ├── autenticacion/
│           ├── canchas/
│           │   ├── controllers/    # Capa de presentación (Rutas de FastAPI)
│           │   ├── domain/         # Entidades de dominio puras
│           │   ├── mappers/        # Transformadores de datos entre capas
│           │   ├── models/         # Modelos de SQLAlchemy (Base de Datos)
│           │   ├── repositories/   # Acceso a datos (Patrón Repositorio)
│           │   ├── schemas/        # Validaciones y DTOs (Pydantic)
│           │   └── services/       # Interfaces e implementación de lógica de negocio
│           └── ... (otros módulos)
│
├── saas-front-end/                 # Frontend principal
│   └── src/
│       ├── app/                    # Next.js App Router (Páginas y Rutas)
│       ├── components/             # Componentes compartidos de UI (Shadcn)
│       ├── features/               # Lógica aislada por dominio o funcionalidad
│       │   ├── autenticacion/
│       │   ├── clientes/
│       │   ├── empresas/
│       │   ├── sucursales/
│       │   ├── usuarios/
│       │   └── ... (otros features)
│       ├── hooks/                  # Custom Hooks genéricos de React
│       ├── lib/                    # Utilidades y funciones auxiliares
│       └── providers/              # Proveedores de estado y contexto globales
│
└── saas-infraestructura/           # Infraestructura del proyecto
    ├── nginx/                      # Configuración del proxy inverso
    ├── compose.yaml                # Orquestación principal de los servicios (Docker)
    └── Dockerfile                  # Construcción de las imágenes
```

## Despliegue de la Aplicación

Descargue el script correspondiente a su sistema operativo para iniciar la plataforma con 1 solo clic:

| Sistema Operativo | Script de Despliegue | Modo de Ejecución |
| :--- | :--- | :--- |
| **Windows** | [**`desplegar.bat`**](https://github.com/pichangueo/.github/releases/download/v1.0.0/desplegar.bat) | Descargar y hacer doble clic sobre el archivo |
| **Linux / macOS** | [**`desplegar.sh`**](https://github.com/pichangueo/.github/releases/download/v1.0.0/desplegar.sh) | `chmod +x desplegar.sh && ./desplegar.sh` |


## Instrucciones de Uso

1. Haga clic en el script correspondiente a su sistema operativo (`desplegar.bat` o `desplegar.sh`) en la tabla anterior para descargarlo directamente a su equipo con 1 solo clic.
2. Ejecute el script descargado:
   * **En Windows:** Haga doble clic sobre `desplegar.bat` (o ejecute `.\desplegar.bat` en su terminal).
   * **En Linux / macOS:** Abra una terminal y ejecute:
     ```bash
     chmod +x desplegar.sh && ./desplegar.sh
     ```
3. El script autenticará con el registro, descargará la imagen y levantará el contenedor automáticamente.
4. Una vez finalizado, acceda a la plataforma desde su navegador:
   * **Aplicación Web:** [http://localhost](http://localhost)
   * **Documentación de la API (Swagger):** [http://localhost/api/docs](http://localhost/api/docs)