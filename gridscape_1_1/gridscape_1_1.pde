import processing.pdf.*;

String[] images = {
  "hochschwab", 
  "schoeckl", 
  "rotewand"
};

int scl = 6;
int pad = 40;
int image = 0;

void settings () {
  size(800, 800);
}

void setup() {
  while (image < images.length) {
    String path = images[image];

    beginRecord(PDF, "out/" + path +".pdf");
    background(255);

    PImage landscape = loadImage(path + ".jpg");
    landscape.resize(width, height);

    PGraphics gridscape = createGraphics(width, height);
    gridscape.beginDraw();
    for (int x = 0; x < width; x+=scl) {
      for (int y = 0; y < height; y+=scl) {
        color c = landscape.get(x, y);
        gridscape.pushMatrix();
        gridscape.translate(x, y);
        gridscape.strokeWeight(map(blue(c), 0, 255, 3, 1));
        gridscape.rotate(map(red(c), 0, 255, 0, TAU));
        gridscape.line(0, 0, (map(green(c), 0, 255, 12, 2)), 0);
        gridscape.popMatrix();
      }
    }
    gridscape.endDraw();
    image(gridscape, pad, pad, width-pad*2, height-pad*2);
    noFill();
    strokeWeight(2);
    rect(pad, pad, width-pad*2, height-pad*2);
    fill(0);
    endRecord();
    save("out/" + path + ".jpg");
    image++;
  }

  exit();
}
