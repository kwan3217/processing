float linterp(float x0, float y0, float x1, float y1, float x) {
  float t=(x-x0)/(x1-x0);
  float result=y0*(1-t)+y1*t;
  return result;
}

int linterp_c(float x0, int c0, float x1, int c1, float x) {
  //print("x0: ",x0,"\n");
  //print("c0: ",String.format("#%08x",c0),"\n");
  //print("x1: ",x1,"\n");
  //print("c1: ",String.format("#%08x",c1),"\n");
  float r=linterp(x0,red(c0),x1,red(c1),x); //<>// //<>//
  //print(String.format("r=linterp(x0=%f,red(c0)=%f,x1=%f,red(c1)=%f,x=%f)=%f\n",x0,red(c0),x1,red(c1),x,r));
  float g=linterp(x0,green(c0),x1,green(c1),x);
  //print(String.format("g=linterp(x0=%f,grn(c0)=%f,x1=%f,grn(c1)=%f,x=%f)=%f\n",x0,green(c0),x1,green(c1),x,g));
  float b=linterp(x0,blue(c0),x1,blue(c1),x);
  //print(String.format("b=linterp(x0=%f,blu(c0)=%f,x1=%f,blu(c1)=%f,x=%f)=%f\n",x0,blue(c0),x1,blue(c1),x,b));
  //print(String.format("color(r=%f,g=%f,b=%f)=#%08x\n",r,g,b,color(r,g,b)));
  return color(r,g,b);
}

class ScalarTrap {
  public float t0,t1,t2,t3;
  ScalarTrap(float Lt0, float Lt1, float Lt2, float Lt3) {
    t0=Lt0;
    t1=Lt1;
    t2=Lt2;
    t3=Lt3;
  }
  ScalarTrap(float Lt0, float Lt1) {
    this(Lt0,Lt1,9999999,9999999);
  }
  float eval(float t) {
    if(t<t0) {
      return 0;
    } else if(t<t1) {
      return linterp(t0,0,t1,1,t);
    } else if(t<t2) {
      return 1;
    } else if(t<t3) {
      return linterp(t2,1,t3,0,t);
    } else {
      return 0;
    }
  }
  boolean up(float t){
    return t<t2;
  }
  String toString() {
    return String.format("ScalarTrap(t0=%f,t1=%f,t2=%f,t3=%f)",t0,t1,t2,t3);
  }
}

class ScalarTraps extends ArrayList<ScalarTrap> {
  float valIfEmpty;
  ScalarTraps(float LvalIfEmpty) {
    super();
    valIfEmpty=LvalIfEmpty;
  }
  ScalarTraps() {
    this(0);
  }
  float eval(float t) {
    if(size()==0) return valIfEmpty;
    float result=0;
    for(ScalarTrap trap:this) {
      result+=trap.eval(t);
    }
    return result;
  }
}
    
class ColorTrap extends ScalarTrap {
  int kolor;
  ColorTrap(float Lt0, float Lt1, float Lt2, float Lt3, int Lkolor) {
    super(Lt0,Lt1,Lt2,Lt3); //<>// //<>//
    kolor=Lkolor;
  }
  int eval(float t, int basecolor) {
    return linterp_c(0,basecolor,1,kolor,eval(t));
  }
  String toString() {
    return String.format("ColorTrap(t0=%f,t1=%f,t2=%f,t3=%f,kolor=0x%08x)",t0,t1,t2,t3,kolor);
  }
}

class ColorTraps extends ArrayList<ColorTrap> {
  int eval(float t, int basecolor) {
    for(ColorTrap trap:this) {
      //print(trap.toString()+"\n");
      if(trap.eval(t)>0) {
        //print("In trap "+trap.toString()+"\n");
        return linterp_c(0,basecolor,1,trap.kolor,trap.eval(t));
      }
    }
    return basecolor;
  }
}

abstract class Element {
  protected int kolor;
  protected ScalarTraps drawList;
  protected ScalarTraps fadeList;
  protected ColorTraps flashList;
  Element(int Lkolor) {
    kolor=Lkolor;
    drawList=new ScalarTraps(1);
    fadeList=new ScalarTraps(1);
    flashList=new ColorTraps();
  }
  Element() {
    this(#000000);
  }
  void addFade(ScalarTrap T) {
    fadeList.add(T);
  }
  void addFade(float t0, float t1, float t2, float t3) {
    fadeList.add(new ScalarTrap(t0,t1,t2,t3));
  }
  void addFade(float t0, float t1) {
    fadeList.add(new ScalarTrap(t0,t1));
  }
  void addDraw(ScalarTrap T) {
    drawList.add(T);
  }
  void addDraw(float t0, float t1, float t2, float t3) {
    drawList.add(new ScalarTrap(t0,t1,t2,t3));
  }
  void addDraw(float t0, float t1) {
    drawList.add(new ScalarTrap(t0,t1));
  }
  void addFlash(float t0, float t1, float t2, float t3, int Lkolor) {
    flashList.add(new ColorTrap(t0,t1,t2,t3,Lkolor));
  }
  void addFlash(float t0, float t1, float t2, float t3) {
    addFlash(t0,t1,t2,t3,#ffffff);
  }
  protected abstract void draw(float dx, float dy, float Lfade, float Ldraw, int baseColor, float xofs, float yofs); 
  void draw(float dx, float dy, float t) {
    float f=fadeList.eval(t);
    float d=drawList.eval(t);
    if(f==0||d==0) return;
    //print(String.format("draw(...t=%f...)\n",t));
    //print(String.format("kolor=%08x\n",kolor));
    int k=flashList.eval(t,kolor);
    //print(String.format("k=%08x\n",k));
    draw(dx,dy,fadeList.eval(t),drawList.eval(t),k,0,0);
  }
  void draw(float t) {
    draw(0,0,t);
  }
  void drawShadow(float dx, float dy, float t) {
    draw(dx,dy,fadeList.eval(t),drawList.eval(t),shadowColor,xshadow,yshadow);
  }
  void drawShadow(float t) {
    drawShadow(0,0,t);
  }
  void draw(float dx, float dy, float t, boolean doMain) {
    if(doMain) {
      draw(dx,dy,t);
    } else {
      drawShadow(dx,dy,t);
    }
  }
  void draw(float t, boolean doMain) {
    draw(0,0,t,doMain);
  }
}

class Point extends Element {
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
  @Override protected void draw(float dx, float dy, float f, float d, int baseColor, float xofs, float yofs) {
    if(label!=null) {
      label.draw(dx,dy,f,d,baseColor,xofs,yofs);
    }
  }
}

class Text extends Element {
  public float x;
  public float y;
  public float w;
  public float h;
  public int horz, vert;
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
  @Override protected void draw(float dx, float dy, float f, float d, int baseColor, float xofs, float yofs) {
    textSize(50);
    textAlign(horz,vert);
    if(f==0) {
      return;
    }
    fill(baseColor,f*255);
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
        text(name,xx+xofs+dx,y+yofs+dy,w,h);
      } else {
        text(name,xx+xofs+dx,y+yofs+dy);
      }
    } else {
      if(w>0 && h>0) {
        rectMode(CORNER);
        text(name,xx+xofs+dx,y+yofs+dy,w,h);
      } else {
        text(name,xx+xofs+dx,y+yofs+dy);
      }
    }
  }
}

class Segment extends Element {
  Point P0,P1;
  Segment(Point LP0, Point LP1, int Lkolor) {
    P0=LP0;
    P1=LP1;
    kolor=Lkolor;
  }
  @Override protected void draw(float dx, float dy, float f, float d, int baseColor, float xofs, float yofs) {
    //Line will draw from P0 at time t0 to P1 at time t1, will start fading out at t2, and will be completely faded out at t3
    if(f==0 || d==0) { //<>// //<>//
      return; //Not time to draw yet
    }
    //print(String.format("draw(...,f=%f,d=%f,baseColor=0x%08x,...)\n",f,d,baseColor));
    float alpha=f*255;
    strokeWeight(5);
    stroke(baseColor,alpha);
    float x=linterp(0,P0.x,1,P1.x,d);
    float y=linterp(0,P0.y,1,P1.y,d);
    line(P0.x+dx,P0.y+dy,x+dx,y+dy);
  }
}

class Line extends Segment {
  Line(Point LP0, Point LP1, int Lkolor) {
    super(LP0,LP1,Lkolor);
  }
  @Override protected void draw(float dx, float dy, float f, float d, int baseColor, float xofs, float yofs) {
    //Line will fade in from P0 at time t0 to P1 at time t1, will start fading out at t2, and will be completely faded out at t3
    if(f==0) {
      return; //Not time to draw yet
    }
    float alpha=f*255;
    stroke(kolor,alpha);
    strokeWeight(3);
    float x0=linterp(0,P0.x,1,P1.x,-9);
    float y0=linterp(0,P0.y,1,P1.y,-9);
    float x1=linterp(0,P0.x,1,P1.x, 9);
    float y1=linterp(0,P0.y,1,P1.y, 9);
    line(x0+dx+xofs,y0+dy+yofs,x1+dx+xofs,y1+dy+yofs);
  }
}

class Angle extends Element {
  Point P1,O,P2; //O is the vertext (following Hilbert) and P1 and P2 are two points on the legs
  float f1,f2;
  Angle(Point LP1, Point LO, Point LP2,int Lkolor) {
    P1=LP1;
    O=LO;
    P2=LP2;
    kolor=Lkolor;
    f1=0.1;
    f2=0.2;
  }
  @Override protected void draw(float dx, float dy, float f, float d, int baseColor, float xofs, float yofs) {
    if(f==0) {
      return;
    } 
    float alpha_scale=f;
    Point Pa=new Point(O,P1,f1);
    Point Pb=new Point(O,P2,f1);
    stroke(baseColor,alpha_scale*255);
    noFill();
    strokeJoin(ROUND);
    strokeCap(SQUARE);
    beginShape();
    vertex(Pa.x+dx,Pa.y+dy);
    vertex(O.x+dx,O.y+dy);
    vertex(Pb.x+dx,Pb.y+dy);
    endShape();
    for(int i=0;i<256;i++) {
      stroke(baseColor,linterp(0,255,256,0,i)*alpha_scale);
      Pa=new Point(O,P1,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P1,linterp(0,f1,256,f2,i+1));
      line(Pa.x+dx+xofs,Pa.y+dy+yofs,Pb.x+dx+xofs,Pb.y+dy+yofs);
      Pa=new Point(O,P2,linterp(0,f1,256,f2,i  ));
      Pb=new Point(O,P2,linterp(0,f1,256,f2,i+1));
      line(Pa.x+dx+xofs,Pa.y+dy+yofs,Pb.x+dx+xofs,Pb.y+dy+yofs);
    }  
    strokeCap(ROUND);
  }
}

interface Scene {
  void draw(float t);   
  float sceneTime();
  
}

class SceneArray implements Scene {
  Scene[] subscene;
  float sceneTimeSum;
  SceneArray(Scene[] Lsubscene) {
    subscene=Lsubscene;
    for(int i=0;i<subscene.length;i++) {
      sceneTimeSum+=subscene[i].sceneTime();
    }
  }
  float sceneTime() {
    return sceneTimeSum;
  }
  void draw(float t) {
    float sceneT=0;
    for(int i=0;i<subscene.length;i++) {
      if(t>=sceneT && t<sceneT+subscene[i].sceneTime()) {
        subscene[i].draw(t-sceneT);
      } else {
        sceneT+=subscene[i].sceneTime();
      }
    }
  }
}

abstract class ElementLayerScene implements Scene {
  private ArrayList<ArrayList<Element>> layers;
  private int currentLayer;
  ElementLayerScene() {
    layers=new ArrayList<ArrayList<Element>>();
    setLayer(0);
  }
  void setLayer(int LcurrentLayer) {
    currentLayer=LcurrentLayer;
    while(currentLayer>=layers.size()) {
      layers.add(new ArrayList<Element>());
    }
  }
  Element add(Element E) {
    layers.get(currentLayer).add(E);
    return E;
  }
  private void draw(float t, boolean doMain) {
    for(ArrayList<Element> layer:layers) {
      for(Element E:layer) {
        E.draw(t,doMain);
      }
    }
  }
  @Override 
  void draw(float t) {
    adjust(t);
    //draw(t,false);
    draw(t,true);
  }
  void adjust(float t) {}
}
