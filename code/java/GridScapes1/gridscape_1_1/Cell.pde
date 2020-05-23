class Cell {
  int x;
  int y; 
  int w;
  int h;
  color c;
  int f;

  Cell(int xpos, int ypos, int wcell, int hcell, color colr) {
    x = xpos;
    y = ypos;
    w = wcell;
    h = hcell;
    c = colr;
  }

  public void render() {

    pushMatrix();
    translate(x, y);

    float b = brightness(c);
    int f = int(map(int(b), 0, 255, 3, 7));

    fill(red(c), green(c), 255);
    stroke(0, 0);
    rotate(f);
    polygon(0, 0, map(b, 0, 255, 1, w), f);
    popMatrix();
  }
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
