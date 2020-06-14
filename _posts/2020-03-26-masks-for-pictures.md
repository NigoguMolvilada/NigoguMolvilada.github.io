---
layout: post
title: "Máscaras de convolución"
date: 2020-03-26 10:26:00 -0500
permalink: /masks-for-pictures
---

En este post se hace una documentación del estudio realizado para aplicarle diferentes máscaras a una imagen haciendo un análisis de sus pixeles utilizando [Processing](https://processing.org/).

Al realizar una búsqueda sobre "procesamiento de imagenes con kernel" encontramos que lo que se hacía era una convolución con una matriz (el núcleo o kernel) con una cantidad de pixeles de una imagen. Cada kernel da como resultado una máscara diferente. En este ejercicio se decidió implementar los kernel más famosos y la función de inverso vista en clase. Para realizar la actividad se utilizó Processing y el resultado final obtenido es el siguiente:

Para ver cada filtro toca hacer clic en el scketch y oprimir alguna de estas teclas:

- **a, b** para ver máscaras relacionadas con detección de bordes.
- **c, d** para ver máscaras relacionadas con desenfoque.
- **e** para ver la máscara de realzado.
- **f** para ver la máscara de relieve.
- **g, h, i, j** para ver las máscaras de [Operadores Sobel](https://en.wikipedia.org/wiki/Sobel_operator) (abajo, izquierda, derecha y arriba, respectivamente).
- **k** para invertir los colores de la imagen. Se puede usar en simultáneo con otros filtros.
- **l** para volver a la imagen original.

<canvas data-processing-sources="/sketches/masks_implementation/masks_implementation.pde"></canvas>

El código en processing es el siguiente:

```java
PImage img;
PGraphics original;
PGraphics mask;
int matrixsize = 3;
boolean inv = false;

float[][] matrix = { { 0, 0, 0 },
                     { 0, 1, 0 },
                     { 0, 0, 0 } };

void setup() {
  size(844, 422);
  img = loadImage("/sketches/masks_implementation/lena.jpg");
  original = createGraphics(422, 422);
  mask = createGraphics(422, 422);
  noStroke();
}

void draw() {
  original.beginDraw();
  original.image(img,0,0);
  original.endDraw();
  mask.beginDraw();
  mask.image(img,0,0);
  mask.loadPixels();
  for (int y = 0; y < mask.height; y++) {
    for (int x = 0; x < mask.width; x++ ) {
      color c = convolution(x, y, matrix, matrixsize, mask);
      int loc = x + y*mask.width;
      mask.pixels[loc] = c;
    }
  }
  mask.updatePixels()
  mask.endDraw();
  image(original, 0, 0);
  image(mask, 422, 0);
}

void keyPressed(){
  // Edge detection
  matrixsize = 3;
  if(key == 'a'){
    matrix = { { -1, -1, -1 },
               { -1,  8, -1 },
               { -1, -1, -1 } };
  }else if(key == 'b'){
    matrix = { { -1, 0,  1 },
               { -2, 0,  2 },
               { -1, 0,  1 } };
  }
  // Blur
  else if (key == 'c') {
    matrix = { { 1/9, 1/9, 1/9 },
               { 1/9, 1/9, 1/9 },
               { 1/9, 1/9, 1/9 } };
  }else if (key == 'd'){
    matrixsize = 5;
    matrix = { { 1/256, 4 /256, 6 /256, 4 /256, 1/256 },
               { 4/256, 16/256, 24/256, 16/256, 4/256 },
               { 6/256, 24/256, 36/256, 24/256, 6/256 },
               { 4/256, 16/256, 24/256, 16/256, 4/256 },
               { 1/256, 4 /256, 6 /256, 4 /256, 1/256 } };
    }
  // Sharpering
  else if (key == 'e') {
    matrix = { { -2, -1,  0 },
               { -1,  1,  1 },
               {  0,  1,  2 } };
  }
  // Emboss
  else if (key == 'f') {
    matrix = { {  0, -1,  0 },
               { -1,  5, -1 },
               {  0, -1,  0 } };
  }
  // Sobel operators
  else if (key == 'g') {
    matrix = { { -1, -2, -1 },
              { 0, 0, 0 },
              { 1, 2, 1 } };
  }else if (key == 'h') {
    matrix = { { 1, 0, -1 },
              { 2, 0, -2 },
              { 1, 0, -1 } };
  }else if (key == 'i') {
    matrix = { {-1, 0, 1 },
              {-2, 0, 2 },
              {-1, 0, 1 } };
  }else if (key == 'j') {
    matrix = { { 1, 2, 1 },
              { 0, 0, 0 },
              {-1, -2, -1 } };
  }else if (key == 'k') {
    inv = !inv;
  }
  // Normal
  else if (key == 'l') {
    matrix = { { 0, 0, 0 },
               { 0, 1, 0 },
               { 0, 0, 0 } };
    inv = false;
  }
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PGraphics mask){
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = x+i;
      int yloc = y+j;
      int loc = xloc + mask.width*yloc;
      loc = constrain(loc,0,mask.pixels.length-1);
      rtotal += (red(mask.pixels[loc]) * matrix[i][j]);
      gtotal += (green(mask.pixels[loc]) * matrix[i][j]);
      btotal += (blue(mask.pixels[loc]) * matrix[i][j]);
    }
  }
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  if(!inv){
      return color(rtotal, gtotal, btotal);
    }else{
      return color(255-rtotal, 255-gtotal, 255-btotal)
    }
}
```
