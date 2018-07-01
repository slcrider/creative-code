public class YinYang {
  private float diam;
  private float xTrans;
  private float yTrans;

  private float interDiam;
  private float offset;
  private float smallDiam;
  private float interWidth;

  private float xAdj;
  private float yAdj;
  private float theta;

  private int counter = 0;
  private final float divisor = 300;

  public YinYang(float diam, float xTrans, float yTrans) {
    this.diam = diam;
    this.xTrans = xTrans;
    this.yTrans = yTrans;
    interDiam = diam / 2;
    offset = diam / 4;
    smallDiam = diam / 8;
    interWidth = interDiam;

    xAdj = 0;
    yAdj = diam / 4;
    theta = 0;
    colorMode(HSB, divisor, 100, 100);
  }

  void render() {
    pushMatrix();
    translate(xTrans, yTrans);
    
    // Draw arcs (semi-circles)
    //stroke(colorYin);
    //strokeWeight(5);
    fill(colorYin);
    arc(0, 0, diam, diam, PI/2, PI+PI/2);
    fill(colorYang);
    arc(0, 0, diam, diam, PI+PI/2, TWO_PI+PI/2);

    // Draw intermediate ellipses
    noStroke();
    fill(midYin);
    ellipse(0, -diam/4, interWidth, interDiam);
    fill(midYang);
    ellipse(0, diam/4, interWidth, interDiam);

    // Draw inner dots
    fill(innerYang);
    ellipse(xAdj, -yAdj, smallDiam, smallDiam);
    fill(innerYin);
    ellipse(-xAdj, yAdj, smallDiam, smallDiam);
    //noStroke();
    popMatrix();
  }

  void update() {
    interWidth = abs(interDiam * cos(theta));
    xAdj = offset * sin(theta);
    yAdj = offset * cos(theta);

    theta += (PI / divisor);
    theta %= 2 * PI;
    counter++;
  }

  void checkFill() {
    // text(counter, 10, 10); // Print to screen
    if (counter % divisor == (divisor / 2)) {
      color temp = colorYin;
      colorYin = colorYang;
      colorYang = temp;
    }

    if ((counter % divisor == (divisor / 4)) || (counter % divisor == (3 * divisor / 4))) {
      if (counter <= divisor) {
        color temp = innerYin;
        innerYin = innerYang;
        innerYang = temp;
      }
    }
    counter %= 2 * divisor;
  }

  void updateFill() {
    //text(counter, 10, 10);  // Print Counter
    //text(divisor, 10, 20);  // Print divisore
    colorYin = color(counter % divisor, 200, 200);
    colorYang = color(((counter + divisor / 2) % divisor), 200, 200);
    if (abs(divisor - counter) >= (divisor / 2)) {
      midYin = colorYin;
      midYang = colorYang;
    } else {
      midYin = colorYang;
      midYang = colorYin;
    }

    if ((counter <= divisor) && ((abs(divisor/2 - counter) <= (divisor / 4))) ){
        innerYin = colorYang;
        innerYang = colorYin;
    } else {
        innerYin = colorYin;
        innerYang = colorYang; 
    }

    counter %= 2 * divisor;
  }

  float getSmallDiam() {
    return smallDiam;
  }

  float getXAdj() {
    return this.xAdj;
  }

  float getYAdj() {
    return this.yAdj;
  }

  void setXTrans(float xTrans) {
    this.xTrans = xTrans;
  }

  void setYTrans(float yTrans) {
    this.yTrans = yTrans;
  }
}
