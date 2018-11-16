/** 
* gridScapes 
* 
* This program renders series of abstract line graphics, 
* based on three small resolution images. 
* 
* Matthias Jäger, Graz 2018
*/

// Names of the given input images
String[] images = {
  "hochschwab", 
  "schoeckl", 
  "rotewand",
  "hochreichart",
  "grossofen",
  "ringkogel"
};

// Program counter
int image = 0;

// Design Parameters
int scl = 6;
int pad = 40;

// Utils to export a pdf 
import processing.pdf.*;

// setup called automatically
void setup() {
  
  // Set a square canvas
  size(800, 800);
    
  
  // Iterate over the given images
  while (image < images.length) {
    background(255);  

    
    // Store each image as path 
    String path = images[image];
    
    // Start pdf 
    beginRecord(PDF, "out/"+ path + "/" + path +".pdf");
    
    PImage landscape = loadImage("in/" + path + ".jpg");
    landscape.resize(width, height);

    // Reading the loaded landscape and render a grid of lines,
    // based on the red, blue and green values of the image
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

    
    // Draw the resulting image smaller than the screen
    image(gridscape, pad, pad, width-pad*2, height-pad*2);
    
    // Add a border to the image 
    noFill();
    strokeWeight(2);
    rect(pad, pad, width-pad*2, height-pad*2);

    // Save a preview jpg in the output folder
    save("out/"+ path + "/" + path + ".png");

    
    // Finish pdf
    endRecord();

    
    // Next image
    image++;
  }
  
  // No more images left
  exit();
}
