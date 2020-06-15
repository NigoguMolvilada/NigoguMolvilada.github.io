---
layout: post
title: "Informe talleres procesamiento de imágenes"
date: 2020-06-14 16:13:00 -0500
permalink: /informe-final
---

{: style="text-align: justify" }
El presente post es el informe final de los talleres de procesamiento de imágenes realizados para la asignatura Computación Visual por [los autores de este blog]({{site.baseurl}}/about/).

### 1. Motivación y objetivo

{: style="text-align: justify" }
La motivación para llevar a cabo los talleres propuestos sobre procesamiento de imágenes viene del interés de saber como funciona todo lo relacionado con filtros, que pueden ser vistos actualmente en muchas aplicaciones y páginas web para el procesamiento de imágenes. Por lo anterior el objetivo de ésta prácticas es investigar y aprender como llevar a cabo estas tácticas.

### 2. Metodología

{: style="text-align: justify" }
Se utilizó Processing como lenguaje de programación para realizar el procesamiento de imágenes y vídeos por medio de software. Para hacer dichas acciones por medio de hardware se utilizó Processing junto con OpenGL. En los vídeos se puso su eficiencia computacional (en FPS) y a cada imagen su histograma respectivo.

### 3. Resultados

#### 3.1. Conversión a escala de grises

{: style="text-align: justify" }
Se realizó la conversión a escala de grises de una imagen por medio de varios métodos: promedio RGB, luma, HSV, HSL, Adobe, HDTV y UHDTVHDR.

{: style="text-align: justify" }
El proceso realizado fue sacar el color de cada píxel, y por medio de algunas ecuaciones sacar un número, utilizado para el determinar el nuevo color RGB, donde tanto el rojo, como el verde y azul tendrían el mismo valor (e.g. R = luma, G = luma, B = luma). Las ecuaciones utilizadas fueron:

$$\displaystyle promedio RGB=\frac{R+G+B}{3} $$

$$\displaystyle luma = 0.2989*R + 0.5870*G + 0.1140*B $$

$$\displaystyle HSV = max(R,G,B) $$

$$\displaystyle HSL = \frac{max(R,G,B) + min(R,G,B)}{2} $$

$$\displaystyle Adobe = 0.212*R + 0.701*G + 0.087*B $$

$$\displaystyle HDTV = 0.2126*R + 0.7152*G + 0.0722*B $$

$$\displaystyle UHDTVHDR = 0.2627*R + 0.6780*G + 0.0593*B $$

{: style="text-align: justify" }
Al hacer una comparación entre todas las ecuaciones y ver los resultados se observó que cada uno se enfoca en algo distinto, luma en iluminación, HSL mejor el brillo, etc.

{: style="text-align: justify" }
Al hacerlo por medio de hardware lo que se hizo fue mandar el valor de los pesos en las ecuaciones y una bandera para saber que tipo de ecuación eso (basado por pesos, HSV o HLS). Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.

{: style="text-align: justify" }
Los resultados pueden ser vistos en [Conversión a escala de grises](site.baseurl/grayscale/).

#### 3.2. Aplicación de algunas máscaras de convolución

{: style="text-align: justify" }
Esta práctica se hizo teniendo en cuenta la lectura recomendada sobre el procesamiento de imágenes por medio de kernels o también llamadas matrices de convolución https://en.wikipedia.org/wiki/Kernel_(image_processing). Se realizaron 6 operaciones básicas, detección de bordes, difuminado, realzado, afilado, sobel y negativo.

{: style="text-align: justify" }
El proceso básico es coger un píxel y los pixeles que lo rodean, multiplicar valor por valor el color de cada píxel por la matriz de convolución, y sumarlos. El resultado de esa operación será el nuevo color del píxel de la mitad. Hay que tener en cuenta que, si alguna operación supera el valor de 255, se tomará el 255, de igual manera si es menor a 0, se tomará el 0.

_Color RGB de cada píxel, el píxel de interés es de la mitad_

$$
\begin{bmatrix}
(0,0,0) & (255,255,255) & (0,255,0) \\
(0,0,255) & (255,0,0) & (255,255,0) \\
(0,255,255) & (255,0,255) & (0,0,0) \\
\end{bmatrix}
$$

_Matriz de convolución_

$$
\begin{bmatrix}
-1 & -1 & -1 \\
-1 & 8 & -1 \\
-1 & -1 & -1 \\
\end{bmatrix}
$$

$$\displaystyle R = 0*-1 + 255*-1 + 0*-1 + 0*-1 + 8*255 + 255*-1$$
$$+ 0*-1 + 255*-1 + 0*-1 = 1275 = 255$$

$$\displaystyle G = 0*-1 + 255*-1 + 255*-1 + 0*-1 + 0*8 + 255*-1$$
$$+ 255*-1 + 0*-1 + 0*-1 = -1020 = 0$$

$$\displaystyle B = 0*-1 + 255*-1 + 0*-1 + 255*-1 + 0*8 + 0*-1$$
$$+ 255*-1 + 255*-1 + 0*-1 = -1020 = 0$$

{: style="text-align: justify" }
En este ejemplo con una matriz de convolución para detección de bordes, al hacer las operaciones conserva el mismo color (255,0,0). Todo el proceso descrito anteriormente fue el implementando en Processing, probando con varias matrices de convolución. Para hacerlo por hardware se hace lo mismo, pero la matriz de convolución a tratar es mandada desde Processing. Para este caso solo se implementaron matrices de convolución de 3x3.

{: style="text-align: justify" }
Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.

{: style="text-align: justify" }
Los resultados pueden ser vistos en [Máscaras de convolución]({{site.baseurl}}/masks-for-pictures/).

#### 3.3. Conversión a ASCII

{: style="text-align: justify" }
Lo que se hizo aquí convertir la imagen a escala de grises y luego mirar la luminancia de cada píxel y dependiendo de ello poner el carácter respectivo. La idea no es analizar píxel por píxel y poner un carácter, ya que no se notaría, por lo tanto, se determinó un valor, en este caso 5, para analizar cada 5 pixeles. Los caractéres utilizados fueron <strong>@%#\*+=-:. </strong>. Están del más denso @, al menos denso, el espacio en blanco.

{: style="text-align: justify" }
Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.

{: style="text-align: justify" }
Los resultados pueden ser vistos en [Imágenes a ASCII]({{site.baseurl}}/image-to-ascii/).

#### 3.4. Histograma para imágenes

{: style="text-align: justify" }
Para realizar esta práctica se hizo una investigación sobre qué es un histograma porque, aunque se habían visto al realizar edición de fotografías, no se sabía exactamente qué representaban. [Este video](https://www.youtube.com/watch?v=2LhfSgrjdGo) fue uno de los más claros para entenderlo. Llevar el concepto a Processing fue sencillo teniendo en cuenta que ya se conocía el método .get(x, y) para obtener la información de un pixel en una imagen y brightness(pixel) para obtener su nivel de brillo. Se utilizaron también los métodos red(pixel), green(pixel) y blue(pixel) aprendidos en la conversión a escala de grises para calcular el histograma correspondiente a estos canales de color.

{: style="text-align: justify" }
El código realizado itera por todos los pixeles de la imagen y guarda sus propiedades en arreglos de 256 posiciones. Cada elemento de estos arreglos indica cuántos pixeles tienen el nivel de brillo, rojo, verde o azul igual al valor de la posición del arreglo en la que se encuentran (e.g. si el arreglo que almacena los niveles de azul en la posición 50 tiene un valor de 3.000, significa que 3.000 pixeles de la imagen tienen un valor de 50 en este canal de color). Cada valor de los arreglos de cada histograma se grafica a través del método .line(). El usuario puede habilitar o deshabilitar los histogramas que deseé a través de la entrada de teclado y también cambiar la imagen analizada.

#### 3.5. Eficiencia computacional

{: style="text-align: justify" }
A cada vídeo se le hizo un análisis de eficiencia computacional, es decir los FPS (frames per second). Algo evidente fue que en algunos casos se podía observar como la eficiencia del procesamiento de videos por hardware es mucho mejor que la del procesamiento por software.

A continuación se puede observar un ejemplo con máscaras de convolución.

Por software
<video width="1280" height="360" autoplay="autoplay" controls="controls" name="media">

<source src="/videos/shaders_video.webm" type="video/webm">
<source src="/videos/shaders_video.mp4" type="video/mp4">
</video>

Por hardware
<video width="1280" height="360" autoplay="autoplay" controls="controls" name="media">

<source src="/videos/shaders_video_h.webm" type="video/webm">
<source src="/videos/shaders_video_h.mp4" type="video/mp4">
</video>

### 4. Conclusiones
