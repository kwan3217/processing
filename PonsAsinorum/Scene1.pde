class Scene1 extends ElementLayerScene {
  Point A,B,C,F,G;
  Segment AB,CA,BC,BF,CG,CF,BG;
  Line lAB,lAC;
  Text[] PointLabel=new Text[5];
  Text[] step=new Text[6];
  float sceneTime() {return 48;}
  Scene1() {
    A=(Point)add(new Point(width*0.7,height*0.2));PointLabel[0]=new Text(A,#ff0000,"A",LEFT,BASELINE, true);A.label=PointLabel[0];
    B=(Point)add(new Point(width*0.6,height*0.6));PointLabel[1]=new Text(B,#FF8000,"B",RIGHT,BASELINE, true);B.label=PointLabel[1];  
    C=(Point)add(new Point(width*0.8,height*0.6));PointLabel[2]=new Text(C,#FF8000,"C",LEFT,BASELINE, true);C.label=PointLabel[2];
    F=(Point)add(new Point(A,B,1.3));PointLabel[3]=new Text(F,#000000,"F",RIGHT,BASELINE, true);F.label=PointLabel[3];
    G=(Point)add(new Point(A,C,1.3));PointLabel[4]=new Text(G,#000000,"G",LEFT,BASELINE, true);G.label=PointLabel[4];
    lAB=(Line)add(new Line(A,B,#404040));
    lAC=(Line)add(new Line(A,C,#404040));
    AB=(Segment)add(new Segment(A,B,#FF0000));
    CA=(Segment)add(new Segment(C,A,#FF0000));
    BC=(Segment)add(new Segment(B,C,#000000));
    BF=(Segment)add(new Segment(B,F,#FFFF00));
    CG=(Segment)add(new Segment(C,G,#FFFF00));
    CF=(Segment)add(new Segment(C,F,#000000));
    BG=(Segment)add(new Segment(B,G,#000000));
    step[ 0]=new Text(100,100,700,#000000,"Draw a triangle ABC with sides AB and AC equal. Two sides are equal, but are two angles?",LEFT,BASELINE,false);
    step[ 1]=new Text(100,150,700,#000000,"Pick a point F on the line through AB some distance past B, and draw segment BF.",LEFT,BASELINE,false);
    step[ 2]=new Text(100,200,700,#000000,"Find the point G on the line through AC such that the length of CG is the same as the length of BF.",LEFT,BASELINE,false);
    step[ 3]=new Text(100,250,700,#000000,"Complete two more triangles AFC and AGB by drawing sides CF and BG.",LEFT,BASELINE,false);
    step[ 4]=new Text(100,300,700,#000000,"Since AF is the combination of AB and BF...",LEFT,BASELINE,false);
    step[ 5]=new Text(100,450,700,#000000,"...it is congruent to AG, which is the combination of AC and CG.",LEFT,BASELINE,false);
    for(Element E:step){
      add(E);
    }

    lAB.addFade(10,11,12,13);
    //This will draw under the triangle during construction of CE
    lAC.addFade(15,16,17,18);
    //Draw the triangle
    A.addFade(0,0.3);
    B.addFade(0.3,0.6);
    AB.addDraw(0,1);
    C.addFade(1.0,1.3);
    BC.addDraw(1,2);
    CA.addDraw(2,3);
    step[0].addFade(0,0.5,9.5,10.0);
    //Draw segment BD
    float fadetime=120;
    BF.addDraw(11,12);
    step[1].addFade(10,10.5,14.5,15);
    //Draw segment CE
    CG.addDraw(16,17);
    step[2].addFade(15,15.5,19.5,20);
    //Draw two new triangles
    CF.addDraw(20,21);
    CF.addFade(0,0,fadetime,fadetime+1);fadetime+=0.5;
    CF.addFlash(21,21,22,23);
    AB.addFlash(21,21,22,23);
    BF.addFlash(21,21,22,23);
    CA.addFlash(21,21,22,23);
    BG.addDraw(23,24);
    BG.addFade(0,0,fadetime,fadetime+1);fadetime+=0.5;
    BG.addFlash(24,24,25,26);
    CA.addFlash(24,24,25,26);
    CG.addFlash(24,24,25,26);
    AB.addFlash(24,24,25,26);
    step[3].addFade(20,20.5,27.5,28);
    //Show that AD and AE are congruent
    step[4].addFade(28,28.5,44.5,45);
    AB.addFlash(28,28,29,30);
    BF.addFlash(30,30,31,32);
    AB.addFlash(32,32,33,34);
    BF.addFlash(32,32,33,34);
    step[5].addFade(35,35.5,44.5,45);
    CA.addFlash(35,35,36,37);
    CG.addFlash(37,37,38,39);
    CA.addFlash(39,39,40,41);
    CG.addFlash(39,39,40,41);
  }
  void adjust(float t) {
    float MoveT0=45;
    float MoveT1=48;
    //Move to the center at the appropriate time
    if(t<MoveT0) {
    } else if(t<MoveT1) {
      translate(linterp(MoveT0,0,MoveT1,-width*0.2,t),linterp(MoveT0,0,MoveT1,height*0.1,t));
    }


  }
}
