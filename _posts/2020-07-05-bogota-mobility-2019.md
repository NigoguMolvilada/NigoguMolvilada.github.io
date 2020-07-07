---
layout: post
title: "Movilidad Bogotá 2019"
date: 2020-06-14 16:13:00 -0500
permalink: /proyecto
---

{: style="text-align: justify" }
El presente post es la bitácora del proyecto final de la asignatura Computación Visual realizada por [los autores de este blog]({{site.baseurl}}/about/). El objetivo de este proyecto es visualizar información de Movilidad en Bogotá en el 2019, de acuerdo a los datos de la encuesta de este rubro realizada en el mismo año y disponible a través de [datosabiertos.bogota.gov.co](https://datosabiertos.bogota.gov.co/).

<script type="text/javascript" async
    src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

### 1. Problemática

{: style="text-align: justify" }
En la capital de Colombia y una de las ciudades más pobladas de Latinoamérica, Bogotá, el tema de la movilidad es algo que está en la boca de todo el mundo: tanto de expertos, como de los mismos ciudadanos que se preguntan el por qué la movilidad funciona tan mal. Muchos ciudadanos han optado por empezar a utilizar medios de transporte alternativos, como las bicicletas, y con el paso del tiempo parece ser una tendencia en aumento. En 2019, la Secretaría Distrital de Movilidad y el Centro Nacional de Consultoría encargó a Steer realizar una encuesta de movilidad para conocer cómo se movilizan los Bogotanos. Esta no es la primera encuesta de este tipo en la ciudad, ya que hay información sobre encuestas similares que datan de 2005, 2011 y 2015, pero si es la más reciente. Los resultados, además de ser interesantes, deberían poder ser visualizados de una forma fácil por la comunidad y las personas ajenas al manejo de base de datos, de manera tal que den una idea de qué se debería hacer, y a qué tipo de movilidad se le debería apostar.

### 2. Objetivo

{: style="text-align: justify" }
Utilizar los datos recolectados en la Encuesta de Movilidad de Bogotá 2019 para visualizar dichos datos en un mapa, de manera que puedan ser entendidos de manera más efectiva. Este trabajo se enfoca en medio de transporte eco-amigables (bicicletas y recorridos a pie), SITP, Transmilenio y medios de transporte privados (carros y motos).

### 3. Diseño de la solución

{: style="text-align: justify" }
Se recolectaron los datos y procesaron de acuerdo a las necesidades del proyecto. Además se utilizaron shapefiles con las divisiones tenidas en cuenta a la hora de hacer la encuesta (UTAM - Unidad territorial de análisis de movilidad). Dichos shapefiles se transformaron a datos tipo GEOJSON. Además se utilizó la API de Google Maps para pintar las UTAM de acuerdo a los datos procesados.

### 4. Demo

Se puede visualizar el mapa con los datos aqui: [Ver mapa](/googleMaps/googleMaps.html).

En la parte superior se puede encontrar un selector con los datos a visualizar. Por ejemplo "Ecomovilidad - Febrero", mostrará el porcentaje de viajes ecoamigables que se salieron desde cada UTAM en el mes de febrero.

En la parte de abajo a la izquierda se encuentra un cuadro con los siguientes datos:

- Porcentaje: Porcentaje de viajes que salieron de la UTAM seleccionada, en el mes seleccionado, con medio el medio de transporte seleccionado (Ecomovilidad, SITP, Transmilenio o Automóviles privados) con respecto al total de los viajes que salieron de esa misma UTAM. Si dice "Porcentaje: 80" y en el selector está seleccionado "Ecomovilidad - Febrero", significa que en esa UTAM, en el mes de Febrero, la cantidad de viajes ecoamigables que salieron de ahí fueron el 80% del total de todos los viajes (en cualquier medio de transporte) realizados en esa UTAM.

- UTAM Nombre: Nombre oficial de la UTAM. No confundir UTAM con barrio. Ejemplo: Chapinero.

- UTAM Localidad: La localidad en la que se encuentra ubicada la UTAM. Ejemplo: Kennedy.

- UTAM Municipio: El nombre del municipio donde está ubicada la UTAM. Ejemplo: Chía.

### 5. Conclusiones
