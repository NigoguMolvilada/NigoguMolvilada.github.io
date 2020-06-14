// Programa para pasar imagen a texto.

// PImage es un tipo de dato para almacenar imágenes. Se crea la variable Img.
PImage Img;
PImage ImgColor;
PGraphics original;
PGraphics asciiPG;
int[] backgroundColor = {255,255,255};
int[] fillColor = {0,0,0};

// Resolución de muestreo: los colores se muestrearán cada n pixeles para determinar qué caracter mostrar.
int resolution = 6;

// Arreglo de tipo char que va a contener los caracteres en reemplazo de los píxeles.
char[] ascii;

void setup() {
  // Se carga la imagen.
  Img = loadImage("sketches/image_to_ascii/koala.jpg");
  ImgColor = loadImage("sketches/image_to_ascii/koala.jpg");
  
  // Se determina el tamaño de la ventana de Processing (donde se va a mostrar la imagen resultado):
  size(1500,750);
  noStroke();
  // Se inicializa el arreglo que corresponde a los valores de brillo (256 es la cantidad de valores de brillantez):
  ascii = new char[256];

  original = createGraphics(750, 750);
  asciiPG = createGraphics(750, 750);
  
  // Se crea un arreglo de char llamado chars que contiene los caracteres a utilizar:
  String chars = "@%#*+=-:. ";
  
  // Se llena el arreglo ASCII de manera que sus posiciones se vayan llenando de acuerdo a los caracteres
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, chars.length()));
    ascii[i] = chars.charAt(index);
  }
  
  // PFont es un tipo de dato para almacenar fuentes.
  // Se determina qué fuente y tamaño de fuente se va a usar.
  PFont mono = createFont("Consolas", resolution + 2);
  textFont(mono);  
}

void draw(){
  // Se determina el color de fondo de ventana de processing (blanco).
  background(255);
  // Se determina el color de los caracteres (negro).
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
  // Ya que el resultado se hará solo en blanco y negro, se hace la conversión de la imagen a escala de grises para calcular de forma más precisa el brillo.
  Img.filter(GRAY);
  Img.loadPixels();
  asciiPG.fill(fillColor[0], fillColor[1], fillColor[2]);
  asciiPG.background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
  // Toma el color de cada enésimo píxel de la imagen y lo reemplaza con el carácter de brillo similar.
  for (int y = 0; y < Img.height; y += resolution) {
    for (int x = 0; x < Img.width; x += resolution) {
      color pixel = Img.get(x,y);
      // Se imprime el caracter determinado a ese brillo, en la posicion (x, y)
      asciiPG.text(ascii[int(brightness(pixel))], x, y);
    }
  }
}