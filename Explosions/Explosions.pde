import themidibus.*;

MidiBus myBus;

Ribbon[] rainbows;
//int len = 0;

int rib_len = 100;
int zDepth = 100;
int zSpeed = 25;
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
  size(600, 600, P3D);
  //fullScreen(P3D);

  //  Connect to midi
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);

  //  Establish Ribbon List
  rainbows = new Ribbon[7];
  rainbows[0] = new Ribbon(int(random(1, rib_len)), color(255, 0, 0));    // Red
  rainbows[1] = new Ribbon(int(random(1, rib_len)), color(255, 127, 0));  // Orange
  rainbows[2] = new Ribbon(int(random(1, rib_len)), color(255, 255, 0));  // Yellow
  rainbows[3] = new Ribbon(int(random(1, rib_len)), color(0, 255, 0));    // Green
  rainbows[4] = new Ribbon(int(random(1, rib_len)), color(0, 127, 255));  // Blue
  rainbows[5] = new Ribbon(int(random(1, rib_len)), color(127, 0, 155));  // Indigo
  rainbows[6] = new Ribbon(int(random(1, rib_len)), color(255, 0, 255));  // Violet

  //  Tweak some params
  noSmooth();
  strokeWeight(5);
  //frameRate(5);
}

void draw() {
  background(0);

  //  Option 1
  for (int i = 0; i < rainbows.length; i++) {
    stroke(rainbows[i].getColor());
    //strokeWeight(rainbows[i].getSize());
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

void controllerChange(int channel, int number, int value) {
  //  Output stats to console
  println("Chan: " + channel);
  println("Num: " + number);
  println("Val: " + value);

  if (number == 3) {
    rib_len = int(map(value, 0, 127, 1, 250));
  }
  if (number == 9) {
    zSpeed = int(map(value, 0, 127, 10, 100));
  }
  if (number == 12) {
    zDepth = int(map(value, 0, 127, 10, 5000));
  }
  print("R: " + rib_len);
  print("S: " + zSpeed);
  print("D: " + zDepth);
  println();
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
    points.add(new PVector(noise(x1, y1), noise(x2, y2)));
    size = int(random(0, 9));
    isGrowing = true;
    x1++;
    y1++;
    x2++;
    y2++;
  }

  void render() {
    //beginShape();
    for (PVector p : points) {
      point(map(p.x, 0, 1, 0, width), map(p.y, 0, 1, 0, height), p.z);
      //vertex(p.x + 5, 
    }
  }

  void update() {
    if (points.size() == len) {
      isGrowing = false;
    }
    if (isGrowing) {
      
      points.add(new PVector(noise(x1, y1), noise(x2, y2), -zDepth));
      x1++;
      y1++;
      x2++;
      y2++;
      
      //PVector tail = points[points.size() - 1];
      //for (
    } else {
      if (points.size() == 1) {
        isGrowing = true;
        len = int(random(1, rib_len));
      }
      points.remove(0);
    }
    for (PVector p : points) {
      p.z += zSpeed;
    }
    //size = int(random(0, 9));
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