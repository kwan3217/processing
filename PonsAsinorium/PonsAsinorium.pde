int background=#c0c0c0;
                   
float desiredFrameRate=24;

float linterp(float x0, float y0, float x1, float y1, float x) {
  print("x0="+x0+", y0="+y0+", x1="+x1+", y1="+y1+", x="+x);
  float t=(x-x0)/(x1-x0);
  print(", t="+t);
  float result=y0*(1-t)+y1*t;
  print(", result="+result+"\n");
  return result;
}

class Point {
  public float x;
  public float y;
  public Text label;
  int h,v;
  Point(float Lx, float Ly) {
    x=Lx;
    y=Ly;
    label=null;
  }
  Point(Point P0, Point P1, float t) {
    this(linterp(0,P0.x,1,P1.x,t),linterp(0,P0.y,1,P1.y,t));
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    if(label!=null) {
      label.draw(t0,t1,t2,t3,t);
    }
  }
  void draw(float t0, float t1, float t) {
    //Just fade in, not out
    draw(t0,t1,9999999,9999999,t);
  }
}

class Text{
  public float x;
  public float y;
  public float w;
  public float h;
  public int horz, vert;
  public int kolor;
  public String name;
  public boolean ofs;
  Text(float Lx, float Ly, float Lw, float Lh, int Lkolor, String Lname, int Lhorz, int Lvert, boolean Lofs) {
    x=Lx;
    y=Ly;
    w=Lw;
    h=Lh;
    kolor=Lkolor;
    name=Lname;
    horz=Lhorz;
    vert=Lvert;
    ofs=Lofs;
  }
  Text(float Lx, float Ly, int Lkolor, String Lname, int Lhorz, int Lvert, boolean Lofs) {
    this(Lx,Ly,-1,-1,Lkolor,Lname,Lhorz,Lvert,Lofs);
  }
  Text(float Lx, float Ly, float Lw, int Lkolor, String Lname, int Lhorz, int Lvert, boolean Lofs) {
    this(Lx,Ly,Lw,99999,Lkolor,Lname,Lhorz,Lvert,Lofs);
  }
  Text(Point P, int Lkolor, String Lname, int Lhorz, int Lvert, boolean Lofs) {
    //Text object as a Point label. Doesn't need bounding box constraint
    this(P.x,P.y,-1,-1,Lkolor,Lname,Lhorz,Lvert,Lofs);
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    textSize(50);
    textAlign(horz,vert);
    if(t<t0) {
      return;
    } else if(t<t1) {
      fill(kolor,linterp(t0,0,t1,255,t));
    } else if(t<t2) {
      fill(kolor);
    } else if(t<t3) {
      fill(kolor,linterp(t2,255,t3,0,t));
    } else {
      return;
    }
    float xx=x;
    if(ofs) {
      if(horz==LEFT) {
        xx+=20;
      } else if(horz==RIGHT) {
        xx-=20;
      }
    }
    if(w>0 && h>0) {
      rectMode(CORNER);
      text(name,xx,y,w,h);
    } else {
      text(name,xx,y);
    }
  }
  void draw(float t0, float t1, float t) {
    //Just fade in, not out
    draw(t0,t1,9999999,9999999,t);
  }
}

class Segment {
  Point P0,P1;
  int kolor;
  Segment(Point LP0, Point LP1, int Lkolor) {
    P0=LP0;
    P1=LP1;
    kolor=Lkolor;
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    //Line will draw from P0 at time t0 to P1 at time t1, will start fading out at t2, and will be completely faded out at t3
    if(t<t0) {
      return; //Not time to draw yet
    } else if(t<t1) {
      float x=linterp(t0,P0.x,t1,P1.x,t);
      float y=linterp(t0,P0.y,t1,P1.y,t);
      stroke(kolor);
      strokeWeight(5);
      line(P0.x,P0.y,x,y);
    } else if(t<t2) {
      stroke(kolor);
      strokeWeight(5);
      line(P0.x,P0.y,P1.x,P1.y);
    } else if(t<t3) {
      float alpha=linterp(t2,255,t3,0,t);
      print("Fading out: alpha="+alpha+"\n");
      strokeWeight(5);
      stroke(kolor,alpha);
      line(P0.x,P0.y,P1.x,P1.y);
    } else {
      return; //Line has already faded away
    }
  }
  void draw(float t0, float t1, float t) {
    //Just fade in, not out
    draw(t0,t1,9999999,9999999,t);
  }
}

class Line extends Segment {
  Line(Point LP0, Point LP1, int Lkolor) {
    super(LP0,LP1,Lkolor);
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    //Line will fade in from P0 at time t0 to P1 at time t1, will start fading out at t2, and will be completely faded out at t3
    if(t<t0) {
      return; //Not time to draw yet
    } else if(t<t1) {
      float alpha=linterp(t0,0,t1,255,t);
      stroke(kolor,alpha);
    } else if(t<t2) {
      stroke(kolor);
    } else if(t<t3) {
      float alpha=linterp(t2,255,t3,0,t);
      stroke(kolor,alpha);
    } else {
      return; //Line has already faded away
    }
    strokeWeight(3);
    float x0=linterp(0,P0.x,1,P1.x,-9);
    float y0=linterp(0,P0.y,1,P1.y,-9);
    float x1=linterp(0,P0.x,1,P1.x, 9);
    float y1=linterp(0,P0.y,1,P1.y, 9);
    line(x0,y0,x1,y1);
  }
}
Point A,B,C,D,E;
Segment AB,CA,BC,BD,CE,CD,BE;
Segment ADflash,CDflash,ACflash;
Segment AEflash,BEflash,ABflash;
Segment BDflash,CEflash;
Line lAB,lAC;
Text[] PointLabel=new Text[5];
Text[] step=new Text[7];

void setup() {
  size(1920,1080,P2D);
  frameRate(desiredFrameRate);
  A=new Point(width*0.7,height*0.2);PointLabel[0]=new Text(A,#ff0000,"A",LEFT,BASELINE, true);A.label=PointLabel[0];
  B=new Point(width*0.6,height*0.6);PointLabel[1]=new Text(B,#FF8000,"B",RIGHT,BASELINE, true);B.label=PointLabel[1];  
  C=new Point(width*0.8,height*0.6);PointLabel[2]=new Text(C,#FF8000,"C",LEFT,BASELINE, true);C.label=PointLabel[2];
  D=new Point(A,B,1.3);PointLabel[3]=new Text(D,#000000,"D",RIGHT,BASELINE, true);D.label=PointLabel[3];
  E=new Point(A,C,1.3);PointLabel[4]=new Text(E,#000000,"E",LEFT,BASELINE, true);E.label=PointLabel[4];
  AB=new Segment(A,B,#FF0000);
  lAB=new Line(A,B,#404040);
  CA=new Segment(C,A,#FF0000);
  lAC=new Line(A,C,#404040);
  BC=new Segment(B,C,#000000);
  BD=new Segment(B,D,#FFFF00);
  CE=new Segment(C,E,#FFFF00);
  CD=new Segment(C,D,#0000FF);
  BE=new Segment(B,E,#0000FF);
  ABflash=new Segment(A,B,#ffffff);
  ACflash=new Segment(A,C,#ffffff);
  ADflash=new Segment(A,D,#ffffff);
  AEflash=new Segment(A,E,#ffffff);
  BEflash=new Segment(B,E,#ffffff);
  CDflash=new Segment(C,D,#ffffff);
  BDflash=new Segment(B,D,#ffffff);
  CEflash=new Segment(C,E,#ffffff);
  step[0]=new Text(100,100,700,#000000,"Draw a triangle ABC with sides AB and AC equal. Two sides are equal, but are two angles?",LEFT,BASELINE,false);
  step[1]=new Text(100,150,700,#000000,"Pick a point D on the line through AB some distance past B, and draw segment BD",LEFT,BASELINE,false);
  step[2]=new Text(100,200,700,#000000,"Find the point E on the line through AC such that the length of CE is the same as the length of BD",LEFT,BASELINE,false);
  step[3]=new Text(100,250,700,#000000,"Complete two more triangles ADC and AEB by drawing sides CD and BE",LEFT,BASELINE,false);
  step[4]=new Text(100,300,700,#000000,"Since AD is the combination of AB and BD...",LEFT,BASELINE,false);
  step[5]=new Text(100,350,700,#000000,"...it is congruent to AE, which is the combination of AC and CE",LEFT,BASELINE,false);
  step[6]=new Text(100,400,700,#000000,"Triangles ADC and AEB have angle A in common, and corresponding sides AD and AE are congruent, as are AB and AC",LEFT,BASELINE,false);
}

void draw() {
  background(#c0c0c0);
  float t=frameCount/desiredFrameRate;
  if(t>50) {
    exit();
  }
  print("Frame "+frameCount+", t="+t+"\n");
  //This will draw under the triangle during construction of BD
  lAB.draw(10,11,12,13,t);
  //This will draw under the triangle during construction of CE
  lAC.draw(15,16,17,18,t);
  //Draw the triangle
  A.draw(0,0.3,t);
  B.draw(0.3,0.6,t);
  AB.draw(0,1,t);
  C.draw(1.0,1.3,t);
  BC.draw(1,2,t);
  CA.draw(2,3,t);
  step[0].draw(0,0.5,9.5,10.0,t);
  //Draw segment BD
  BD.draw(11,12,t);
  D.draw(11,11.5,t);
  step[1].draw(10,10.5,14.5,15,t);
  //Draw segment CE
  CE.draw(16,17,t);
  E.draw(16,16.5,t);
  step[2].draw(15,15.5,19.5,20,t);
  //Draw two new triangles
  CD.draw(20,21,t);
  CDflash.draw(21,21,21,22,t);
  ADflash.draw(21,21,21,22,t);
  ACflash.draw(21,21,21,22,t);
  BE.draw(22,23,t);
  BEflash.draw(23,23,23,24,t);
  AEflash.draw(23,23,23,24,t);
  ABflash.draw(23,23,23,24,t);
  step[3].draw(20,20.5,24.5,25,t);
  //Show that AD and AE are congruent
  step[4].draw(25,25.5,31.5,32,t);
  ABflash.draw(26,26,27,28,t);
  BDflash.draw(28,28,29,30,t);
  ADflash.draw(30,30,31,32,t);
  step[5].draw(32,32.5,39.5,40,t);
  ACflash.draw(33,33,34,35,t);
  CEflash.draw(35,35,36,37,t);
  AEflash.draw(37,37,38,39,t);
  //Show tht ADC and AEB are congruent
  step[6].draw(40,40.5,49.5,50,t);
 // saveFrame("PonsAsinorium-#####.png");
}
                 
                 
