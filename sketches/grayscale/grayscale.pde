PImage img;
PGraphics original;
PGraphics grayscale;
String grayscaleType = "RGB";

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