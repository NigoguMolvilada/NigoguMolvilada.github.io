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

color HSBtoRGB(color pixel){
  colorMode(HSB);
  float phue = hue(pixel);
  float psaturation = saturation(pixel);
  float pluma = red(pixel)*0.2989 + green(pixel)*0.5870 + blue(pixel)*0.1140;
  //float pluma = red(pixel)*0.2126 + green(pixel)*0.7152 + blue(pixel)*0.0722;
  // float pluma = brightness(pixel);
  return color(phue, psaturation, pluma);
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
      color newColor = HSBtoRGB(pixel);   
      // return newColor;
      pred = red(newColor);
      pgreen = green(newColor);
      pblue = blue(newColor);    
      gray = (int)(pred + pgreen + pblue)/3;
      break;
  }
  colorMode(RGB);
  return color(gray, gray, gray);
}