# Pichangueo - Plataforma de Gestión Deportiva

Plataforma integral para la administración, reserva de canchas deportivas y gestión de complejos deportivos.


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