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
  Img = loadImage("/sketches/image_to_ascii/koala.jpg");
  ImgColor = loadImage("/sketches/image_to_ascii/koala.jpg");
  
  // Se determina el tamaño de la ventana de Processing (donde se va a mostrar la imagen resultado):
  size(864,864);
  noStroke();
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
  // Se determina el color de fondo de ventana de processing (blanco).
  background(255);
  // Se determina el color de los caracteres (negro).
  fill(0);
  
  // Se determina la acción que activa el cambio.
  
  if (mousePressed == true) {
    set(0, 0, ImgColor)
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
