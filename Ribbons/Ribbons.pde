import themidibus.*;

Ribbon[] rainbows;
int len = 0;

int rib_len = 30;
int zDepth = -500;
int zSpeed = 40;
/*
Integer[] rainbow = new Integer[7];
 
 rainbow[0] = color(255, 0, 0);    // Red
 rainbow[1] = color(255, 127, 0);  // Orange
 rainbows[2] = color(255, 255, 0);  // Yellow
 rainbows[3] = color(0, 255, 0);    // Green
 rainbows[4] = color(0, 127, 255);  // Blue
 rainbows[5] = color(127, 0, 155);  // Indigo
 rainbows[6] = color(255, 0, 255);  // Violet
 */

void setup() {
  //size(600, 600);
  fullScreen(P3D);
  rainbows = new Ribbon[7];
  rainbows[0] = new Ribbon(int(random(2, rib_len)), color(255, 0, 0));    // Red
  rainbows[1] = new Ribbon(int(random(2, rib_len)), color(255, 127, 0));  // Orange
  rainbows[2] = new Ribbon(int(random(2, rib_len)), color(255, 255, 0));  // Yellow
  rainbows[3] = new Ribbon(int(random(2, rib_len)), color(0, 255, 0));    // Green
  rainbows[4] = new Ribbon(int(random(2, rib_len)), color(0, 127, 255));  // Blue
  rainbows[5] = new Ribbon(int(random(2, rib_len)), color(127, 0, 155));  // Indigo
  rainbows[6] = new Ribbon(int(random(2, rib_len)), color(255, 0, 255));  // Violet

  noSmooth();
  //strokeWeight(5);
  noStroke();
  frameRate(5);
}

void draw() {
  background(0);

  //  Option 1
  for (int i = 0; i < rainbows.length; i++) {
    //stroke(rainbows[i].getColor());
    fill(rainbows[i].getColor());
    //strokeWeight(rainbows[i].getSize());
    //stroke(255);
    rainbows[i].render();
    rainbows[i].update();
  }


  /*
  //  Option 2
   stroke(rainbows[len].getColor());
   rainbows[len].render();
   rainbows[len].update();
   len++;
   len %= (rainbows.length);
   */

  /*
  //  This will kill it
   if (rainbows[0].getSize() == 0) {
   exit();
   }
   */
}

public class Ribbon {

  private int len;
  private color col;
  private int size;
  private boolean isGrowing;
  private ArrayList<PVector> points = new ArrayList<PVector>();

  private int x1 = int(random(0, width));
  private int y1 = int(random(0, height));
  private int x2 = int(random(0, width));
  private int y2 = int(random(0, height));
  private int z = -100;

  public Ribbon (int len, color col) {
    this.len = len;
    this.col = col;
    //points.add(new PVector(noise(x1, y1), noise(x2, y2)));
    //points.add(new PVector(x1, y1, zDepth - zSpeed));
    points.add(new PVector(x1, y1, zDepth));
    size = int(random(0, 9));
    isGrowing = true;
    x1++;
    y1++;
    x2++;
    y2++;
  }

  void render() {
    if (points.size() == 1) {
      return;
    }
    beginShape();
    for (int i = 0; i < points.size() - 1; i++) {
      vertex(points.get(i).x, points.get(i).y - 5, points.get(i).z);
      vertex(points.get(i).x, points.get(i).y + 5, points.get(i).z);
      vertex(points.get(i + 1).x, points.get(i + 1).y + 5, points.get(i + 1).z);
      vertex(points.get(i + 1).x, points.get(i + 1).y - 5, points.get(i + 1).z);
    }
    endShape(CLOSE);

    /*
    for (PVector p : points) {
     //point(map(p.x, 0, 1, 0, width), map(p.y, 0, 1, 0, height), p.z);
     point(p.x, p.y, p.z);
     //line(p.x - 10, p.y - 10, p.z, p.x + 10, p.y + 10, p.z);
     }
     */
  }

  void update() {
    // increase z's
    for (PVector p : points) {
      p.z += zSpeed;
    }

    if (points.size() == len) {
      isGrowing = false;
    }
    if (isGrowing) {
      /*
      points.add(new PVector(noise(x1, y1), noise(x2, y2), z));
       x1++;
       y1++;
       x2++;
       y2++;
       */
      points.add(new PVector(x1, x2, zDepth));
    } else {
      if (points.size() == 0) {
        isGrowing = true;
        len = int(random(0, rib_len));
        x1 = int(random(0, width));
        y1 = int(random(0, height));
      } else {
        points.remove(0);
      }
    }

    size = int(random(0, 9));
  }

  color getColor() {
    return col;
  }

  int getLength() {
    return points.size();
  }

  int getSize() {
    return size;
  }
}