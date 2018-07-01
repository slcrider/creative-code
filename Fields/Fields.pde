int cols, rows;
int red, green, blue;

boolean updateFills = false;
boolean updateRed = true;
boolean updateGreen = false;
boolean updateBlue = false;

int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;
float spread;
float angle = 0.25;

float[][] terrain;
color[][] fill;
NoiseField n1;

void setup() {
  //size(600, 600, P3D);
  n1 = new NoiseField(w, h, scl);
  fullScreen(P3D, 2);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  red = int(random(0, 255));
  green = int(random(0, 255));
  blue = int(random(0, 255));
  fill = new color[cols][rows];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      if (x % 9 == 0) {
        red++;
        red %= 255;
      } else if (x % 9 == 3) {
        green++;
        green %= 255;
      } else if (x % 9 == 6) {
        blue++;
        blue %= 255;
      }
      fill[x][y] = color(red, green, blue);
    }
  }
    n1.updateNoise();

}

void draw() {
  
  // Move us forward
  flying -= 0.025;
  background(0);
  n1.display();

  // Set the split
  spread = map(mouseY, 0, height - 2, 0, 0.5);

  // Set the noise
  float yoff = flying;
  for (int y = 0; y < rows-1; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2;
    }
    /*
    for (int x = 0; x < int(ceil(spread * cols)); x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2;
    }
    for (int x = int(ceil(spread * cols)); x < int(floor((1 - spread) * cols)); x++) {
      xoff += 0.2;
    }
    for (int x = int(floor((1 - spread) * cols)); x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2;
    }
    */
    yoff += 0.2;
  }
  

  /*
  // Rotate the plane
  translate(width/2, height/2);
  rotateX(map(angle, 0, 1, 0, PI));

  // Recenter the mesh
  translate(-w/2, -h/2);

  // Draw the mesh
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      //stroke(red, green, blue);
      noStroke();
      //fill(255 - red, 255 - green, 255 - blue);
      getStroke(x,y);
      getFill(x, y);
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
    
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < int(ceil(spread * cols)); x++) {
      //stroke(map(y + x,0, cols + rows-1,0, 255));
      //fill(map(y + x,0, spread*cols + rows-1,255, 0));
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();

    beginShape(TRIANGLE_STRIP);
    for (int x = int(floor((1 - spread) * cols)); x < cols; x++) {
      //stroke(map(y + x,0, cols + rows-1,0, 255));
      //fill(map(y + x,0, spread*cols + rows-1,255, 0));
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
    
  }
  if(updateFills) {
    updateFills();
  }
  updateFills = !updateFills;
  */
}

void getFill(int x, int y) {
  fill(fill[x][y]);
}

void getStroke(int x, int y) {
  stroke(fill[fill.length - x - 1][fill[x].length - y - 1]);
}

void updateFills() {
  for (int y = 0; y < rows - 1; y++) {
    for (int x = 0; x < cols; x++) {
      fill[x][y] = fill[x][y+1];
    }
  }
  for (int x = 0; x < cols; x++) {
    if (x % 24 == 0) {
        red += int(random(0, 5));
        red %= 255;
    } else if (x % 24 == 8) {
        green += int(random(0, 5));
        green %= 255;
    } else if (x % 24 == 16) {
        blue += int(random(0, 5));
        blue %= 255;
    }
    fill[x][rows - 1] = color(red, green, blue);
  }
}