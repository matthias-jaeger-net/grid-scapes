import processing.pdf.*;

void setup() 
{
  size(800, 800, P3D);
  background(255);  
  String filePath = "images/";
  String fileName = "hochschwab";
  String fileExt = ".jpg";
  int scl = 6;
  
  PImage landscape = loadImage(filePath + fileName + fileExt);
  landscape.resize(width, height);

  beginRaw(PDF, "out/" + fileName + ".pdf");
  for (int x = 0; x < width; x+=scl) {
    for (int y = 0; y < height; y+=scl) {
      color c = landscape.get(x, y);
      pushMatrix();
      translate(x + scl * 0.5, y + scl * 0.5, 0.0);
      strokeWeight(map(blue(c), 0, 255, 3, 1));
      rotate(map(red(c), 0, 255, 0, TAU));
      line(0, 0, (map(green(c), 0, 255, 12, 2)), 0);
      popMatrix();
    }
  }
  endRaw();
  save("out/" + fileName + ".jpg");
  exit();
}
