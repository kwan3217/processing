float KerbinPeriod=21549.425; //s
float KerbinW=2*PI/KerbinPeriod; //s^-1
float KerbinMu=3.5315984e12;  //m^3/s^2
float KerbinRe=600000;        //m
float FrameRate=24;           // s^-1
float TimeRate=100;        
float targetR=750000;
float targetCirc=2*PI*targetR;
float targetPeriod=targetCirc/vcirc(targetR);
float targetW=2*PI/targetPeriod;
float chaserR=675000;
float chaserCirc=2*PI*chaserR;
float chaserPeriod=chaserCirc/vcirc(chaserR);
float chaserW=2*PI/chaserPeriod;
float pixScale=0.0006;
int targetColor=#C0C000;
int chaserColor=#00C000;

int ptsW, ptsH;

PImage kerbinMap, starField;

int numPointsW;
int numPointsH_2pi; 
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

void setup() {
  size(1920,1080,P3D); //<>//
  //Map of Kerbin from http://forum.kerbalspaceprogram.com/index.php?/topic/157368-map-of-kerbin/
  //Exact URL is http://i.imgur.com/GXLlgpl.jpg
  kerbinMap=loadImage("KerbinMap.jpg"); 
  //Starfield from http://smattila.deviantart.com/art/Starfield-stock-154786926
  //with the following post-processing:
  //* Crop to lower-left corner
  //* Flip vertical
  //* Change mode to 256-color paletized
  //* Run through optipng
  starField=loadImage("starfield-small.png");
  ortho();
  ptsW=60;
  ptsH=60;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);
}

float vcirc(float r) {
  return sqrt(KerbinMu/r);
}

void dart(float r) {
  beginShape();
  vertex(r*pixScale-20,20,1);
  vertex(r*pixScale,-50,1);
  vertex(r*pixScale+20,20,1);
  vertex(r*pixScale,0,1);
  endShape();
}

void draw() {
  //Timing and angles
  float t=frameCount/FrameRate; //This is the actual time since start
  t=t*TimeRate; //Now it is scaled time
  float KerbinTheta=t*KerbinW;
  float targetTheta=t*targetW;
  float chaserTheta=t*chaserW;

  //Backdrop
  //background(0x000000);         //Erase with the blackness of Space, since we are working in space
  image(starField,0,0);           //Erase with the starfield image
  
  //Put the origin at the center
  translate(width/2,height/2);    //Don't need to push or pop, since matrix stack is cleared and restored to identity, so we don't need to push before this
  
  //Draw the planet
  pushMatrix();
    rotateZ(-(float)KerbinTheta);
    rotateX(-PI/2);
    noStroke();
    textureSphere(KerbinRe*pixScale,KerbinRe*pixScale,KerbinRe*pixScale,kerbinMap);
  popMatrix();
  
  //Draw the target orbit
  noFill();
  stroke(targetColor*3/4);
  strokeWeight(5);
  arc(0,0,targetR*pixScale*2,targetR*pixScale*2,-targetTheta,0);
  //Draw the target dart
  noStroke();
  fill(targetColor);
  pushMatrix();
    rotateZ(-targetTheta);
    dart(targetR);
  popMatrix();
  
  //Draw the chaser orbit
  noFill();
  stroke(chaserColor*3/4);
  arc(0,0,chaserR*pixScale*2,chaserR*pixScale*2,-chaserTheta,0);
  //Draw the chaser dart
  noStroke();
  fill(chaserColor);
  pushMatrix();
    rotateZ(-chaserTheta);
    dart(chaserR);
  popMatrix();
  
  //Save the frame
//  saveFrame("Rendezvous-001-####.tga");
  //Punch out after drawing a lap of the target
  if(targetTheta>2*PI) exit();
}

void initializeSphere(int numPtsW, int numPtsH_2pi) {

  // The number of points around the width and height
  numPointsW=numPtsW+1;
  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

  for (int i=0; i<numPointsW ;i++) {  // For all the points around the width
    float thetaW=i*2*PI/(numPointsW-1);
    coorX[i]=sin(thetaW);
    coorZ[i]=cos(thetaW);
  }
  
  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
    if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=0;
    } 
    else {
      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
      float thetaH=i*2*PI/(numPointsH_2pi);

      //PI+ below makes the top always the point instead of the bottom.
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=sin(thetaH);
    }
  }
}

void textureSphere(float rx, float ry, float rz, PImage t) { 
  // These are so we can map certain parts of the image on to the shape 
  float changeU=t.width/(float)(numPointsW-1); 
  float changeV=t.height/(float)(numPointsH-1); 
  float u=0;  // Width variable for the texture
  float v=0;  // Height variable for the texture

  beginShape(TRIANGLE_STRIP);
  texture(t);
  for (int i=0; i<(numPointsH-1); i++) {  // For all the rings but top and bottom
    // Goes into the array here instead of loop to save time
    float coory=coorY[i];
    float cooryPlus=coorY[i+1];

    float multxz=multXZ[i];
    float multxzPlus=multXZ[i+1];

    for (int j=0; j<numPointsW; j++) { // For all the pts in the ring
      normal(-coorX[j]*multxz, -coory, -coorZ[j]*multxz);
      vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
      normal(-coorX[j]*multxzPlus, -cooryPlus, -coorZ[j]*multxzPlus);
      vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
      u+=changeU;
    }
    v+=changeV;
    u=0;
  }
  endShape();
}