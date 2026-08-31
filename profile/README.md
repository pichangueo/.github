# Pichangueo - Plataforma de Gestion Deportiva

Plataforma integral para la administracion, reserva de canchas deportivas y gestion de complejos deportivos.


## Descarga de Scripts de Despliegue

Descargue el archivo de despliegue correspondiente a su sistema operativo con un solo clic:

| Sistema Operativo | Descarga Directa | Modo de Ejecucion |
| :--- | :--- | :--- |
| **Todos los Sistemas (Recomendado)** | [**Descargar `desplegar.zip`**](https://github.com/pichangueo/.github/raw/master/desplegar.zip) | Descomprimir y ejecutar `desplegar.bat` o `desplegar.sh` |
| **Windows** | [`desplegar.bat`](https://github.com/pichangueo/.github/raw/master/desplegar.bat) | Clic derecho y *Guardar enlace como...* |
| **Linux / macOS** | [`desplegar.sh`](https://github.com/pichangueo/.github/raw/master/desplegar.sh) | Clic derecho y *Guardar enlace como...* |


## Instrucciones de Uso

1. Descargue el archivo de despliegue desde la tabla anterior.
2. Ejecute el script en su computadora:
   * **En Windows:** Haga doble clic sobre `desplegar.bat` (o ejecute `.\desplegar.bat` en su terminal).
   * **En Linux / macOS:** Abra una terminal y ejecute:
     ```bash
     chmod +x desplegar.sh && ./desplegar.sh
     ```
3. El script autenticara, descargara la imagen y levantara el contenedor automaticamente.
4. Una vez finalizado, acceda a la plataforma desde su navegador:
   * **Aplicacion Web:** [http://localhost](http://localhost)
   * **Documentacion API (Swagger):** [http://localhost/api/docs](http://localhost/api/docs)