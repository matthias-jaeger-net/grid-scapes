import processing.pdf.*;

void settings () {
  size(150, 150);
}

void setup() {

  String[] paths ={
    "hochschwab", 
    "schoeckl", 
    "rotewand"
  };
  
  ArrayList<Cell> cells = new ArrayList<Cell>();

  for (int i = 0; i < paths.length; i++) {

    String path =  paths[i];

    PImage landscape;
    landscape = loadImage(path + ".jpg");
    landscape.resize(width, height);
    landscape.filter(BLUR, 2);
    landscape.filter(POSTERIZE, 4);

    beginRecord(PDF, "out/" + path +".pdf");
    for (int x = 0; x < width; x+=2) {
      for (int y = 0; y < height; y+=2) {
        color c = landscape.get(x, y);
        cells.add(new Cell(x, y, 2, 2, c));
      }
    }
    for (Cell c : cells) {
      c.render();
    }
    endRecord();
  }
  exit();
}
