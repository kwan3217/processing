int background=#c0c0c0;
                   
float desiredFrameRate=24;

float SceneLen[]={2,2,2};
float SceneEnd[]=new float[SceneLen.length];

float linterp(float x0, float y0, float x1, float y1, float x) {
  print("x0="+x0+", y0="+y0+", x1="+x1+", y1="+y1+", x="+x);
  float t=(x-x0)/(x1-x0);
  print(", t="+t);
  float result=y0*(1-t)+y1*t;
  print(", result="+result+"\n");
  return result;
}

void setup() {
  size(1920,1080,P2D);
  frameRate(10);
  SceneEnd[0]=SceneLen[0];
  for(int i=1;i<SceneLen.length;i++) {
    SceneEnd[i]=SceneEnd[i-1]+SceneLen[i];
  }
  strokeWeight(5);
}

class Point {
  public float x;
  public float y;
  public int kolor;
  public String name;
  Point(float Lx, float Ly, int Lkolor, String Lname) {
    x=Lx;
    y=Ly;
    kolor=Lkolor;
    name=Lname;
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
      line(P0.x,P0.y,x,y);
      return;
    } else if(t<t2) {
      stroke(kolor);
      line(P0.x,P0.y,P1.x,P1.y);
    } else if(t<t3) {
      float alpha=linterp(t2,1,t3,0,t);
      stroke(kolor,alpha);
      line(P0.x,P0.y,P1.x,P1.y);
    } else {
      return; //Line has already faded away
    }
  }
}

Point A=new Point(960,200,#000000,"A");
Point B=new Point(960-200,800,#000000,"B");
Point C=new Point(960+200,800,#000000,"B");
Point D=new Point(linterp(0,A.x,1,B.x,1.5),linterp(0,A.y,1,B.y,1.5),#000000,"D");
Point E=new Point(linterp(0,A.x,1,C.x,1.5),linterp(0,A.y,1,C.y,1.5),#000000,"E");
Segment AB=new Segment(A,B,#FF0000);
Segment AC=new Segment(A,C,#FF0000);
Segment BC=new Segment(B,C,#000000);
Segment BD=new Segment(B,D,#FFFF00);
Segment CE=new Segment(C,E,#FFFF00);

void draw() {
  background(#c0c0c0);
  float t=frameCount/desiredFrameRate;
  print("Frame "+frameCount+", t="+t+"\n");
  if(t<SceneEnd[0]) {
    //Draw the triangle
    float SceneT=linterp(0,0,SceneEnd[0],1,t);
    AB.draw(0.0/3.0,1.0/3.0,2.0/3.0,3.0/3.0,SceneT);
    AC.draw(0.0/3.0,1.0/3.0,2.0/3.0,3.0/3.0,SceneT);
    BC.draw(0.0/3.0,1.0/3.0,2.0/3.0,3.0/3.0,SceneT);
    BD.draw(0.0/3.0,1.0/3.0,2.0/3.0,3.0/3.0,SceneT);
    CE.draw(0.0/3.0,1.0/3.0,2.0/3.0,3.0/3.0,SceneT);
  } else if(t<SceneEnd[1]) {
    exit();
  } else if(t<SceneEnd[2]) {
  } else {
    exit();
  }
  saveFrame("PonsAsinorium-#####.png");
}
                 
                 
