---
layout: post
title: "Estudio de cómo convertir a imágenes a ASCII"
date: 2020-03-17 20:00:00 -0500
permalink: image-to-ascii
---

En este post se hace una documentación del estudio realizado para convertir una imagen a caracteres ASCII a través de [Processing](https://processing.org/). Para motrar el resultado a nivel técnico del trabajo realizado se utilizó [p5.js](https://p5js.org/).

<script src="https://cdn.jsdelivr.net/npm/p5@1.0.0/lib/p5.js"></script>
<script src="/sketches/image_to_ascii/image_to_ascii.js"></script>

Al realizar una búsqueda en Google de "image to ASCII" nos encontramos con múltiples herramientas automáticas que con un click hacían lo que queríamos, sin embargo, es de nuestro interés investigar cómo se hace este proceso y no solo convertir una imagen a caracteres. Para realizar la actividad se utilizó Processing y el resultado final obtenido es el siguiente:

<div id="sketch-holder">
Mantener clickeado encima de la imagen para ver la original:
      <!-- Our sketch will go here! -->
</div>

El código en processing es el siguiente:

```java
// Programa para pasar imagen a texto.

// PImage es un tipo de dato para almacenar imágenes. Se crea la variable Img.
PImage Img;
PImage ImgColor;

// Resolución de muestreo: los colores se muestrearán cada n pixeles para determinar qué caracter mostrar.
int resolution = 5;

// Arreglo de tipo char que va a contener los caracteres en reemplazo de los píxeles.
char[] ascii;

void setup() {
  // Se carga la imagen.
  Img = loadImage("perro.PNG");
  ImgColor = loadImage("perro.PNG");

  // Se determina el tamaño de la ventana de Processing (donde se va a mostrar la imagen resultado):
  size(750,422);
  // Se inicializa el arreglo que corresponde a los valores de brillo (256 es la cantidad de valores de brillantez):
  ascii = new char[256];

  // Se crea un arreglo de char llamado chars que contiene los caracteres a utilizar:
  String chars = "@%#*+=-:. ";

  // Se llena el arreglo ASCII de manera que sus posiciones se vayan llenando de acuerdo a los caracteres
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, chars.length()));
    ascii[i] = chars.charAt(index);
  }

  // PFont es un tipo de dato para almacenar fuentes.
  // Se determina qué fuente y tamaño de fuente se va a usar.
  PFont mono = createFont("Roboto Mono", resolution + 2);
  textFont(mono);
}

void draw(){
  surface.setSize(Img.width, Img.height);
  // Se determina el color de fondo de ventana de processing (blanco).
  background(255);
  // Se determina el color de los caracteres (negro).
  fill(0);

  // Se determina la acción que activa el cambio.
  if (mousePressed == true) {
    image(ImgColor,0,0);
  } else {
    asciify();
  }
}

void asciify() {
  // Ya que el resultado se hará solo en blanco y negro, se hace la conversión de la imagen a escala de grises para calcular de forma más precisa el brillo.
  Img.filter(GRAY);
  Img.loadPixels();

  // Toma el color de cada enésimo píxel de la imagen y lo reemplaza con el carácter de brillo similar.
  for (int y = 0; y < Img.height; y += resolution) {
    for (int x = 0; x < Img.width; x += resolution) {
      color pixel = Img.get(x,y);
      // Se imprime el caracter determinado a ese brillo, en la posicion (x, y)
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}

```

La traducción a p5.js corresponde al siguiente código:

```javascript
let Img;
let ImgColor;
let resolution = 5;
let ascii;
let myFont;

function preload() {
  Img = loadImage("perro.PNG");
  ImgColor = loadImage("perro.PNG");
}

function setup() {
  createCanvas(750, 422);
  ascii = new Array(256);
  let chars = "@%#*+o=-:. ";
  for (let i = 0; i < 256; i++) {
    let index = parseInt(map(i, 0, 256, 0, chars.length));
    ascii[i] = chars.charAt(index);
  }
  textFont("Roboto Mono");
  textSize(resolution + 2);
}

function draw() {
  background(255);
  fill(0);

  if (mouseIsPressed) {
    image(ImgColor, 0, 0);
  } else {
    asciify();
  }
}

function asciify() {
  Img.filter(GRAY);
  Img.loadPixels();

  for (var y = 0; y < Img.height; y += resolution) {
    for (var x = 0; x < Img.width; x += resolution) {
      let pixel = Img.get(x, y);
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}
```

Realizando cambios en los parámetros donde se determina el color del texto y del fondo, los caracteres utilizados y la función de activación, se pueden obtener otros resultados como los que se observan a continuación.
