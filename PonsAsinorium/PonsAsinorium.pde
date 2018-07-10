int background=#c0c0c0;
                   
float desiredFrameRate=24;

float linterp(float x0, float y0, float x1, float y1, float x) {
  float t=(x-x0)/(x1-x0);
  float result=y0*(1-t)+y1*t;
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
  Point(Point P) {
    x=P.x;
    y=P.y;
    label=P.label;
    h=P.h;
    v=P.v;
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
    if(horz==CENTER) {
      rectMode(CENTER);
      if(w>0 && h>0) {
        text(name,xx,y,w,h);
      } else {
        text(name,xx,y);
      }
    } else {
      if(w>0 && h>0) {
        rectMode(CORNER);
        text(name,xx,y,w,h);
      } else {
        text(name,xx,y);
      }
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

class Angle {
  Point P1,O,P2; //O is the vertext (following Hilbert) and P1 and P2 are two points on the legs
  int kolor;
  float f1,f2;
  Angle(Point LP1, Point LO, Point LP2,int Lkolor) {
    P1=LP1;
    O=LO;
    P2=LP2;
    kolor=Lkolor;
    f1=0.1;
    f2=0.2;
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    float alpha_scale;
    if(t<t0) {
      return;
    } else if(t<t1) {
      alpha_scale=linterp(t0,0,t1,1,t);
    } else if(t<t2) {
      alpha_scale=1;
    } else if(t<t3) {
      alpha_scale=linterp(t2,1,t3,0,t);
    } else {
      return;
    }
    Point Pa=new Point(O,P1,f1);
    Point Pb=new Point(O,P2,f1);
    stroke(kolor,alpha_scale*255);
    noFill();
    strokeJoin(ROUND);
    strokeCap(SQUARE);
    beginShape();
    vertex(Pa.x,Pa.y);
    vertex(O.x,O.y);
    vertex(Pb.x,Pb.y);
    endShape();
    for(int i=0;i<256;i++) {
      stroke(kolor,linterp(0,255,256,0,i)*alpha_scale);
      Pa=new Point(O,P1,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P1,linterp(0,f1,256,f2,i+1));
      line(Pa.x,Pa.y,Pb.x,Pb.y);
      Pa=new Point(O,P2,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P2,linterp(0,f1,256,f2,i+1));
      line(Pa.x,Pa.y,Pb.x,Pb.y);
    }  
    strokeCap(ROUND);
  }
  void draw(float t0, float t1, float t) {
    //Just fade in, not out
    draw(t0,t1,9999999,9999999,t);
  }
}

Point A,B,C,F,G;
Point AL,BL,CL,FL;
Point AR,BR,CR,GR;
Segment AB,CA,BC,BF,CG,CF,BG;
Segment AFLflash,CFLflash,ABLflash,ACLflash;
Segment AGRflash,BGRflash,ABRflash,ACRflash;
Segment BFLflash,CGRflash;
Segment BGflash,CFflash;
Segment CFL,ABL,ACL;
Segment BGR,ABR,ACR;
Segment BFL,CGR;
Segment BCL,BCR;
Angle BACL,BACR,AFCL,AGBR,ACFL,ABGR;
Angle BAC,AFC,AGB,ACF,ABG;
Angle BCF,CBG,BCFL,CBGR;
Point BL1,BL2,BL3;
Point AL1,AL2,AL3;
Point 
Line lAB,lAC;
Text[] PointLabel=new Text[5];
Text[] step=new Text[14];

void setup() {
  size(1920,1080,P2D);
  frameRate(desiredFrameRate);
  A=new Point(width*0.7,height*0.2);PointLabel[0]=new Text(A,#ff0000,"A",LEFT,BASELINE, true);A.label=PointLabel[0];
  B=new Point(width*0.6,height*0.6);PointLabel[1]=new Text(B,#FF8000,"B",RIGHT,BASELINE, true);B.label=PointLabel[1];  
  C=new Point(width*0.8,height*0.6);PointLabel[2]=new Text(C,#FF8000,"C",LEFT,BASELINE, true);C.label=PointLabel[2];
  F=new Point(A,B,1.3);PointLabel[3]=new Text(F,#000000,"F",RIGHT,BASELINE, true);F.label=PointLabel[3];
  G=new Point(A,C,1.3);PointLabel[4]=new Text(G,#000000,"G",LEFT,BASELINE, true);G.label=PointLabel[4];
  AL=new Point(A.x,A.y);
  BL=new Point(B.x,B.y);
  CL=new Point(C.x,C.y);
  FL=new Point(F.x,F.y);
  AR=new Point(A.x,A.y);
  BR=new Point(B.x,B.y);
  CR=new Point(C.x,C.y);
  GR=new Point(G.x,G.y);
  BL1=new Point(B.x-width*0.3  ,B.y-2.5);
  BL2=new Point(B.x-width*0.3  ,B.y+2.5);
  BL3=new Point(B.x-width*0.3-5,B.y);
  AL1=new Point(A.x-width*0.3  ,A.y-2.5);
  AL2=new Point(A.x-width*0.3  ,A.y+2.5);
  AL3=new Point(A.x-width*0.3-5,A.y);
  CL1=new Point(C.x-width*0.3  ,C.y-2.5);
  CL2=new Point(C.x-width*0.3  ,C.y+2.5);
  CL3=new Point(C.x-width*0.3-5,C.y);
  GL1=new Point(G.x-width*0.3  ,G.y-2.5);
  GL2=new Point(G.x-width*0.3  ,G.y+2.5);
  GL3=new Point(G.x-width*0.3-5,G.y);
  BACL=new Angle(BL,AL,CL,#ffffff);
  BACR=new Angle(BR,AR,CR,#ffffff);
  AFCL=new Angle(AL,FL,CL,#00ff00);
  AGBR=new Angle(AR,GR,BR,#00ff00);
  ACFL=new Angle(AL,CL,FL,#ff8000);
  ABGR=new Angle(AR,BR,GR,#ff8000);
  BCFL=new Angle(BL,CL,FL,#ff00ff);
  CBGR=new Angle(CR,BR,GR,#ff00ff);
  BCF=new Angle(B,C,F,#ff00ff);
  CBG=new Angle(C,B,G,#ff00ff);
  BAC=new Angle(B,A,C,#ffffff);
  AFC=new Angle(A,F,C,#00ff00);
  AGB=new Angle(A,G,B,#00ff00);
  ACF=new Angle(A,C,F,#ff8000);
  ABG=new Angle(A,B,G,#ff8000);
  AB=new Segment(A,B,#FF0000);
  lAB=new Line(A,B,#404040);
  CA=new Segment(C,A,#FF0000);
  lAC=new Line(A,C,#404040);
  BC=new Segment(B,C,#000000);
  BF=new Segment(B,F,#FFFF00);
  CG=new Segment(C,G,#FFFF00);
  CF=new Segment(C,F,#000000);
  BG=new Segment(B,G,#000000);
  ABLflash=new Segment(AL,BL,#ffffff);
  ACLflash=new Segment(AL,CL,#ffffff);
  ABRflash=new Segment(AR,BR,#ffffff);
  ACRflash=new Segment(AR,CR,#ffffff);
  AFLflash=new Segment(AL,FL,#ffffff);
  AGRflash=new Segment(AR,GR,#ffffff);
  BGRflash=new Segment(BR,GR,#ffffff);
  CFLflash=new Segment(CL,FL,#ffffff);
  BFLflash=new Segment(BL,FL,#ffffff);
  CGRflash=new Segment(CR,GR,#ffffff);
  BGflash=new Segment(B,G,#ffffff);
  CFflash=new Segment(C,F,#ffffff);
  ABL=new Segment(AL,BL,AB.kolor);
  ACL=new Segment(AL,CL,CA.kolor);
  ABR=new Segment(AR,BR,AB.kolor);
  ACR=new Segment(AR,CR,CA.kolor);
  BGR=new Segment(BR,GR,BG.kolor);
  CFL=new Segment(CL,FL,CF.kolor);
  BFL=new Segment(BL,FL,BF.kolor);
  CGR=new Segment(CR,GR,CG.kolor);
  BCL=new Segment(BL,CL,BC.kolor);
  BCR=new Segment(BR,CR,BC.kolor);
  step[0]=new Text(100,100,700,#000000,"Draw a triangle ABC with sides AB and AC equal. Two sides are equal, but are two angles?",LEFT,BASELINE,false);
  step[1]=new Text(100,150,700,#000000,"Pick a point F on the line through AB some distance past B, and draw segment BF.",LEFT,BASELINE,false);
  step[2]=new Text(100,200,700,#000000,"Find the point G on the line through AC such that the length of CG is the same as the length of BF.",LEFT,BASELINE,false);
  step[3]=new Text(100,250,700,#000000,"Complete two more triangles AFC and AGB by drawing sides CF and BG.",LEFT,BASELINE,false);
  step[4]=new Text(100,300,700,#000000,"Since AF is the combination of AB and BF...",LEFT,BASELINE,false);
  step[5]=new Text(100,550,700,#000000,"...it is congruent to AG, which is the combination of AC and CG.",LEFT,BASELINE,false);
  step[6]=new Text(width*0.7,000,width*0.9,#000000,"Triangles AFC and AGB have angle A in common, and corresponding sides AF and AG are congruent, as are AB and AC.",CENTER,CENTER,false);
  step[7]=new Text(width*0.7,000,width*0.9,#000000,"Therefore by the SAS axiom, all the remaining parts of the triangles are congruent.",CENTER,CENTER,false);
  step[8]=new Text(width*0.7,000,width*0.9,#000000,"Now consider the triangles BFC and CGB",CENTER,CENTER,false);
  step[9]=new Text(width*0.7,000,width*0.9,#000000,"We have already proven angles AFC and AGB to be congruent, as well as sides BG and CF. Sides BF and CG are congruent by construction.",CENTER,CENTER,false);
  step[10]=new Text(width*0.7,000,width*0.9,#000000,"Therefore by the SAS axiom, all the remaining parts of the triangles are congruent.",CENTER,CENTER,false);
  step[11]=new Text(width*0.7,000,width*0.9,#000000,"On the left side, angle ABC combines with angle CBG to make angle ABG.",CENTER,CENTER,false);
  step[12]=new Text(width*0.7,050,width*0.9,#000000,"On the right side, angle ACB combines with angle BCF to make angle ACF.",CENTER,CENTER,false);
  step[13]=new Text(width*0.7,100,width*0.9,#000000,"On each side, you start with an equal angle, and subtract an equal angle. Therefore the part that is left must be equal.",CENTER,CENTER,false);
}

void draw() {
  background(#c0c0c0);
  float t=frameCount/desiredFrameRate+70;
  if(t>90) {
    exit();
  }
  float MoveT0=45;
  float MoveT1=48;
  float MoveT2=80;
  float MoveT3=83;
  //Move to the center at the appropriate time
  if(t<MoveT0) {
  } else if(t<MoveT1) {
    translate(linterp(MoveT0,0,MoveT1,-width*0.2,t),linterp(MoveT0,0,MoveT1,height*0.1,t));
  } else if(t<MoveT2) {
    translate(-width*0.2,height*0.1);
  } else if(t<MoveT3) {
    translate(linterp(MoveT3,0,MoveT2,-width*0.2,t),linterp(MoveT3,0,MoveT2,height*0.1,t));
  } else {
  }
  float MoveTri1T0=48;
  float MoveTri1T1=50;
  float MoveTri1T2=68;
  float MoveTri1T3=70;
  if(t<MoveTri1T0) {
  } else if(t<MoveTri1T1) {
    //Move triangles out
    AL.x=A.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    BL.x=B.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    CL.x=C.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    FL.x=F.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);

    AR.x=A.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    BR.x=B.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    CR.x=C.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    GR.x=G.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
  } else if(t<MoveTri1T2) {
    //Leave triangles out
    AL.x=A.x-width*0.3;
    BL.x=B.x-width*0.3;
    CL.x=C.x-width*0.3;
    FL.x=F.x-width*0.3;

    AR.x=A.x+width*0.3;
    BR.x=B.x+width*0.3;
    CR.x=C.x+width*0.3;
    GR.x=G.x+width*0.3;
  } else if(t<MoveTri1T3) {
    //move triangles back
    AL.x=A.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    BL.x=B.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    CL.x=C.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    FL.x=F.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);

    AR.x=A.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    BR.x=B.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    CR.x=C.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    GR.x=G.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
  } else {
  }
  //These ranges don't overlap, and both if/then chains do nothing if
  //they are outside their ranges, so it is ok to reuse the variables.
  MoveTri1T0=70;
  MoveTri1T1=72;
  MoveTri1T2=88;
  MoveTri1T3=90;
  if(t<MoveTri1T0) {
  } else if(t<MoveTri1T1) {
    //Move triangles out
    AL.x=A.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    BL.x=B.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    CL.x=C.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    FL.x=F.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);

    AR.x=A.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    BR.x=B.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    CR.x=C.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    GR.x=G.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
  } else if(t<MoveTri1T2) {
    //Leave triangles out
    AL.x=A.x-width*0.3;
    BL.x=B.x-width*0.3;
    CL.x=C.x-width*0.3;
    FL.x=F.x-width*0.3;

    AR.x=A.x+width*0.3;
    BR.x=B.x+width*0.3;
    CR.x=C.x+width*0.3;
    GR.x=G.x+width*0.3;
  } else if(t<MoveTri1T3) {
    //move triangles back
    AL.x=A.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    BL.x=B.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    CL.x=C.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    FL.x=F.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);

    AR.x=A.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    BR.x=B.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    CR.x=C.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    GR.x=G.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
  } else {
  }
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
  BF.draw(11,12,t);
  F.draw(11,11.5,t);
  step[1].draw(10,10.5,14.5,15,t);
  //Draw segment CE
  CG.draw(16,17,t);
  G.draw(16,16.5,t);
  step[2].draw(15,15.5,19.5,20,t);
  //Draw two new triangles
  CF.draw(20,21,t);
  CFLflash.draw(21,21,22,23,t);
  AFLflash.draw(21,21,22,23,t);
  ACLflash.draw(21,21,22,23,t);
  BG.draw(23,24,t);
  BGRflash.draw(24,24,25,26,t);
  AGRflash.draw(24,24,25,26,t);
  ABRflash.draw(24,24,25,26,t);
  step[3].draw(20,20.5,27.5,28,t);
  //Show that AD and AE are congruent
  step[4].draw(28,28.5,44.5,45,t);
  ABLflash.draw(28,28,29,30,t);
  BFLflash.draw(30,30,31,32,t);
  AFLflash.draw(32,32,33,34,t);
  step[5].draw(35,35.5,44.5,45,t);
  ACRflash.draw(35,35,36,37,t);
  CGRflash.draw(37,37,38,39,t);
  AGRflash.draw(39,39,40,41,t);
  //Show tht ADC and AEB are congruent
  step[6].draw(48,48.5,58,58.5,t);
  //Draw the outside triangles
  ABL.draw(48,48,67,68,t);
  ACL.draw(48,48,67,68,t);
  BFL.draw(48,48,67,68,t);
  CFL.draw(48,48,67,68,t);
  ABR.draw(48,48,67,68,t);
  ACR.draw(48,48,67,68,t);
  BGR.draw(48,48,67,68,t);
  CGR.draw(48,48,67,68,t);
  //Show the corresponding parts
  BACL.draw(51,51,52,53,t);
  BACR.draw(51,51,52,53,t);
  BAC.draw(51,51,52,53,t);
  ABLflash.draw(53,53,54,55,t);
  BFLflash.draw(53,53,54,55,t);
  ACRflash.draw(53,53,54,55,t);
  CGRflash.draw(53,53,54,55,t);
  ACLflash.draw(55,55,56,57,t);
  ABRflash.draw(55,55,56,57,t);
  //Show the other parts as congruent
  step[7].draw(59,59.5,69.5,70,t);
  CFLflash.draw(60,60,61,62,t);
  BGRflash.draw(60,60,61,62,t);
  CFflash.draw(60,60,61,62,t);
  BGflash.draw(60,60,61,62,t);
  if(t>60) {
    CFL.kolor=#0000ff;
    BGR.kolor=#0000ff;
    CF.kolor=#0000ff;
    BG.kolor=#0000ff;
  }
  AGBR.draw(62,62,63,64,t);
  AFCL.draw(62,62,63,64,t);
  ABGR.draw(64,64,65,66,t);
  ACFL.draw(64,64,65,66,t);
  AGB.draw(62,62,t);
  AFC.draw(62,62,t);
  ABG.draw(64,64,t);
  ACF.draw(64,64,t);
  //Show off the small triangles
  step[8].draw(70,70.5,74.5,75,t);
  BFL.draw(70,70,87,88,t);
  BCL.draw(70,70,87,88,t);
  CFL.draw(70,70,87,88,t);
  CGR.draw(70,70,87,88,t);
  BGR.draw(70,70,87,88,t);
  BCR.draw(70,70,87,88,t);
  AFCL.draw(70,70,87,88,t);
  AGBR.draw(70,70,87,88,t);
  step[9].draw(75,75.5,79.5,80,t);
  BCFL.draw(76,76,77,78,t);
  CBGR.draw(76,76,77,78,t);
  BCF.draw(76,76,t);
  CBG.draw(76,76,t);
 // saveFrame("PonsAsinorium-#####.png");
}
                 
                 
