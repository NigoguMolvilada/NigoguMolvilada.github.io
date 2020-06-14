---
layout: post
title: "Imágenes a ASCII"
date: 2020-03-17 20:00:00 -0500
permalink: image-to-ascii
---

En este post se hace una documentación del estudio realizado para convertir una imagen a caracteres ASCII a través de [Processing](https://processing.org/).

Al realizar una búsqueda en Google de "image to ASCII" nos encontramos con múltiples herramientas automáticas que con un click hacían lo que queríamos, sin embargo, es de nuestro interés investigar cómo se hace este proceso y no solo convertir una imagen a caracteres. Para realizar la actividad se utilizó Processing.

Se puede cambiar el color del fondo y caracteres con las siguientes teclas:

- **a** para fondo negro, caracteres blancos.
- **b** para fondo blanco, caracteres negros (original).
- **c** para fondo negro, caracteres verdes.

<canvas data-processing-sources="/sketches/image_to_ascii/image_to_ascii.pde"></canvas>

El código en processing es el siguiente:

```java
PImage Img;
PImage ImgColor;
PGraphics original;
PGraphics asciiPG;
int[] backgroundColor = {255,255,255};
int[] fillColor = {0,0,0};
int resolution = 6;
char[] ascii;

void setup() {
  Img = loadImage("koala.jpg");
  ImgColor = loadImage("koala.jpg");
  size(1500,750);
  noStroke();
  ascii = new char[256];

  original = createGraphics(750, 750);
  asciiPG = createGraphics(750, 750);

  String chars = "@%#*+=-:. ";

  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, chars.length()));
    ascii[i] = chars.charAt(index);
  }

  PFont mono = createFont("Consolas", resolution + 2);
  textFont(mono);
}

void draw(){
  background(255);
  fill(0);

  original.beginDraw();
  original.image(ImgColor, 0, 0);
  original.fill(255);
  original.endDraw();
  asciiPG.beginDraw();
  asciify(asciiPG);
  asciiPG.endDraw();
  image(original, 0, 0);
  image(asciiPG, 750, 0);
}

void keyPressed(){
  if(key == 'a'){
    backgroundColor =  new int[]{0, 0, 0};
    fillColor = new int[]{255, 255, 255};
  }else if (key == 'b'){
    backgroundColor = new int[]{255, 255, 255};
    fillColor = new int[]{0, 0, 0};
  }else if (key == 'c'){
    backgroundColor = new int[]{0, 0, 0};
    fillColor = new int[]{0, 143, 57};
  }
}

void asciify(PGraphics asciiPG) {
  Img.filter(GRAY);
  Img.loadPixels();
  asciiPG.fill(fillColor[0], fillColor[1], fillColor[2]);
  asciiPG.background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
  for (int y = 0; y < Img.height; y += resolution) {
    for (int x = 0; x < Img.width; x += resolution) {
      color pixel = Img.get(x,y);
      asciiPG.text(ascii[int(brightness(pixel))], x, y);
    }
  }
}
```
