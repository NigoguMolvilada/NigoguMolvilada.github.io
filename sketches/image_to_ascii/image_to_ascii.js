let webImg;
let webImgColor;
let resolution = 4;
let ascii;

function preload() {
    webImg = loadImage('/sketches/image_to_ascii/perro.PNG');
    webImgColor = loadImage('/sketches/image_to_ascii/perro.PNG');
}

function setup() {
    var myCanvas = createCanvas(749,422); 
    myCanvas.parent("sketch-holder");   
    ascii = new Array(256);
    let chars = "@%#*+=-:. ";
    for (let i = 0; i < 256; i++) {
        let index = parseInt(map(i, 0, 256, 0, chars.length));
        ascii[i] = chars.charAt(index);
    }
    textFont("Roboto Mono", resolution + 2); 
    
}

function draw(){
    background(255);
    fill(0);

    if (mouseIsPressed) {
        image(webImgColor,0,0);
    } else {
        asciify();
    }

}

function asciify() {
  webImg.filter(GRAY);
  
  webImg.loadPixels();
   
  for (var y = 0; y < webImg.height; y += resolution) {
    for (var x = 0; x < webImg.width; x += resolution) {
        let pixel = webImg.get(x,y);
        text(ascii[int(brightness(pixel))], x, y);
    }
  }
}

// function setup() {
//     var myCanvas = createCanvas(100, 100);
//     myCanvas.parent("sketch-holder");
// }

// function draw() {
//   ellipse(50, 50, 80, 80);
// }