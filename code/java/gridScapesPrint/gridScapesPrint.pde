import processing.pdf.*;

int WIDTH = 800;
int HEIGHT = 800;

// 6 3 1 12 2 
int SCALE = 6;
int MAX_WEIGHT = 3;
int MIN_WEIGHT = 1;
int MAX_LENGTH = 12;
int MIN_LENGTH = 2;

// Load all names from the images folder
File file = new File(sketchPath() + "/images");

// Store a list with the names
String images[] = file.list();

// Creates a grid-scape for each image name in the folder
for (int index = 0; index < images.length; index++) {
  
  // Get the current image name
  String current = images[index];
  
  // Create a image object from that name
  PImage landscape = loadImage("images/"  + current);
  
  // Resize the input image 
  landscape.resize(WIDTH, HEIGHT);
  
  // Create a buffer for the PDF
  PGraphics pdf = createGraphics(WIDTH, HEIGHT, PDF, "out/" + current + ".pdf");
  
  // Draw the grid-scape
  pdf.beginDraw();
  
  for (int x = 0; x < WIDTH; x+=SCALE) {
    for (int y = 0; y < HEIGHT; y+=SCALE) {
      color c = landscape.get(x, y);
      pdf.pushMatrix();
      pdf.translate(x, y);
      pdf.strokeWeight(map(blue(c), 0, 255, MAX_WEIGHT, MIN_WEIGHT));
      pdf.rotate(map(red(c), 0, 255, 0, TAU));
      pdf.line(0, 0, (map(green(c), 0, 255, MAX_LENGTH, MIN_LENGTH)), 0);
      pdf.popMatrix();
    }
  }
  pdf.dispose();
  pdf.endDraw();
}

exit();
