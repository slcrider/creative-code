

void setup() {
  size(500, 500, P3D);
  background(0);
}

void draw() {
  fill(255);
  stroke(150);
  beginShape(SQUARE);
  vertex(width/2 - 10, height/2 - 10);
  vertex(width/2 - 10, height/2 + 10);
  vertex(width/2 + 10, height/2 + 10);
  vertex(width/2 + 10, height/2 - 10);
  endShape(CLOSE);
}