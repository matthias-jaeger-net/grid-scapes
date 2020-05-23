import processing.pdf.*;
int scl = 6;
  
void setup(){
  size(800, 800, PDF, "out/out.pdf");
  background(255);  

  
  PImage landscape = loadImage("hochschwab.png");
  landscape.resize(width, height);
  
  for (int x = 0; x < width; x+=scl) {
    for (int y = 0; y < height; y+=scl) {
      color c = landscape.get(x, y);
      pushMatrix();
      translate(x, y);
      strokeWeight(map(blue(c), 0, 255, 3, 1));
      rotate(map(red(c), 0, 255, 0, TAU));
      line(0, 0, (map(green(c), 0, 255, 12, 2)), 0);
      popMatrix();
    }
  }
  exit();
}
