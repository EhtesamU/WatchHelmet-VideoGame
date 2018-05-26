// all the variables I need for two tools
int hammerPos = 0; 
int hammerVel = 1; 
int hammerPending = 0;
int bucketPos = 0; 
int bucketVel = 2; 
int bucketPending = 0;

int strokeThickness=10;
int blackColor = 0;
//background variables
int backgroundColor=100;
int backgroundXY= 100;
//tool variables
int toolXY =100;
//hero variables
int heroXY =100;
//scoreText Variables
int scoreX=100;
int scoreY=100;
// timeVariables
int timeStart=3000;
int timeEnd=8000;

int mrPos;
int jump = 60;
boolean doorOpen = true;

long timeAt;    // the time at which the door was last opened or closed
long waitTime; // the time to wait (in total) until the door opens next


int scoreNotHit=0;
int scoreHit = 0;

PFont f;

void setup() {
  size(512, 348);
  mrPos = width/8;
  frameRate(30);
  waitTime = int(random(timeStart, timeEnd));
  hammerPos = 0; //reseting tool
  bucketPos = 0;
  f = createFont("Arial", 16, true);
}

void draw() {


  if (millis() > timeAt + waitTime) {  // calculation will tell me if current time (millis) has gone past the last time the door opened plus waitTime
    doorOpen = !doorOpen;
    timeAt = millis();                // reset last opening time to now
    waitTime = int(random(timeStart, timeEnd));// choose new waiting time
  }
  backgroundDesign();
  score();
  hero();
  tool();
  scoreText();  
  toolMovement();
  toolHitHero();
}

void keyPressed() {
  if (keyCode == RIGHT && (mrPos < 7*(width/8)) && doorOpen) { // mr gw is moving right and the door is open
    mrPos = mrPos + width/8;
  } else if (keyCode == RIGHT && (mrPos < 6*(width/8))) {      // mr gw is moving right not including last slot
    mrPos = mrPos + width/8;
  } else if (keyCode == LEFT && (mrPos > width/8)) {           // mr gw is moving left.
    mrPos = mrPos - width/8;
  } else if (keyCode == RIGHT && (mrPos < 8*(width/8)) && doorOpen ) {
    mrPos = width/8;
  } 
  if (mrPos>=7*(width/8) && mrPos <= 7*(width*8)) {
    scoreNotHit +=3;
  }
}

void backgroundDesign() {
  background(backgroundColor+59, backgroundColor+72, backgroundColor+73);
  rectMode(CORNERS);
  ellipseMode(CORNERS);
  noStroke();

  // draw the balcony
  fill(backgroundColor+45, backgroundColor-2, backgroundColor-59);     // main orange bit
  rect(backgroundXY-100, backgroundXY-35, backgroundXY-66, backgroundXY+105);
  fill(backgroundColor+93, backgroundColor+58, backgroundColor+53);   // light orange inserts
  rect(backgroundXY-96, backgroundXY-26, backgroundXY+56, backgroundXY-21);
  rect(backgroundXY-96, backgroundXY+30, backgroundXY-56, backgroundXY+35);
  rect(backgroundXY-96, backgroundXY+91, backgroundXY+56, backgroundXY+96);
  fill(backgroundColor+59, backgroundColor+72, backgroundColor+73);     // grey inserts
  rect(backgroundXY-96, backgroundXY-15, backgroundXY-56, backgroundXY);
  rect(backgroundXY-96, backgroundXY+44, backgroundXY+56, backgroundXY+60);

  // draw entrance
  noFill();
  strokeWeight(strokeThickness-8);
  stroke(blackColor);
  rect(backgroundXY-100, backgroundXY+105, backgroundXY-56, backgroundXY+190);
  fill(blackColor);
  rect(backgroundXY-88, backgroundXY+121, backgroundXY-71, backgroundXY+136, backgroundXY-99);
  ellipse(backgroundXY-68, backgroundXY+151, backgroundXY-62, backgroundXY+159);

  // draw ground
  strokeWeight(strokeThickness-7);
  stroke(backgroundColor+80, backgroundColor+23, backgroundColor+19);
  line(backgroundXY-61, backgroundXY+195, backgroundXY-19, backgroundXY+194);
  line(backgroundXY+31, backgroundXY+193, backgroundXY+71, backgroundXY+198);
  line(backgroundXY+93, backgroundXY+195, backgroundXY+120, backgroundXY+189);
  line(backgroundXY+169, backgroundXY+192, backgroundXY+197, backgroundXY+190);
  line(backgroundXY+227, backgroundXY+194, backgroundXY+300, backgroundXY+198);
  line(backgroundXY+144, backgroundXY+203, backgroundXY+134, backgroundXY+198);
  stroke(backgroundColor+43, backgroundColor+12, backgroundColor+17);
  line(backgroundXY-61, backgroundXY+204, backgroundXY-17, backgroundXY+201);
  line(backgroundXY+30, backgroundXY+202, backgroundXY+85, backgroundXY+202);
  line(backgroundXY+37, backgroundXY+210, backgroundXY+47, backgroundXY+211);
  line(backgroundXY+66, backgroundXY+212, backgroundXY+88, backgroundXY+212);
  line(backgroundXY+95, backgroundXY+203, backgroundXY+123, backgroundXY+201);
  line(backgroundXY+169, backgroundXY+199, backgroundXY+199, backgroundXY+199);
  line(backgroundXY+223, backgroundXY+203, backgroundXY+299, backgroundXY+205);
  line(backgroundXY+223, backgroundXY+210, backgroundXY+234, backgroundXY+212);
  line(backgroundXY+261, backgroundXY+211, backgroundXY+269, backgroundXY+209);

  // draw trees
  noStroke();
  fill(backgroundColor-14, backgroundColor+31, backgroundColor-65);
  //left tree
  triangle(backgroundXY+343, backgroundXY+4, backgroundXY+333, backgroundXY+81, backgroundXY+356, backgroundXY+78);
  triangle(backgroundXY+343, backgroundXY+4, backgroundXY+331, backgroundXY+25, backgroundXY+355, backgroundXY+24);
  triangle(backgroundXY+328, backgroundXY+35, backgroundXY+357, backgroundXY+35, backgroundXY+343, backgroundXY+16);
  triangle(backgroundXY+317, backgroundXY+90, backgroundXY+343, backgroundXY+15, backgroundXY+368, backgroundXY+85);

  //middle tree
  triangle(backgroundXY+374, backgroundXY+2, backgroundXY+368, backgroundXY+33, backgroundXY+380, backgroundXY+36);
  triangle(backgroundXY+374, backgroundXY+16, backgroundXY+363, backgroundXY+26, backgroundXY+385, backgroundXY+26);
  triangle(backgroundXY+374, backgroundXY+25, backgroundXY+360, backgroundXY+38, backgroundXY+386, backgroundXY+38);
  triangle(backgroundXY+374, backgroundXY+30, backgroundXY+357, backgroundXY+49, backgroundXY+393, backgroundXY+48);

  // right tree
  triangle(backgroundXY+406, backgroundXY-18, backgroundXY+369, backgroundXY+70, backgroundXY+442, backgroundXY+70);

  // draw house
  strokeWeight(strokeThickness+10);
  stroke(blackColor);
  line(backgroundXY+302, backgroundXY+106, backgroundXY+390, backgroundXY+69);
  line(backgroundXY+390, backgroundXY+69, backgroundXY+412, backgroundXY+79);
  strokeWeight(strokeThickness-8);
  noFill();
  line(backgroundXY+311, backgroundXY+113, backgroundXY+311, backgroundXY+205);
  rect(backgroundXY+319, backgroundXY+110, backgroundXY+368, backgroundXY+195);

  if (doorOpen) {
    line(backgroundXY+379, backgroundXY+106, backgroundXY+399, backgroundXY+99);
    line(backgroundXY+399, backgroundXY+99, backgroundXY+399, backgroundXY+214);
    line(backgroundXY+399, backgroundXY+214, backgroundXY+378, backgroundXY+202);
    fill(blackColor);
    noStroke();
    triangle(backgroundXY+376, backgroundXY+125, backgroundXY+393, backgroundXY+119, backgroundXY+393, backgroundXY+143);
    triangle(backgroundXY+376, backgroundXY+125, backgroundXY+393, backgroundXY+143, backgroundXY+376, backgroundXY+140);

    ellipse(backgroundXY+387, backgroundXY+155, backgroundXY+393, backgroundXY+163);
    arc(backgroundXY+399, backgroundXY+155, backgroundXY+407, backgroundXY+162, 3*HALF_PI, HALF_PI, CHORD);
  } else {
    fill(blackColor);
    noStroke();
    rect(backgroundXY+332, backgroundXY+125, backgroundXY+353, backgroundXY+143, backgroundXY-98);
    ellipse(backgroundXY+325, backgroundXY+155, backgroundXY+331, backgroundXY+163);
  }
}
void tool() {

  // draw hammer;
  fill(blackColor);
  stroke(blackColor);
  strokeWeight(strokeThickness-4);
  line(toolXY+28, hammerPos+10, toolXY+48, hammerPos-12);
  strokeWeight(strokeThickness-6);
  line(toolXY+25, hammerPos+13, toolXY+29, hammerPos+11);
  strokeWeight(strokeThickness-2);
  line(toolXY+15, hammerPos+5, toolXY+30, hammerPos+20);

  // draw bucket
  fill(blackColor);
  noStroke();
  triangle(toolXY+67, bucketPos-5, toolXY+87, bucketPos-12, toolXY+88, bucketPos+12);
  triangle(toolXY+67, bucketPos-5, toolXY+87, bucketPos+12, toolXY+69, bucketPos+14);
  noFill();
  stroke(blackColor);
  strokeWeight(strokeThickness-6);
  ellipse(toolXY+83, bucketPos-11, toolXY+95, bucketPos+10);
}
void hero() {
  //draw MrGW
  ellipseMode(CORNERS); 
  noStroke();
  fill(blackColor);
  ellipse(mrPos-13, heroXY+132, mrPos+17, heroXY+163);
  fill(heroXY+59, heroXY+72, heroXY+73);
  ellipse(mrPos+3, heroXY+150, mrPos+17, heroXY+160);
  fill(blackColor);
  triangle(mrPos+2, toolXY+158, mrPos-11, 278, mrPos+1, toolXY+185);
}

void scoreText() {
  //text
  textFont(f);
  fill(blackColor);
  text("Score: ", scoreX+300, scoreY-80);
  text(scoreNotHit +scoreHit, scoreX+350, scoreY-80);
}
void toolMovement() {
  // animate all automatically moving objects.. first update pending then decide if there is a jump this frame
  hammerPending = hammerPending + hammerVel;
  bucketPending = bucketPending + bucketVel;
  if (hammerPending > jump) {
    hammerPos = hammerPos + hammerPending;
    hammerPending = 0;
  }
  if (bucketPending > jump) {
    bucketPos = bucketPos + bucketPending;
    bucketPending = 0;
  }
  //reseting tool
  if (hammerPos>=height) {
    scoreNotHit=scoreNotHit+1;
    hammerPos = 0;
  }
  if (bucketPos>height) {
    scoreNotHit=scoreNotHit+1;
    bucketPos = 0;
  }
}
void toolHitHero() {
  // what to do when tool hits mr gw
  if (hammerPos > 240 && hammerPos < 300 && mrPos == width/4) {
    mrPos = width/8;
    scoreHit=scoreHit+6;
  }
  if (bucketPos > 240 && bucketPos < 300 && mrPos == 3*width/8) {
    mrPos = width/8;
    scoreHit=scoreHit+6;
  }
}
//one function to rule them all 
void score() {
  int j=0;
  while ( j < scoreHit)
  {
    int xHit = j%6;
    int yHit = j/6;
    redScoringCircle(80*xHit+40, 80*yHit+40);
    j++;
  }

  for (int i = 0; i < scoreNotHit; i++)
  { 
    int xPc =(i+j)%6;
    int yPc =(i+j)/6;
    blackScoringCircle(80*xPc+40, 80*yPc+40);
  }

  if (scoreNotHit + scoreHit >= 24) {
    scoreNotHit = 0;
    scoreHit =0;
  }
}
void blackScoringCircle(int x, int y)
{
  ellipseMode(CENTER);
  float colour = 160;
  int diameter = 75;
  while (diameter >70)
  {
    while (colour >0)
    {
      noStroke();
      fill(colour);
      ellipse(x, y, diameter, diameter);
      colour = colour -20;
      diameter = diameter -5;
    }
  }
  colour = 160;
  diameter = 75;
}

void redScoringCircle(int x, int y) {
  ellipseMode(CENTER);
  float colour = 170;
  int diameter = 80;
  while (diameter >70)
  {
    while (colour >0)
    {
      noStroke();
      fill(255, colour, colour);
      ellipse(x, y, diameter, diameter);
      colour = colour -20;
      diameter = diameter -5;
    }
  }
  colour = 160;
  diameter = 75;
}  