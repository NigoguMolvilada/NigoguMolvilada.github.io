let Img;
let ImgColor;
let resolution = 3;
let ascii;
let myFont;

function preload() {
  Img = loadImage("/sketches/image_to_ascii/perro.PNG");
  ImgColor = loadImage("/sketches/image_to_ascii/perro.PNG");
}

function setup() {
  var myCanvas = createCanvas(749, 422);
  myCanvas.parent("sketch-holder");
  ascii = new Array(256);
  let chars = "@%#*+o=-:. ";
  for (let i = 0; i < 256; i++) {
    let index = parseInt(map(i, 0, 256, 0, chars.length));
    ascii[i] = chars.charAt(index);
  }
  textFont("Roboto");
  textSize(resolution + 2);
}

function draw() {
  background(255);
  fill(0);

  if (mouseIsPressed) {
    image(ImgColor, 0, 0);
  } else {
    asciify();
  }
}

function asciify() {
  Img.filter(GRAY);
  Img.loadPixels();

  for (var y = 0; y < Img.height; y += resolution) {
    for (var x = 0; x < Img.width; x += resolution) {
      let pixel = Img.get(x, y);
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}
