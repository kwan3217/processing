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
  void draw(float dx, float dy, float t0, float t1, float t2, float t3, float t) {
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
    vertex(Pa.x+dx,Pa.y+dy);
    vertex(O.x+dx,O.y+dy);
    vertex(Pb.x+dx,Pb.y+dy);
    endShape();
    for(int i=0;i<256;i++) {
      stroke(kolor,linterp(0,255,256,0,i)*alpha_scale);
      Pa=new Point(O,P1,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P1,linterp(0,f1,256,f2,i+1));
      line(Pa.x+dx,Pa.y+dy,Pb.x+dx,Pb.y+dy);
      Pa=new Point(O,P2,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P2,linterp(0,f1,256,f2,i+1));
      line(Pa.x+dx,Pa.y+dy,Pb.x+dx,Pb.y+dy);
    }  
    strokeCap(ROUND);
  }
  void draw(float t0, float t1, float t2, float t3, float t) {
    draw(0,0,t0,t1,t2,t3,t);
  }
  void draw(float t0, float t1, float t) {
    //Just fade in, not out
    draw(t0,t1,9999999,9999999,t);
  }
}
