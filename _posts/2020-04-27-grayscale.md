---
layout: post
title: "Conversión a escala de grises"
date: 2020-04-27 22:16:00 -0500
permalink: /grayscale
---

En este post se hace una documentación del estudio realizado para convertir una imagen a escala de grises por diferentes métodos, utilizando [Processing](https://processing.org/).

El primer método, que es el que parece a simple vista, es convertir la imagen a escala de grises sacando el promedio de los valores RGB.

El segundo método es utilizando la variable luma. Para eso se utiliza la siguiente ecuación:

$$\displaystyle Y'_{\text{601}}=0.299R+0.587G+0.114B$$

Para ver la conversión con luma oprimir cualquier tecla. Al oprimir otra tecla vuelve al promedio RGB (por cada tecla oprimida se van alternando entre promedio RGB y luma).

<canvas data-processing-sources="/sketches/grayscale/grayscale.pde"></canvas>

El código en processing es el siguiente:

```java
PImage img;
PGraphics original;
PGraphics grayscale;
String grayscaleType = "RGB";

void setup() {
  size(844, 310);
  img = loadImage("fire.jpg");
  original = createGraphics(422, 310);
  grayscale = createGraphics(422, 310);
  noStroke();
}

void draw() {
  original.beginDraw();
  original.image(img,0,0);
  original.endDraw();
  grayscale.beginDraw();
  grayscale.image(img,0,0);
  grayscale.loadPixels();
  for (int y = 0; y < grayscale.height; y++) {
    for (int x = 0; x < grayscale.width; x++ ) {
      color c = conversion(x, y, grayscaleType);
      int loc = x + y*grayscale.width;
      grayscale.pixels[loc] = c;
    }
  }
  grayscale.updatePixels();
  grayscale.endDraw();
  image(original, 0, 0);
  image(grayscale, 422, 0);
}

void keyPressed(){
  if (grayscaleType == "RGB") {
    grayscaleType = "luma";
  } else {
    grayscaleType = "RGB";
  }
}

color conversion(int x, int y, String grayscaleType){
  int gray = 0;
  color pixel = get(x,y);
  float pred = 0;
  float pgreen = 0;
  float pblue = 0;
  switch (grayscaleType) {
    case "RGB":
      pred = red(pixel);
      pgreen = green(pixel);
      pblue = blue(pixel);
      gray = (int)(pred + pgreen + pblue)/3;
      break;
    case "luma":
      pred = red(pixel);
      pgreen = green(pixel);
      pblue = blue(pixel);
      gray = (int) (0.2989*pred + 0.5870*pgreen + 0.1140*pblue);
      break;
  }
  return color(gray, gray, gray);
}

```
