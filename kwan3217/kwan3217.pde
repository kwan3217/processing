String PI="314159265358979323846264338327950288419716939937510582";
String E ="271828182845904523536028747135266249775724709369995957";

int digitColors[]={#404040,
                   #663300,
                   #ff0000,
                   #ff8000,
                   #ffff00,
                   #00ff00,
                   #0000ff,
                   #8000ff,
                   #808080,
                   #ffffff};
                   
int background=#c0c0c0;

int colorterp(int c0, int c1, float t, boolean verbose) {
  if(t<0) t=0;
  if(t>1) t=1;
  int a=(int)(255*t);
  if(a<255) verbose=true;
  if(verbose) {
    println("a: ",a);
  }
  int c= (c1 & 0x00FFFFFF) |
         ((int) a)<<24;
  if(verbose) {
    println("c0: ",hex(c0,8));
    println("c1: ",hex(c1,8));
    println("c:  ",hex(c ,8));
  }
  return c;
}
  
PFont italic,number;
                   
void setup() {
  size(1920,1080,P2D);
  frameRate(10);
  colorterp(background,digitColors[2],0.5,true);
  italic=createFont("Times New Roman Italic",200);
  number=createFont("Ubuntu Mono",200);
}

void drawString(String s, float x, float y, float fade, float fade2, float spacing) {
  if(fade<0) return;
  int max=(int)fade;
  if(max>s.length()) max=s.length();
  for(int i=0;i<max;i++) {
    char c=s.charAt(i);
    int colorNum;
    if(c>='0' && c<='9') {
      colorNum=digitColors[s.charAt(i)-'0'];
    } else {
      colorNum=digitColors[9];
    }
    colorNum=colorterp(background,colorNum,fade-(float)i-1,false);
    colorNum=colorterp(background,colorNum,fade2,false);
    fill(colorNum);
    text(c,x+spacing*i,y);
  }
}

float cubic(float t) {
  if(t<0) return 0;
  if(t>1) return 1;
  return 6*(t*t/2-t*t*t/3);
}

float desiredFrameRate=60;

void draw() { //<>//
  float t=((float)frameCount)/((float)desiredFrameRate);
  float letterSpeed=10;
  background(background);
  textSize(72);
  translate(0,540);
  scale(1+cubic(t/6));
  float Scene1len=2;
  float Scene2len=2;
  float Scene3len=2;
  float piStart=0; //seconds
  float  eStart=1; //seconds
  float lineHeight=150;
  if(t<Scene1len) {
    textFont(italic);
    drawString("\u03C0=",200,-lineHeight/2,(t-piStart)*letterSpeed,1,100);
    drawString(     "e=",200, lineHeight/2,(t- eStart)*letterSpeed,1,100);
    textFont(number);
    drawString(PI ,450,-lineHeight/2,(t-piStart)*letterSpeed-2,1,100);
    drawString(E  ,450, lineHeight/2,(t- eStart)*letterSpeed-2,1,100);
    drawString(".",500,-lineHeight/2,(t-piStart)*letterSpeed-2,1,100);
    drawString(".",500, lineHeight/2,(t- eStart)*letterSpeed-2,1,100);
  } else {
    float spread=cubic((t-Scene1len)/Scene2len);
    textFont(italic);
    fill(colorterp(background,digitColors[9],1-spread,false));
    drawString("\u03C0=",200,-lineHeight/2,(t-piStart)*letterSpeed,1-spread,100);
    drawString(     "e=",200, lineHeight/2,(t- eStart)*letterSpeed,1-spread,100);
    textFont(number);
    fill(colorterp(background,digitColors[9],1-spread,false));
    drawString("."   ,500,-lineHeight/2,(t-        0)*letterSpeed-2,1-spread,100);
    drawString("."   ,500, lineHeight/2,(t-        1)*letterSpeed-2,1-spread,100);
    drawString("Kwan", 50,0,(t-Scene1len)*letterSpeed  ,spread,100);
    drawString(PI.substring(2  ),650+200*spread,(-1+(spread*spread))*lineHeight/2,(t-0)*letterSpeed-2,1-spread,100*(1+spread));
    drawString(E .substring(2  ),650+300*spread,( 1-(spread*spread))*lineHeight/2,(t-1)*letterSpeed-2,1-spread,100*(1+spread));
    drawString(PI.substring(0,2),450+  0*spread,(-1+(spread*spread))*lineHeight/2,(t-0)*letterSpeed-2,1       ,100*(1+spread));
    drawString(E .substring(0,2),450+100*spread,( 1-(spread*spread))*lineHeight/2,(t-1)*letterSpeed-2,1       ,100*(1+spread));
  }
  if(t>(Scene1len+Scene2len+Scene3len)) exit();
  saveFrame("kwan3217-#####.png");
}
                 
                 