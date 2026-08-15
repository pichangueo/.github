# Pichangueo SaaS

Bienvenido a la organización oficial de **Pichangueo**, la plataforma SaaS de gestión integral para complejos deportivos y alquiler de canchas sintéticas. Nuestro ecosistema de software está diseñado para automatizar y escalar las operaciones de reservas, facturación, control de accesos y administración de múltiples sucursales e inquilinos (tenant-based architecture).

---

## 🏗️ Arquitectura del Ecosistema

Para mantener el código escalable, modular y seguro, nuestro ecosistema se divide en múltiples repositorios especializados. A continuación, se detalla la función de cada uno de ellos:

### ⚙️ [pichangueo-saas-back-end](https://github.com/pichangueo/pichangueo-saas-back-end)
Es el núcleo lógico (Core) de la plataforma. Contiene la API REST/GraphQL que gestiona la lógica de negocio, reglas de facturación, pasarelas de pago y validaciones de seguridad. Toda interacción con la base de datos pasa a través de este componente.

### 💻 [pichangueo-saas-front-end](https://github.com/pichangueo/pichangueo-saas-front-end)
Contiene la aplicación web orientada al cliente y al administrador del complejo. Construida sobre tecnologías modernas de frontend, consume la API central para ofrecer una interfaz fluida, interactiva y responsiva (reservas en tiempo real, tableros de control y gestión de clientes).

### 🗄️ [pichangueo-saas-sql](https://github.com/pichangueo/pichangueo-saas-sql)
La fuente de verdad de la arquitectura de datos. Aquí se almacenan estrictamente las migraciones estructurales de PostgreSQL, la definición de esquemas (RBAC, ubicación, empresas) y los datos semilla para inicializar catálogos y permisos globales.

### 🛠️ [pichangueo-saas-comandos](https://github.com/pichangueo/pichangueo-saas-comandos)
Repositorio de herramientas operativas. Contiene los scripts de automatización (Bash y Batch) que facilitan la vida del desarrollador, permitiendo clonar todo el ecosistema con un solo comando o aprovisionar bases de datos locales en Docker en cuestión de segundos.

### 🔒 [pichangueo-saas-env](https://github.com/pichangueo/pichangueo-saas-env)
Nuestra bóveda de configuraciones. Un repositorio de acceso restringido que almacena las variables de entorno, tokens y secretos separados por entornos (desarrollo, staging y producción).

### 📚 [pichangueo-saas-docs](https://github.com/pichangueo/pichangueo-saas-docs)
El portal de conocimiento. Almacena la documentación técnica exhaustiva, diagramas de arquitectura, contratos de API, manuales de usuario y las guías de integración para nuevos desarrolladores.

---

## 🚀 Empezando a desarrollar (Nuevos Ingresos)

Si acabas de unirte al equipo, tu primer paso es dirigirte al repositorio de **comandos** y preparar tu entorno de trabajo:

1. Clona el repositorio de comandos:
   ```bash
   git clone https://github.com/pichangueo/pichangueo-saas-comandos.git
   ```
2. Sigue las instrucciones del README en ese repositorio para autoconfigurar tu máquina.
