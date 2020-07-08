---
layout: post
title: "Movilidad Bogotá 2019"
date: 2020-06-14 16:13:00 -0500
permalink: /informe-final
---

{: style="text-align: justify" }
El presente post es una bitácora sobre la Movilidad en Bogotá en el 2019, de acuerdo a la encuesta de movilidad realizada en el mismo año. Como objetivo se tiene la idea de visualizar dichos datos, como proyecto final de la materia de Computación Visual por [los autores de este blog]({{site.baseurl}}/about/).

<script type="text/javascript" async
    src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

### 1. Problemática

{: style="text-align: justify" }
En Bogotá el tema movilidad es algo que está en la boca tanto de expertos, como de los mismos ciudadanos, que se preguntan el por qué la movilidad en Bogotá funciona tan mal. Muchos ciudadanos han optado por empezar a utilizar medios de trasnporte alternativos las bicicletas, y cada día parecer es un tendencia en aumento. En 2019 se realizó una encuesta de movilidad, para saber como se movilizan los Bogotanos. Los resultados, además de ser interesantes, deben poder ser visualizados, de manera tal que den una idea de qué se debería hacer, y a que tipo de movilidad se le debería apostar.

### 2. Objetivo

{: style="text-align: justify" }
Utilizar los datos recolectados en la encuesta de movilidad de 2019 para visualizar dichos datos en un mapa, de manera que puedan ser entendidos de manera más efectiva. El trabajo se enfoca en medio de trasnporte ecoamigables (bicicletas, recorridos a pie), SITP, Transmilenio y automóviles privados (carros y motos)

### 3. Diseño de la solución

{: style="text-align: justify" }
Se recolectaron los datos y procesaron de acuerdo a las necesidades del proyecto. Además se utilizaron shapefiles con las divisiones tenidas en cuenta a la hora de hacer la encuesta (UTAM - Unidad territorial de análisis de movilidad). Dichos shapefiles se transformaron a datos tipo GEOJSON. Además se utilizó la api de google maps para pintar las UTAM de acuerdo a los datos procesados.

### 4. Demo

Se puede visualizar el mapa con los datos aqui: [Ver mapa](/googleMaps/googleMaps.html)

{: style="text-align: justify" }
En la parte superior se puede encontrar un selector con los datos a visualizar. Por ejemplo "Ecomovilidad - Febrero", mostrará el porcentaje de viajes ecoamigables que se salieron desde cada UTAM en el mes de febrero.

En la parte de abajo a la izquierda se encuentra un cuadro con los siguientes datos:
{: style="text-align: justify" }

- {: style="text-align: justify" }Porcentaje: Porcentaje de viajes que salieron de la UTAM seleccionada, en el mes seleccionado, con medio el medio de transporte seleccionado (Ecomovilidad, SITP, Transmilenio o Automóviles privados) con respecto al total de los viajes que salieron de esa misma UTAM. Si dice "Porcentaje: 80" y en el selector está seleccionado "Ecomovilidad - Febrero", significa que en esa UTAM, en el mes de Febrero, la cantidad de viajes ecoamigables que salieron de ahí fueron el 80% del total de todos los viajes (en cualquier medio de transporte) realizados en esa UTAM.
- UTAM Nombre: nombre oficial de la UTAM. No confundir UTAM con barrio. Ejemplo: Chapinero
- UTAM Localidad: la localidad en la que se encuentra ubicada la UTAM. Ejemplo: Kennedy
- UTAM Municipio: el nombre del municipio donde está ubicada la UTAM. Ejemplo: Chía

### 5. Conclusiones

{: style="text-align: justify" }
A lo largo de implementación del proyecto y luego de analizar los datos visualizados, salen a la luz varias conclusiones:

- {: style="text-align: justify" } La Ecomovilidad es un sector que está tomando fuerza en la ciudad de Bogotá. Por lo tanto la planificación de la movilidad en Bogotá debería centrarse más en beneficiar y darle más espacio a los transeúntes y ciclistas.
- {: style="text-align: justify" } El uso de automóviles particulares sigue primando sobre el uso del transporte público. Esto podría explicar la excesiva congestión en el tránsito de la ciudad de Bogotá.
- {: style="text-align: justify" } Para un mejor análisis hubiera sido bueno tener otros datos en cuenta, como los kilómetros recorridos por viaje, la traza, o edad de los encuestados. También utilizar otras caracterísiticas más entendibles que las ZAT y las UTAM, como lo son las localidades.
