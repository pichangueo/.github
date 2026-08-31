# Pichangueo - Plataforma de Gestion Deportiva

Plataforma integral para la administracion, reserva de canchas deportivas y gestion de complejos deportivos.


## Despliegue de la Aplicacion

Descargue el script correspondiente a su sistema operativo para iniciar la plataforma en un solo paso:

| Sistema Operativo | Script de Despliegue | Modo de Ejecucion |
| :--- | :--- | :--- |
| **Windows** | [`desplegar.bat`](https://github.com/pichangueo/.github/blob/master/desplegar.bat) | Descargar y hacer doble clic sobre el archivo |
| **Linux / macOS** | [`desplegar.sh`](https://github.com/pichangueo/.github/blob/master/desplegar.sh) | `chmod +x desplegar.sh && ./desplegar.sh` |


## Instrucciones de Uso

1. Descargue el archivo correspondiente a su sistema operativo (`desplegar.bat` para Windows o `desplegar.sh` para Linux/macOS).
2. Ejecute el script en su computadora:
   * **En Windows:** Haga doble clic sobre `desplegar.bat` (o ejecute `.\desplegar.bat` en su terminal).
   * **En Linux / macOS:** Abra una terminal y ejecute:
     ```bash
     chmod +x desplegar.sh && ./desplegar.sh
     ```
3. El script autenticara, descargara la imagen y levantara el contenedor automaticamente.
4. Una vez finalizado, acceda a la plataforma desde su navegador:
   * **Aplicacion Web:** [http://localhost](http://localhost)
   * **Documentacion de la API (Swagger):** [http://localhost/api/docs](http://localhost/api/docs)