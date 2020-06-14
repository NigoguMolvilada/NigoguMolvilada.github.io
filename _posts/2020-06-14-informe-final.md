---
layout: post
title: "Informe talleres procesamiento de imágenes"
date: 2020-06-14 16:13:00 -0500
permalink: /static-page
---

### 1 Motivación y objetivo

<p style='text-align: justify;'>La motivación para llevar a cabo los talleres propuestos sobre procesamiento de imágenes viene del interés de saber como funciona todo lo relacionado con filtros, que pueden ser vistos actualmente en muchas aplicaciones y páginas web para el procesamiento de imágenes. Por lo anterior el objetivo de ésta prácticas es investigar y aprender como llevar a cabo estas tácticas. </p>

### 2 Metodología

<p style='text-align: justify;'>Se utilizó Processing como lenguaje de programación para realizar el procesamiento de imágenes y vídeos por medio de software. Para hacer dichas acciones por medio de hardware se utilizó Processing junto con OpenGL. En los vídeos se puso su eficiencia computacional (en FPS) y a cada imagen su histograma respectivo.</p>

### 3 Resultados

#### 3.1 Conversión a escala de grises

<p style='text-align: justify;'>Se realizó la conversión a escala de grises de una imagen por medio de varios métodos: promedio RGB, luma, HSV, HSL, Adobe, HDTV y UHDTVHDR.
El proceso realizado fue sacar el color de cada píxel, y por medio de algunas ecuaciones sacar un número, utilizado para el determinar el nuevo color RGB, donde tanto el rojo, como el verde y azul tendrían el mismo valor (ej. R = luma, G = luma, B = luma). Las ecuaciones utilizadas fueron:</p>

$$\displaystyle promedio RGB=\frac{R+G+B}{3} $$

$$\displaystyle luma = 0.2989*R + 0.5870*G + 0.1140*B $$

$$\displaystyle HSV = max(R,G,B) $$

$$\displaystyle HSL = \frac{max(R,G,B) + min(R,G,B)}{2} $$

$$\displaystyle Adobe = 0.212*R + 0.701*G + 0.087*B $$

$$\displaystyle HDTV = 0.2126*R + 0.7152*G + 0.0722*B $$

$$\displaystyle UHDTVHDR = 0.2627*R + 0.6780*G + 0.0593*B $$

<p style='text-align: justify;'>Al hacer una comparación entre todas las ecuaciones y ver los resultados se observó que cada uno se enfoca en algo distinto, luma en iluminación, HSL mejor el brillo, etc.
Al hacerlo por medio de hardware lo que se hizo fue mandar el valor de los pesos en las ecuaciones y una bandera para saber que tipo de ecuación eso (basado por pesos, HSV o HLS).
Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.
</p>
Los resultados pueden ser vistos en [Conversión a escala de grises]({{ site.baseurl }}{% link _posts/2020-04-27-grayscale.md %})

#### 3.2 Aplicación de algunas máscaras de convolución

<p style='text-align: justify;'>Esta práctica se hizo teniendo en cuenta la lectura recomendada sobre el procesamiento de imágenes por medio de kernels o también llamadas matrices de convolución https://en.wikipedia.org/wiki/Kernel_(image_processing)
Se realizaron 6 operaciones básicas, detección de bordes, difuminado, realzado, afilado, sobel y negativo.
El proceso básico es coger un píxel y los pixeles que lo rodean, multiplicar valor por valor el color de cada píxel por la matriz de convolución, y sumarlos. El resultado de esa operación será el nuevo color del píxel de la mitad. Hay que tener en cuenta que, si alguna operación supera el valor de 255, se tomará el 255, de igual manera si es menor a 0, se tomará el 0.</p>

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

$$\displaystyle R = 0* -1+255* -1+0*-1+0* -1+8*255+255* -1+0* -1+255* -1+0* -1 = 1275 = 255   $$

$$\displaystyle G = 0*-1+255*-1+255*-1+0*-1+0*8+255*-1+255*-1+0*-1+0*-1 = -1020 = 0  $$

$$\displaystyle B = 0*-1+255*-1+0*-1+255*-1+0*8+0*-1+255*-1+255*-1+0*-1 = -1020 = 0  $$

<p style='text-align: justify;'>En este ejemplo con una matriz de convolución para detección de bordes, al hacer las operaciones conserva el mismo color (255,0,0).
Todo el proceso descrito anteriormente fue el implementando en Processing, probando con varias matrices de convolución. Para hacerlo por hardware se hace lo mismo, pero la matriz de convolución a tratar es mandada desde Processing. Para este caso solo se implementaron matrices de convolución de 3x3.
Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.</p>
Los resultados pueden ser vistos en [Máscaras de convolución]({{ site.baseurl }}{% link _posts/2020-03-26-masks-for-pictures.md %})

#### 3.3 Conversión a ASCII

<p style='text-align: justify;'> Lo que se hizo aquí convertir la imagen a escala de grises y luego mirar la luminancia de cada píxel y dependiendo de ello poner el carácter respectivo. La idea no es analizar píxel por píxel y poner un carácter, ya que no se notaría, por lo tanto, se determinó un valor, en este caso 5, para analizar cada 5 pixeles. Los caractéres utilizados fueron <strong>@%#*+=-:. </strong> . Están del más denso @, al menos denso, el espacio en blanco.
Para el procesamiento de video se hizo lo mismo que en el de imagen, solo que en este caso la imagen se va actualizando, dependiendo del frame del video.
</p>

Los resultados pueden ser vistos en [Imágenes a ASCII]({{ site.baseurl }}{% link _posts/2020-03-17-image-to-ascii.md %})

#### 3.4 Histograma para imágenes

#### 3.5 Eficiencia computacional

A cada vídeo se le hizo un análisis de eficiencia computacional, es decir los FPS (frames per second). Algo evidente fue que en algunos casos se podía observar como la eficiencia del procesamiento de videos por hardware es mucho mejor que la del procesamiento por software.

### 4 Conclusiones
