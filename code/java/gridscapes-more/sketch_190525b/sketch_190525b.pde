import processing.pdf.*;

double stamp = System.currentTimeMillis();

void setup() 
{
  size(800, 800);
  background(255);  
  int scl = 6;
  
  PImage landscape = loadImage("hochschwab.png");
  landscape.resize(width, height);

  PGraphics gridscape = createGraphics(width, height);

  beginRaw(PDF, "out/gridscape-" + stamp + ".pdf");
  
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

  // Draw the resulting image smaller than the screen
  int pad = 40;

  image(gridscape, pad, pad, width-pad*2, height-pad*2);

  // Add a border to the image 
  noFill();
  strokeWeight(2);
  rect(pad, pad, width-pad*2, height-pad*2);
  endRaw();

  save("out/gridscape-"+ stamp + ".jpg");

  exit();
}
