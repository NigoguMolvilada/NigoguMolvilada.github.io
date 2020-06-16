---
layout: post
title: "Conversión a escala de grises"
date: 2020-04-27 22:16:00 -0500
permalink: /grayscale
---

En este post se hace una documentación del estudio realizado para convertir una imagen a escala de grises por medio de diferntes métodos, utilizando [Processing](https://processing.org/).

<script src="processing.js"></script>
<script type="text/javascript" async
    src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

El primer método, y más intuitivo, es convertir la imagen a escala de grises sacando el promedio aritmético de los valores RGB.

$$\displaystyle G=\frac{R+G+B}{3}$$

El segundo método es calculando la variable luma. Para eso se utiliza la siguiente ecuación:

$$\displaystyle Y'_{\text{601}}=0.299R+0.587G+0.114B$$

Los valores de los pesos para cada color recomendados varían según el tipo de pantalla. El Y601 es el más conocido y se hizo originalmente para SDTV. Otros pesos para calcular la variable luma existen para HDTV (Y709), UHDTV HDR (Y2020) y de Adobe (Y240).

Los valores de los pesos se pueden encontrar haciendo [click acá](https://en.wikipedia.org/wiki/HSL_and_HSV#Lightness).

Adicionalmente, se utilizaron dos métodos más, empleando los modelos HSV y HSL. En ellos se le da especial importancia al valor máximo de los valores RGB de cada pixel, siendo esta la única variable tenida en cuenta por HSV. HSL toma este valor y lo promedia con el valor RGB mínimo del mismo pixel.

A continuación se puede observar el resultado obtenido.

<canvas data-processing-sources="/sketches/grayscale_img/grayscale.pde"></canvas>

- **a** para ver la conversión con promedio aritmético de valores RGB.
- **b** para ver la conversión utilizando la variable luma (Y601).
- **c** para ver la conversión utilizando el modelo HSV (hexcone).
- **d** para ver la conversión utilizando el modelo HSL (bi-hexcone).
- **e, f y g** para ver la conversión utilizando la variable luma con los pesos Y240, Y709 y Y2020. El resultado de es casi indistinguible de Y601.

El código en processing es el siguiente:

```java
PImage img;
PGraphics original;
PGraphics grayscale;
String grayscaleType = "RGB"; //Valor inicial

void setup() {
  size(844, 310);
  img = loadImage("fire.jpg");
  original = createGraphics(422, 310);
  grayscale = createGraphics(422, 310);
  noStroke();
}

void draw() {
  original.beginDraw();
  original.image(img, 0, 0);
  original.endDraw();
  grayscale.beginDraw();
  grayscale.image(img, 0, 0);
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
  if(key == 'a'){ //Promedio aritmético
    grayscaleType = "RGB";
  }else if (key == 'b'){ //Y601
    grayscaleType = "luma";
  } else if (key == 'c'){ //Hexcone
    grayscaleType = "HSV";
  } else if (key == 'd'){ //Bi-hexcone
    grayscaleType = "HSL";
  } else if (key == 'e'){ //Y240
    grayscaleType = "Adobe";
  } else if (key == 'f'){ //Y709
    grayscaleType = "HDTV";
  } else if (key == 'g'){ //Y2020
    grayscaleType = "UHDTVHDR";
  }
}

color conversion(int x, int y, String grayscaleType){
  int gray = 0;
  color pixel = get(x,y);
  float pred = red(pixel);
  float pgreen = green(pixel);
  float pblue = blue(pixel);
  switch (grayscaleType) {
    case "RGB":
      gray = (int) (pred + pgreen + pblue)/3;
      break;
    case "luma":
      gray = (int) (0.2989*pred + 0.5870*pgreen + 0.1140*pblue);
      break;
    case "HSV":
      gray = (int) max(pred, pgreen, pblue);
      break;
    case "HSL":
      gray = (int) (max(pred, pgreen, pblue) + min(pred, pgreen, pblue))/2;
      break;
    case "Adobe":
      gray = (int) (0.212*pred + 0.701*pgreen + 0.087*pblue);
      break;
    case "HDTV":
      gray = (int) (0.2126*pred + 0.7152*pgreen + 0.0722*pblue);
      break;
    case "UHDTVHDR":
      gray = (int) (0.2627*pred + 0.6780*pgreen + 0.0593*pblue);
      break;
  }
  return color(gray, gray, gray);
}
```
