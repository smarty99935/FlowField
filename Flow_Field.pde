int numOfPoints = 1000;
final int maxNumOfPoints = 1000;

//used to translate pixels to coordinates
int xDim = height;
int yDim = width;
float xCenter = height/2;
float yCenter = height/2;

//delta time
final float t = .005;

//track when to start next iteration
int time = 0;
final int maxTime = 60*5;

//useful in update(), init here
float xTemp;
float yTemp;

//the 4 values that determine the field
float x11= 1;
float x12= 1;
float x21= 1;
float x22= 1;

//set a fixed size for the points
float circleSize = 10;

//to display copyright message
boolean startPhase = true;

//array of movables
Movable[] stuff;

//track if next iteration is Circular, Random, or something else
Style style = Style.NONE;
boolean randomValues = false;

//set up the window
void setup() {
  size(1920, 1080);
  xDim = height;
  yDim = width;
  xCenter = width/2;
  yCenter = height/2;
  background(50);
}

//main loop
void draw() {
  //display copyright
  if (startPhase == true){
    text("©Zachary Gurwitz, press C for circles, R for random.", 50, 50);
  }
  noStroke();
  //detect user input to set style
  if (keyPressed == true) {
    if (key == 'c' || key == 'C') {
      style = Style.CIRCLE;
      startPhase = false;
    }
    if (key == 'r' || key == 'R' ) {
      style = Style.RANDOM;
      startPhase = false;
    }
  }
  
  //run the correct flow based on style
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

//would draw a point in the center, but is not run in this code for aesthetic reasons, 
//but is useful for analysing the fields
void drawOrigin() {
  fill(255, 0, 0);
  ellipse(xCenter, yCenter, 13, 13);

  fill(255);
  ellipse(xCenter, yCenter, 9, 9);
  fill(255, 0, 0);
  ellipse(xCenter, yCenter, 3, 3);
}

//The movable object, usually circles, but could be modified to make other shapes
class Movable {
  //starting position
  float xStart;
  float yStart;
  
  //current position
  float x;
  float y;
  
  //color
  float[] rgb = new float[3];

  //constructor, random color and fixed position
  Movable(float xStartIn, float yStartIn) {
    rgb[0] = (int) random(256);
    rgb[1] = (int) random(256);
    rgb[2] = (int) random(256);
    x = xCenter + xStartIn;
    y = yCenter + yStartIn;
  }
  
  //draw the Movable
  void show() {
    fill(rgb[0], rgb[1], rgb[2]); 
    ellipse(x, y, circleSize, circleSize);
  }
  
  //move the Movable according to the flow fields
  void update() {
    float xTemp = x - xCenter;
    float yTemp = y - yCenter;
    updateX(xTemp, yTemp);
    updateY(xTemp, yTemp);
  }

  //move in the X direction
  void updateX(float xIn, float yIn) {
    x += t*(dxDt(xIn, yIn));
  }

  //dx/dt
  float dxDt(float xTemp, float yTemp) {
    return (x11*xTemp+x12*yTemp );
  }
  
  //move in the Y direction
  void updateY(float xIn, float yIn) {
    y += t*(dyDt(xIn, yIn));
  }
  
  //dy/dt
  float dyDt(float xTemp, float yTemp) {
    return (x21*xTemp+x22*yTemp);
  }
}

//draw the formula to the screen
void writeFormula() {
  fill(255);
  textSize(32);
  text("dx/dt = " + x11 + "x + " + x12 +"y", width/2, 30 );
  text("dy/dt = " + x21 + "x + " + x22 +"y", width/2, 69);
}

//the code for setup and run of Random valued motion
void randomValues() {
  //start new iteration
  if (time == maxTime) {
    time = 0;
    background(50);
    numOfPoints = (int)random(maxNumOfPoints);
  }

  //randomize the flow field, number of points
  //make the points and store them
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
  
  //actually move and draw the points
  drawAndMove(stuff);

  //actually draw the formula
  writeFormula();
}

//the code for setup and run of circular motion
void circularMotion() {
  //start new iteration
  if (time == maxTime) {
    time = 0;
    background(50);
    numOfPoints = (int)random(maxNumOfPoints);
  }
  //randomize the number of points and fix the field to be circular
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

  //actually move and draw the points
  drawAndMove(stuff);

  //actually draw the formula
  writeFormula();
}

//updates and draws the movables
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
