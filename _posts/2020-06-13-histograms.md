---
layout: post
title: "Histogramas en Processing"
date: 2020-06-13 16:13:00 -0500
permalink: /histograms
---

En este post se hace una documentación del estudio realizado para extraer el histograma de una imagen a través de [Processing](https://processing.org/).

<script src="processing.js"></script>

Para importar este código en ProcessingJS fue necesario declarar líneas adicionales al principio del archivo que permiten importar las imágenes antes de que el sketch se cargue. Esto permite utilizar las propiedades de las imágenes apropiadamente. Más información en [este link](http://processingjs.org/articles/jsQuickStart.html#synchronousIO).

Para realizar esta práctica se hizo una investigación sobre qué es un histograma porque, aunque se habían visto al realizar edición de fotografías, no se sabía exactamente qué representaban. [Este video](https://www.youtube.com/watch?v=2LhfSgrjdGo) fue uno de los más claros para entenderlo. Llevar el concepto a Processing fue sencillo teniendo en cuenta que ya se conocía el método .get(x, y) para obtener la información de un pixel en una imagen y brightness(pixel) para obtener su nivel de brillo. Se utilizaron también los métodos red(pixel), green(pixel) y blue(pixel) aprendidos en la conversión a escala de grises para calcular el histograma correspondiente a estos canales de color.

El código realizado itera por todos los pixeles de la imagen y guarda sus propiedades en arreglos de 256 posiciones. Cada elemento de estos arreglos indica cuántos pixeles tienen el nivel de brillo, rojo, verde o azul igual al valor de la posición del arreglo en la que se encuentran (e.g. si el arreglo que almacena los niveles de azul en la posición 50 tiene un valor de 3.000, significa que 3.000 pixeles de la imagen tienen un valor de 50 en este canal de color). Cada valor de los arreglos de cada histograma se grafica a través del método .line(). El usuario puede habilitar o deshabilitar los histogramas que deseé a través de la entrada de teclado y también cambiar la imagen analizada.

- **1** para mostrar el histograma de brillantez.
- **2** para mostrar el histograma del color rojo (R).
- **3** para mostrar el histograma del color verde (G).
- **3** para mostrar el histograma del color azul (B).
- **5** para ocultar todos los histogramas.
- **6** para mostrar todos los histogramas.
- **a, b, c, d, e** para cambiar la imagen analizada.

<canvas data-processing-sources="/sketches/histogram/histogram.pde"></canvas>

El código en Processing es el siguiente:

```java
PImage img;
PGraphics original;
PGraphics mask;
int[] hist;
int[] histR;
int[] histG;
int[] histB;
int histMax;
int histRMax;
int histGMax;
int histBMax;
boolean Bhist = true;
boolean BhistR = false;
boolean BhistG = false;
boolean BhistB = false;

void setup(){
  size(640, 720);
  img = loadImage("Wimbledon.jpg");
  original = createGraphics(640, 360);
  mask = createGraphics(640, 360);
  newImage(img);
}

void draw() {
  original.beginDraw();
  original.image(img,0,0);
  original.endDraw();
  mask.beginDraw();
  mask.background(255);

  if(Bhist){
    mask.stroke(0,0,0,255);
    for (int i = 0; i < img.width; i += 2) {
      int which = int(map(i, 0, img.width, 0, 255));
      int y = int(map(hist[which], 0, histMax, img.height, 0));
      mask.line(i, img.height, i, y);
    }
  }

  if(BhistR){
    mask.stroke(255,0,0,100);
    for (int i = 0; i < img.width; i += 2) {
      int which = int(map(i, 0, img.width, 0, 255));
      int y = int(map(histR[which], 0, histRMax, img.height, 0));
      mask.line(i, img.height, i, y);
    }
  }

  if(BhistG){
    mask.stroke(0,255,0,100);
    for (int i = 0; i < img.width; i += 2) {
      int which = int(map(i, 0, img.width, 0, 255));
      int y = int(map(histG[which], 0, histGMax, img.height, 0));
      mask.line(i, img.height, i, y);
    }
  }

  if(BhistB){
    mask.stroke(0,0,255,100);
    for (int i = 0; i < img.width; i += 2) {
      int which = int(map(i, 0, img.width, 0, 255));
      int y = int(map(histB[which], 0, histBMax, img.height, 0));
      mask.line(i, img.height, i, y);
    }
  }

  mask.endDraw();
  image(original, 0, 0);
  image(mask, 0, 360);
}

void newImage(PImage image) {
  hist = new int[256];
  histR = new int[256];
  histG = new int[256];
  histB = new int[256];

  for (int i = 0; i < image.width; i++) {
    for (int j = 0; j < image.height; j++) {
      int pixel = image.get(i, j);
      hist[int(brightness(pixel))]++;
      histR[int(red(pixel))]++;
      histG[int(green(pixel))]++;
      histB[int(blue(pixel))]++;
    }
  }
  histMax = max(hist);
  histRMax = max(histR);
  histGMax = max(histG);
  histBMax = max(histB);
}

void keyPressed(){
  if(key == '1'){
    Bhist = !Bhist;
  }if(key == '2'){
    BhistR = !BhistR;
  }if(key == '3'){
    BhistG = !BhistG;
  }if(key == '4'){
    BhistB = !BhistB;
  }if(key == '5'){
    Bhist = false;
    BhistR = false;
    BhistG = false;
    BhistB = false;
  }if(key == '6'){
    Bhist = true;
    BhistR = true;
    BhistG = true;
    BhistB = true;
  }if(key == 'a'){
    img = loadImage("Australia.jpg");
    newImage(img);
  }if(key == 'b'){
    img = loadImage("RolandGarros.jpg");
    newImage(img);
  }if(key == 'c'){
    img = loadImage("Wimbledon.jpg");
    newImage(img);
  }if(key == 'd'){
    img = loadImage("USOpen.jpg");
    newImage(img);
  }if(key == 'e'){
    img = loadImage("OldWimbledon.jpg");
    newImage(img);
  }
}

```
