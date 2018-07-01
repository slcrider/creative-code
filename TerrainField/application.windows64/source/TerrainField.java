import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TerrainField extends PApplet {

int cols, rows;

int scl = 20;
int w = 2000;
int h = 1600;

int color1 = color(101, 23, 216);
int color2 = color(255, 102, 204);

//color color1 = color(0);
//color color2 = color(255);

//color colorControl;

int red = PApplet.parseInt(random(0, 255));
int green = PApplet.parseInt(random(0, 255));
int blue = PApplet.parseInt(random(0, 255));

float flying = 0;
float spread = 0.5f;
float angle = 0.33f;

boolean isHorStriped = false;
boolean isVertStriped = false;
boolean isRainbow = false;
boolean isSmoothRainbow = false;
float xRed = random(0, 255);
float yRed = random(0, 255);
float xGreen = random(0, 255);
float yGreen = random(0, 255);
float xBlue = random(0, 255);
float yBlue = random(0, 255);

float[][] terrain;
int[] leftColor;
int[] rightColor;

public void setup() {
  //size(600, 600, P3D);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  leftColor = new int[rows];
  rightColor = new int[rows];
  //colorControl = color(red, green, blue);
  //color1 = colorControl;
  for (int y = 0; y < rows; y++) {
    leftColor[y] = color1;
    rightColor[y] = color2;
  }
}

public void draw() {
  // Move us forward
  flying -= 0.025f;
  background(0);

  // Set the split
  spread = map(mouseY, 0, height - 2, 0, 0.5f);

  // Set the noise
  float yoff = flying;
  for (int y = 0; y < rows-1; y++) {
    float xoff = 0;
    for (int x = 0; x < PApplet.parseInt(ceil(spread * cols)); x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2f;
    }
    for (int x = PApplet.parseInt(ceil(spread * cols)); x < PApplet.parseInt(floor((1 - spread) * cols)); x++) {
      xoff += 0.2f;
    }
    for (int x = PApplet.parseInt(floor((1 - spread) * cols)); x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2f;
    }
    yoff += 0.2f;
  }
  

  // Rotate the plane
  translate(width/2, height/2);
  rotateX(map(angle, 0, 1, 0, PI));

  // Recenter the mesh
  translate(-w/2, -h/2);

  // Draw the mesh
  for (int y = 0; y < rows-1; y++) {
    checkLeftOptions(y);
    //fill(leftColor[y]);
    //stroke(rightColor[y]);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < PApplet.parseInt(ceil(spread * cols)); x++) {    
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();

    checkRightOptions(y);
    //fill(rightColor[y]);
    //stroke(leftColor[y]);
    beginShape(TRIANGLE_STRIP);
    for (int x = PApplet.parseInt(floor((1 - spread) * cols)); x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
    
  /*
  float colChooser = random(0, 1);
    if (colChooser < .33) {
      xRed++;
    } else if (colChooser < .66) {
      xGreen++;
    } else {
      xBlue++;
    }
    */
  }
  
  for (int y = 0; y < rows; y++) {
    if (y == 0) {
      leftColor[rows-1] = leftColor[0];
      rightColor[rows-1] = rightColor[0];
    } else {
      leftColor[y-1] = leftColor[y];
      rightColor[y-1] = rightColor[y];
    }
  }
}

public void checkLeftOptions(int y) {
    if (isHorStriped) {
      if (y % 2 == 0) {
        //color temp = leftColor[y];
        //leftColor[y] = rightColor[y];
        //rightColor[y] = temp;
        fill(color1);
        stroke(color2);
      } else {
        fill(color2);
        stroke(color1);
      }
    } else if (isRainbow) {
      fill(random(0, 255), random(0, 255), random(0, 255));
      stroke(255);
    } else if (isSmoothRainbow) {
      fill(255 * noise(xRed, yRed), 255 * noise(xGreen, yGreen), 255 * noise(xBlue, yBlue));
      stroke(255);
    } else {
      stroke(color1);
      fill(color2);
    }
}

public void checkRightOptions(int y) {
    if (isRainbow) {
      fill(random(0, 255), random(0, 255), random(0, 255));
      stroke(255);
    } else if (isSmoothRainbow) {
      fill(255 * noise(xRed, 0), 255 * noise(xGreen, 0), 255 * noise(xBlue, 0));
      stroke(255);
    } else if (!isHorStriped) {
      fill(color2);
      stroke(color1);
    }
}

public void keyPressed() {
  if (key == '1') {
    int temp = color1;
    color1 = color2;
    color2 = temp;
  } else if (key == '2') {
    isHorStriped = !isHorStriped;
  } else if (key == '3') {
    isVertStriped = !isVertStriped;
  } else if (key == '4') {
    isRainbow = !isRainbow;
  } else if (key == '5') {
    isSmoothRainbow = !isSmoothRainbow;
  } else if (key == '+') {
    if (angle < 1) {
      angle += 0.01f;
    }
  } else if (key == '-') {
    if (angle > 0) {
      angle -= 0.01f;
    }
  } else if (key == 'r') {
    if (red >= 0) {
      red--;
    }
  } else if (key == 'R') {
    if (red <= 255) {
      red++;
    }
  } else if (key == 'g') {
    if (green >= 0) {
      green--;
    }
  } else if (key == 'G') {
    if (green <= 255) {
      green++;
    }
  } else if (key == 'b') {
    if (blue >= 0) {
      blue--;
    }
  } else if (key == 'B') {
    if (blue <= 255) {
      blue++;
    }
  }
  //keyReleased();
}

  public void settings() {  fullScreen(P3D, 2); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TerrainField" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
