//numOfPoints 100, c = .9 is cool
int numOfPoints = 1000;
final int maxNumOfPoints = 1000;

int xDim = height;
int yDim = width;
float xCenter = height/2;
float yCenter = height/2;

final float t = .005;

int time = 0;
final int maxTime = 60*5;

float xTemp;
float yTemp;


float x11= 1;
float x12= 1;
float x21= 1;
float x22= 1;
float circleSize = 10;
boolean startPhase = true;

Movable[] stuff;

Style style = Style.NONE;
boolean randomValues = false;

void setup() {
  size(1920, 1080);
  xDim = height;
  yDim = width;
  xCenter = width/2;
  yCenter = height/2;
  print(xCenter + " " + yCenter);
  background(50);
}


void draw() {
    if (startPhase == true){
    text("©Zachary Gurwitz, press C for circles, R for random.", 50, 50);
  }
  noStroke();
  if (keyPressed == true) {
    if (key == 'c' || key == 'C') {
      println("circle");
      style = Style.CIRCLE;
      startPhase = false;
    }
    if (key == 'r' || key == 'R' ) {
      println("random");
      style = Style.RANDOM;
      startPhase = false;
    }
  }
  switch(style) {
  case RANDOM:
    {
      randomValues();
    }
  case CIRCLE:
    {
      circularMotion();
    }
  }
}

void drawOrigin() {
  fill(255, 0, 0);
  ellipse(xCenter, yCenter, 13, 13);

  fill(255);
  ellipse(xCenter, yCenter, 9, 9);
  fill(255, 0, 0);
  ellipse(xCenter, yCenter, 3, 3);
}

class Movable {

  float xStart;
  float yStart;
  float x;
  float y;
  float[] rgb = new float[3];

  Movable(float xStartIn, float yStartIn) {
    rgb[0] = (int) random(256);
    rgb[1] = (int) random(256);
    rgb[2] = (int) random(256);
    x = xCenter + xStartIn;
    y = yCenter + yStartIn;
  }
  void show() {
    fill(rgb[0], rgb[1], rgb[2]); 
    ellipse(x, y, circleSize, circleSize);
  }



  void update() {
    float xTemp = x - xCenter;
    float yTemp = y - yCenter;
    updateX(xTemp, yTemp);
    updateY(xTemp, yTemp);
  }

  void updateX(float xIn, float yIn) {
    x += t*(dxDt(xIn, yIn));
  }

  float dxDt(float xTemp, float yTemp) {
    return (x11*xTemp+x12*yTemp );
  }

  void updateY(float xIn, float yIn) {
    y += t*(dyDt(xIn, yIn));
  }

  float dyDt(float xTemp, float yTemp) {
    return (x21*xTemp+x22*yTemp);
  }
}

void writeFormula() {
  fill(255);
  textSize(32);
  text("dx/dt = " + x11 + "x + " + x12 +"y", width/2, 30 );
  text("dy/dt = " + x21 + "x + " + x22 +"y", width/2, 69);
}

void randomValues() {

  if (time == maxTime) {
    time = 0;
    background(50);
    numOfPoints = (int)random(maxNumOfPoints);
  }

  if (time <= 0) {
    x11= random(-2, 2);
    x12= random(-2, 2);
    x21= random(-2, 2);
    x22= random(-2, 2);
    stuff = new Movable[numOfPoints];
    for (int i = 0; i < numOfPoints; i++) {
      stuff[i] = new Movable(random(-width/2, width/2), random(-height/2, height/2));
    }
  }



  drawAndMove(stuff);




  writeFormula();
}

void circularMotion() {
  if (time == maxTime) {
    time = 0;
    background(50);
    numOfPoints = (int)random(maxNumOfPoints);
  }
  if (time <= 0) {
    x11= 0;
    x12= 1;
    x21= -1;
    x22= 0;
    stuff = new Movable[numOfPoints];
    for (int i = 0; i < numOfPoints; i++) {
      stuff[i] = new Movable(random(-width/2, width/2), random(-height/2, height/2));
    }
  }




  drawAndMove(stuff);




  writeFormula();
}
void drawAndMove(Movable[] stuffIn) {
  for (Movable m : stuffIn) {
    m.update();
    m.show();
  }
  time++;
}

enum Style {
  RANDOM, CIRCLE, NONE;
}
