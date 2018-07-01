int frames = 180;
float diam = 200, theta;

float interDiam = diam / 2;
float smallDiam = diam / 8;
float interOffset = diam / 4;
float interX = 0;
float interY = diam / 4;

float interVal;
float smallVal;

float cosAdj = 0;
float divisor = 300;
int counter = 0;

color colorYin = color(0);
color colorYang = color(255);


void setup() {
  size(540,540, P2D);
  smooth(8);
  noStroke();
  interVal = interDiam;
  smallVal = smallDiam;
}

void draw() {
  background(#35465c);
  drawYinYang();
  updateYinYang();
  
  theta += TWO_PI/frames;
  
  //if (frameCount<=frames) saveFrame("image-###.gif");
  
}

void drawYinYang() {
  pushMatrix();
  translate(width/2, height/2);
  //rotate(theta);
  fill(colorYin);
  arc(0,0,diam, diam, PI/2,PI+PI/2);
  fill(colorYang);
  arc(0,0,diam, diam, PI+PI/2,TWO_PI+PI/2);
  
  // Draw intermediate
  fill(colorYin);
  ellipse(0,-diam/4, interVal, interDiam);
  fill(colorYang);
  ellipse(0,diam/4, interVal, interDiam);
  
  // Draw inner dots
  fill(colorYang);
  ellipse(interX,-interY, smallVal, smallVal);
  fill(colorYin);
  ellipse(-interX,interY, smallVal, smallVal);
    
  popMatrix();
}

void updateYinYang() {
  interVal = abs(interDiam * cos(cosAdj));
  smallVal = abs(smallDiam * cos(cosAdj));
  interX = interOffset * sin(cosAdj);
  interY = interOffset * cos(cosAdj);
  /*
  if (counter % (divisor / 2) == 0) {
    color temp = colorYin;
    colorYin = colorYang;
    colorYang = temp;
  }
  
  cosAdj += (PI / divisor);
  cosAdj %= 2 * PI;
  counter++;
  */

}