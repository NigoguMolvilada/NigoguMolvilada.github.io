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
  img = loadImage("/sketches/histogram/Wimbledon.jpg");
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
    img = loadImage("/sketches/histogram/Australia.jpg");
    newImage(img);
  }if(key == 'b'){
    img = loadImage("/sketches/histogram/RolandGarros.jpg");
    newImage(img);
  }if(key == 'c'){
    img = loadImage("/sketches/histogram/Wimbledon.jpg");
    newImage(img);
  }if(key == 'd'){
    img = loadImage("/sketches/histogram/USOpen.jpg");
    newImage(img);
  }if(key == 'e'){
    img = loadImage("/sketches/histogram/OldWimbledon.jpg");
    newImage(img);
  }  
}
