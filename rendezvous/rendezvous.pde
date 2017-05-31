PImage img;

double KerbinPeriod=21549.425; //s
double KerbinMu=3.5315984e12;  //m^3/s^2
double KerbinRe=600000;        //m
double FrameRate=24;           // s^-1
double TimeRate=100;        

void setup() {
  size(1920,1080); //<>//
  img=loadImage("Kerbin.png");
}

void draw() {
  double t=frameCount/FrameRate; //This is the actual time since start
  t=t*TimeRate; //Now it is scaled time
  double KerbinTheta=2*Math.PI*t/KerbinPeriod;
  pushMatrix();
  translate(width/2,height/2); //<>//
  pushMatrix();
  rotate((float)KerbinTheta);
  image(img,-width/2,-height/2);
  rect(0,0,40,40);
  popMatrix();
  popMatrix();
}