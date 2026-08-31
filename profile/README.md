# Pichangueo - Plataforma de Gestion Deportiva

Plataforma integral para la administracion, reserva de canchas deportivas y gestion de complejos deportivos.


## Despliegue de la Aplicacion

Descargue el script correspondiente a su sistema operativo para iniciar la plataforma en un solo paso:

| Sistema Operativo | Script de Despliegue | Modo de Ejecucion |
| :--- | :--- | :--- |
| **Windows** | [`desplegar.bat`](https://github.com/pichangueo/.github/raw/master/desplegar.bat) | Doble clic sobre el archivo o `.\desplegar.bat` |
| **Linux / macOS** | [`desplegar.sh`](https://github.com/pichangueo/.github/raw/master/desplegar.sh) | `chmod +x desplegar.sh && ./desplegar.sh` |


## Instrucciones de Uso

1. Descargue el archivo de despliegue correspondiente a su sistema operativo desde la tabla anterior.
2. Ejecute el script en su equipo para autenticar, descargar la imagen y levantar el contenedor automaticamente.
3. Una vez finalizada la ejecucion, abra su navegador e ingrese a:
   * **Aplicacion Web:** [http://localhost](http://localhost)
   * **Documentacion de la API (Swagger):** [http://localhost/api/docs](http://localhost/api/docs)