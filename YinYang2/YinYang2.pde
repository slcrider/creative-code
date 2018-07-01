int diameter;
color colorYin = color(100);
color colorYang = color(200);
float theta = 0;
PShape yin;

void setup() {
  fullScreen();
  //size(600, 600);
  background(0);
  if (width < height) {
    diameter = 3 * width / 4;
  } else {
    diameter = 3 * height / 4;
  }
}

void draw() {
  translate(width/2, height/2);
  rotate(theta);
  strokeWeight(1);
  //stroke(255, 0);
  noStroke();
  fill(100);
  drawYin();
  drawYang();
  theta += 0.02;
  /*
  ellipse(0, 0, diameter, diameter);
   
   strokeWeight(5);
   //stroke(200, 100, 250);
   stroke(255);
   noFill();
   arc(diameter/4,0,diameter/2,diameter/2, PI, 2 * PI);
   arc(-diameter/4,0,diameter/2,diameter/2, 0, PI);
   */
}

void drawYin() {
  /*
  beginShape();
  //fill(colorYin);
  noFill();
  stroke(255);
  curveVertex(-diameter,0);

  curveVertex(-diameter,0);

  curveVertex(-diameter/2,-diameter/2);
  curveVertex(diameter,0);
  curveVertex(diameter/2, diameter/2);
  curveVertex(diameter, 0);
  vertex(-diameter,0);
  endShape(CLOSE);
  */
  
  
  
  fill(colorYin);
  stroke(colorYin);
  arc(0, 0, diameter, diameter, 0, PI);
  arc(-diameter/4, 0, diameter/2, diameter/2, PI, 2 * PI);
  fill(colorYang);
  stroke(colorYang);
  arc(diameter/4, 0, diameter/2, diameter/2, 0, PI);
  
}

void drawYang() {
  fill(colorYang);
  arc(0, 0, diameter, diameter, PI, 2 * PI);
  arc(diameter/4, 0, diameter/2, diameter/2, 0, PI);

  fill(colorYin);
  arc(-diameter/4, 0, diameter/2, diameter/2, PI, 2 * PI);
}