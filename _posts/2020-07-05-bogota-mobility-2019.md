---
layout: post
title: "Movilidad Bogotá 2019"
date: 2020-06-14 16:13:00 -0500
permalink: /proyecto
---

{: style="text-align: justify" }
El presente post es la bitácora del proyecto final de la asignatura Computación Visual realizada por [los autores de este blog]({{site.baseurl}}/about/). El objetivo de este proyecto es visualizar información de Movilidad en Bogotá en el 2019, de acuerdo a los datos de la encuesta de este rubro realizada en el mismo año y disponible a través del portal de [Datos Abiertos](https://datosabiertos.bogota.gov.co/).

<script type="text/javascript" async
    src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

### 1. Problemática

{: style="text-align: justify" }
En la capital de Colombia y una de las ciudades más pobladas de Latinoamérica, Bogotá, el tema de la movilidad es algo que está en la boca de todo el mundo: tanto de expertos, como de los mismos ciudadanos que se preguntan el por qué la movilidad funciona tan mal. Muchos ciudadanos han optado por empezar a utilizar medios de transporte alternativos, como las bicicletas, y con el paso del tiempo parece ser una tendencia en aumento.

{: style="text-align: justify" }
En 2019, la Secretaría Distrital de Movilidad y el Centro Nacional de Consultoría encargó a Steer realizar una encuesta de movilidad para conocer cómo se movilizan los Bogotanos. Esta no es la primera encuesta de este tipo en la ciudad, ya que hay información sobre encuestas similares que datan de 2005, 2011 y 2015, pero si es la más reciente. Los resultados, además de ser interesantes, deberían poder ser visualizados de una forma fácil por personas ajenas al manejo de base de datos, de manera tal que den una idea de qué se debería hacer, y a qué tipo de movilidad se le debería apostar.

### 2. Objetivo

{: style="text-align: justify" }
Utilizar los datos recolectados en la Encuesta de Movilidad de Bogotá 2019 para visualizar dichos datos en un mapa, de manera que puedan ser entendidos de manera más efectiva y por un publico mucho más amplio. Como objetivo secundario se evalúa también la calidad de los datos de esta encuesta y el nivel de dificultad de su procesamiento. Este trabajo se enfoca en medios de transporte eco-amigables (bicicletas y recorridos a pie), SITP, Transmilenio y medios de transporte privados (automoviles particulares y motos).

### 3. Diseño de la solución

{: style="text-align: justify" }
Se realizó la recolección de los datos y se procesaron de acuerdo a las necesidades del proyecto. Para la recolección se visitó el portal [Datos Abiertos](https://datosabiertos.bogota.gov.co/) que nos re-dirigió a [este link de SIMUR](http://www.simur.gov.co/portal-simur/datos-del-sector/encuestas-de-movilidad/) donde están los resultados históricos de las encuestas de movilidad públicas de los años 2005, 2011, 2015 y 2019.

{: style="text-align: justify" }
Inicialmente se contempló analizar los datos por localidad para visualizarlos de esta misma manera, pero se encontró que en los viajes hacía falta este dato, a pesar de que en los archivos informativos de la base de datos se indica que lo incluyen. Por esta razón, fue necesario elegir otra forma de fragmentar la ciudad y procesar los datos. Esto se hizo a través de las UTAM (Unidad Territorial de Análiss de Movilidad) y ZAT (Zonas de Análisis de Transporte), las cuales sí aparecen en la tabla de viajes de la base de datos.

{: style="text-align: justify" }
Como parte de los datos, se adjunta a ellos la zonificación: [Shapefiles](https://gisgeography.com/arcgis-shapefile-files-types-extensions/) con la delimitación de cada UTAM y ZAT, donde llaman la atención dos cosas: la primera es que el software en el que se realizan este tipo de archivos es de propietario (lo cual es cuestionable para una encuesta pública) y que al procesarlo para convertirlo a otro tipo de dato (GeoJSON, a través de [Map Shaper](https://mapshaper.org/)), se encuentra que hay algunos problemas en el establecimiento de fronteras entre las UTAMs y ZATs, lo que provoca que algunas pequeñas partes del mapa hagan parte de dos UTAM/ZAT, y otras de ninguna.

{: style="text-align: justify" }
Una vez convertidos, se filtraron y procesaron los datos y se utilizó la API de Google Maps para pintar las UTAM y sus respectivos datos procesados. Cabe mencionar que esta API recientemente cambió su modelo de negocio y ahora es necesario asociar un método de pago para utilizarla sin marca de agua (debido a que después de un número de solicitudes a la API, Google empieza a cobrar). Debido a esto y por cuestiones de seguridad, el release público de este proyecto (en el demo que se muestra a continuación) se hace con la marca de agua de desarrollo.

### 4. Demo

Se puede visualizar el mapa con los datos aqui: [Ver mapa](/googleMaps/googleMaps.html).
{: style="text-align: justify" }
En la parte superior se pueden encontrar los selectores de los datos a visualizar. Por ejemplo "Ecomovilidad - Febrero", mostrará el porcentaje de viajes ecoamigables que se salieron desde cada UTAM en el mes de febrero.

En la parte de abajo a la izquierda se encuentra un cuadro con los siguientes datos:
{: style="text-align: justify" }

- {: style="text-align: justify" }Porcentaje: Porcentaje de viajes que salieron de la UTAM seleccionada, en el mes seleccionado, con medio el medio de transporte seleccionado (Ecomovilidad, SITP, Transmilenio o automóviles privados) con respecto al total de los viajes que salieron de esa misma UTAM. Si dice "Porcentaje: 80" y en el selector está seleccionado "Ecomovilidad - Febrero", significa que en esa UTAM, en el mes de Febrero, la cantidad de viajes ecoamigables que salieron de ahí fueron el 80% del total de todos los viajes (en cualquier medio de transporte) realizados en esa UTAM.

- {: style="text-align: justify" }UTAM Nombre: Nombre oficial de la UTAM. No confundir UTAM con barrio. Ejemplo: Chapinero.

- {: style="text-align: justify" }UTAM Localidad: La localidad en la que se encuentra ubicada la UTAM. Ejemplo: Kennedy.

- {: style="text-align: justify" }UTAM Municipio: El nombre del municipio donde está ubicada la UTAM. Ejemplo: Chía.

### 5. Conclusiones

{: style="text-align: justify" }
A lo largo de implementación del proyecto y luego de analizar los datos visualizados, salen a la luz varias conclusiones:

- {: style="text-align: justify" } La Ecomovilidad es un sector que está tomando fuerza en la ciudad de Bogotá. Por lo tanto, la planificación de la movilidad en Bogotá debería centrarse más en beneficiar y darle más espacio a los transeúntes y ciclistas.
- {: style="text-align: justify" } El uso de automóviles particulares sigue primando sobre el uso del transporte público. Esto podría explicar la excesiva congestión en el tránsito de la ciudad de Bogotá.
- {: style="text-align: justify" } Para un mejor análisis hubiera sido bueno tener otros datos en cuenta, como los kilómetros recorridos por viaje, la traza, o edad de los encuestados. También utilizar otras caracterísiticas más entendibles que las ZAT y las UTAM, como lo son las localidades, pero por las limitaciones descritas no fue posible.
- {: style="text-align: justify" } Existen varios temas a considerar y posiblemente debatibles en el dataset utilizado, como la delimitación de las ZAT/UTAM (y la utilización de Shapefiles en su publicación) y la ausencia de las localidades en cada viaje.
