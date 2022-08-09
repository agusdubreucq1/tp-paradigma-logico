# TP Integrador - Paradigma Lógico 2022

Integrantes:

- **Completar con nombre y apellido**
- **Completar con nombre y apellido**
- **Completar con nombre y apellido**
- **Completar con nombre y apellido**

## Consignas

Este trabajo, a diferencia de los anteriores, tiene consignas abiertas con la intención de que tomen decisiones respecto a los predicados a desarrollar. También tiene las dimensiones y complejidad de un parcial, con lo cual debería servir para prepararse para lo que se viene :muscle:

Pueden encontrar el enunciado del trabajo práctico [acá](https://docs.google.com/document/d/1AWkWEABla82BiepmID8F3FAhGE6xP6dTTYGfxrHKnuM/edit#).

Se espera que **desarrollen** lo indicado en cada punto en el archivo `src/tp.pl`, luego del código provisto. También se espera que incluyan, dentro del mismo archivo, **las pruebas** sobre los predicados que resuelven los distintos puntos del TP, para mostrar el uso y cuáles son las respuestas obtenidas con la solución actual :mag_right:.

Y no olviden editar este `README` con los nombres de cada integrante :smile:

## Modalidad de trabajo

Para arrancar, cada integrante debería clonarse el repositorio ejecutando el comando `git clone urlParaClonarElRepo`, de modo que puedan trabajar tanto de forma sincrónica como asincrónica (ver más abajo).

Al igual que para los trabajos prácticos anteriores, se recomienda dar pasos chicos: implementar lo que se pide para un punto, probar lo desarrollado para validar que funciona correctamente y subir esos cambios.

Si tienen dudas, recuerden que pueden abrir un issue en este repositorio y hacer la pregunta que quieran sobre la consigna o su solución actual.

Y no olviden de abrir un issue para avisar que entregaron el trabajo práctico, así como también crear un tag para que se dispare la corrida de pruebas en el servidor.

### Testeo :heavy_check_mark:

Para este trabajo **no se proveen pruebas automáticas** que verifiquen los resultados de los predicados a desarrollar en cada punto, para no comprometer la libertad para diseñar la solución. Si bien se provee una base de conocimientos inicial con los predicados que se detallan en el enunciado y se explican algunos ejemplos de información que debe poder representarse, se espera que agreguen suficiente información relevante para poder verificar la funcionalidad pedida y desarrollen las pruebas automáticas necesarias para cubrir los distintos escenarios en `src/tp.pl`.

Recuerden que para probar el trabajo manualmente desde la consola, alcanza con correr el comando `swipl src/tp.pl` sobre la raíz del proyecto y ejecutar las consultas correspondientes en la consola de Prolog.

Para correr los tests alcanza con ejecutar `run_tests.` en la consola de Prolog. También se correrán automáticamente al recargar la solución con el comando `make.`

> :exclamation: Recuerden incluir casos sencillos que permitan verificar la inversibilidad de los predicados.

En el archivo `src/tp.pl` ya se incluyen algunos tests automáticos sobre el código de base que pueden servir de referencia. Para más información sobre testeo con PLUnit, pueden complementar con este [video](https://youtu.be/8Llph7eV8rs).

### Recomendaciones para trabajo grupal :busts_in_silhouette:

Si bien no hay una única forma para trabajar en grupo sobre una misma base de código, la recomendación es que se coordinen para arrancar trabajando de forma **sincrónica** y aprovechen la extensión **Live Share** del VSCode, de forma que puedan tomar decisiones conjuntas y avanzar a la par.

Para trabajo **asincrónico**, alcanza con que cada integrante tenga clonado el repositorio y **antes** de trabajar sobre un cambio, se asegure de tener su repo local con el **código actualizado** corriendo el comando `git pull` sobre la raíz del proyecto.

En la medida en la que avancen sobre el ejercicio, recuerden subir su solución a GitHub con los comandos:

```
git add .
git commit -m "Mensaje que explica los cambios"
git push
```

Eviten empezar un cambio y dejarlo sin subir, de lo contrario es muy probable que se produzcan [**conflictos**](https://www.youtube.com/watch?v=sKcN7cWFniw&list=PL2xYJ49ov_ddydw7wvncxMBzB3wpqPV0u&index=7) con lo que haga la otra persona :scream:

Siempre es mejor hacer commits chicos para cambios puntuales y pushear seguido, y más aún trabajando en equipo. Si necesitan ayuda, contacten a sus tutores.

### Uso de LiveShare :rocket:

Para trabajar con Live Share, una persona del equipo deberá:

- abrir el VSCode sobre la carpeta del proyecto
- crear una sesión compartida usando la extensión Live Share y compartirle el link para sumarse a esa sesión al resto (les va a pedir loguearse, para eso usan su id de GitHub y listo).

Esta extensión permite que todas las personas que se sumen a la sesión puedan editar al mismo tiempo el código del proyecto, como si fuera un google doc pero con todos los features del entorno de desarrollo que se armaron para Prolog.

> Una vez iniciada la sesión, aparecerá el menú Live Share a la izquierda del VSCode. Allí pueden encontrar opciones útiles, incluyendo compartir la terminal en modo editable para el resto del equipo en vez de ser sólo lectura.
>
> Para más información ver: https://code.visualstudio.com/learn/collaboration/live-share