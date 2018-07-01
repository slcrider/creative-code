private static final int MAX_PARTICLES = 70;
private static final String FIRST_GRADIENT_PATH = "gradient1.png";
private static final String SECOND_GRADIENT_PATH = "gradient2.png";
private static final float NUMBER_GRADIENTS = 2.0;

int x, y;
ArrayList<Particle> particles;

void setup() {
  fullScreen();
  background(0);
  x = width/2;
  y = height/2;
  
  particles = new ArrayList<Particle>();
  
  for (int i = 0; i < MAX_PARTICLES; i++) {
      Particle p = new Particle();
      if (random(1) > (1 / NUMBER_GRADIENTS)) {
          p.setGradient(loadImage(FIRST_GRADIENT_PATH));
      } else {
          p.setGradient(loadImage(SECOND_GRADIENT_PATH));
      }
      particles.add(p);
  }

  noStroke();
  //frameRate(5);
}

void draw() {
  background(0);
  for (Particle p : particles) {
      p.display();
      p.update();
  }
}

private class Particle {
  PShape p;
  PImage g;
  PVector pos;
  PVector vel;
  ArrayList<PVector> history;
  final int hist_len = 100;
  final int RADIUS = 50;
  final int STEP = 15;

  public Particle() {
    //pos = new PVector(width/2, height/2);
    pos = new PVector(random(0,width),random(0,height));
    vel = new PVector(random(-STEP, STEP), random(-STEP, STEP));
    p = createShape(ELLIPSE, 0, 0, RADIUS, RADIUS);
    history = new ArrayList<PVector>();
  }

  void display() {
    for (int i = 0; i < history.size(); i++) {
      float r = map(i, 0, hist_len, 0, RADIUS);
      //println(this.getFill(int(history.get(i).x), int(history.get(i).y)));
      fill(this.getFill(int(history.get(i).x), int(history.get(i).y)));
      ellipse(history.get(i).x, history.get(i).y, r, r);
    }
  }

  void update() {
    pos.x += random(-STEP, STEP);
    pos.y += random(-STEP, STEP);
    if (history.size() >= hist_len) {
      history.remove(0);
    }
    history.add(new PVector(pos.x, pos.y));

    if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    } else if (pos.x > width) {
      pos.x = width;
      vel.x *= -1;
    }
    if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -1;
    } else if (pos.y > height) {
      pos.y = height;
      vel.y *= -1;
    }
  }

  color getFill(int x, int y) {
    color c = color(g.get(x, y), 50);
    return c;
  }

  void setGradient(PImage g) {
    this.g = g;
    g.resize(width, height);
  }
}
