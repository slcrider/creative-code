public class NoiseField {
  private int xSize;
  private int ySize;
  private int cols;
  private int rows;
  private float[][] noise;
  private float flying;


  public NoiseField(int xSize, int ySize, int scl) {
    this.xSize = xSize;
    this.ySize = ySize;
    this.cols = xSize / scl;
    this.rows = ySize / scl;
    this.noise = new float[this.cols][this.rows];
    this.flying = 0;
  }

  public void display() {
    flying -= 0.01;
    background(0);
    // Rotate the plane
    translate(width/2, height/2);
    rotateX(PI / 3);

    // Recenter the mesh
    translate(-xSize/2, -ySize/2);

    // Draw the mesh
    for (int y = 0; y < rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        //stroke(red, green, blue);
        stroke(255);
        fill(150);
        //fill(255 - red, 255 - green, 255 - blue);
        //getStroke(x, y);
        //getFill(x, y);
        vertex(x*scl, y*scl, noise[x][y]);
        vertex(x*scl, (y+1)*scl, noise[x][y+1]);
      }
      endShape();
    }
  }

  public void updateNoise() {
    float yoff = flying;
    for (int y = 0; y < rows - 1; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        noise[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
        xoff += 0.2;
      }
      yoff += 0.02;
    }
  }
}