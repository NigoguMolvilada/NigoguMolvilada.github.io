PImage img;
PGraphics original;
PGraphics grayscale;
String grayscaleType = "RGB"; //Valor inicial

void setup() {
  size(844, 310);
  img = loadImage("/sketches/grayscale/fire.jpg"); 
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
  if(key == 'a'){ //Promedio aritmético
    grayscaleType = "RGB";
  }else if (key == 'b'){ //Y601
    grayscaleType = "luma";
  } else if (key == 'c'){ //Hexcone
    grayscaleType = "HSV"
  } else if (key == 'd'){ //Bi-hexcone
    grayscaleType = "HSL" 
  } else if (key == 'e'){ //Y240
    grayscaleType = "Adobe"
  } else if (key == 'f'){ //Y709
    grayscaleType = "HDTV"
  } else if (key == 'g'){ //Y2020
    grayscaleType = "UHDTVHDR"
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
      gray = max(pred, pgreen, pblue);
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
