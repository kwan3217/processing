int background=#c0c0c0;
                   
float desiredFrameRate=24;

Scene s;

int shadowColor=#808080;
float xshadow=10;
float yshadow=10;
boolean save=false;

void setup() {
  //size(1920,1080,P2D);
  fullScreen(P2D);
  frameRate(1000/*desiredFrameRate*/);
  s=new SceneArray(new Scene[]{new Scene1()});
}

void draw() {
  background(#c0e0ff);
  float t=frameCount/desiredFrameRate;//+100;
  if(t>=s.sceneTime()) {
    print(float(millis())/1000);
    exit();
  }
  s.draw(t);
  if(save) {
    saveFrame("PonsAsinorium-#####.png");
  }
}
                 
                 
