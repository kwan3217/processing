int background=#c0c0c0;
                   
float desiredFrameRate=24;

Scene s[];


void setup() {
  //size(1920,1080,P2D);
  fullScreen(P2D);
  frameRate(1000);
  s=new Scene[]{new Scene1()};
}

void draw() {
  background(#c0e0ff);
  float t=frameCount/desiredFrameRate;//+100;
  float sceneT=0;
  boolean drawn=false;
  for(int i=0;i<s.length;i++) {
    if(t>=sceneT && t<sceneT+s[i].sceneTime()) {
      s[i].draw(t-sceneT);
      drawn=true;
    } else {
      sceneT+=s[i].sceneTime();
    }
  }
  if(!drawn) {
    print(float(millis())/1000);
    exit();
  }   
  //saveFrame("PonsAsinorium-#####.png");
}
                 
                 
