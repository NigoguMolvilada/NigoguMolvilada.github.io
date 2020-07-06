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

[Ver mapa](/googleMaps/googleMaps.html)

### 5. Conclusiones
