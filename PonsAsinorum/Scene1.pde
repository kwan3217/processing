class Scene1 extends ElementLayerScene {
  Point A,B,C,F,G;
  Point AL,BL,CL,FL,GL;
  Point AR,BR,CR,FR,GR;
  Segment AB,CA,BC,BF,CG,CF,BG;
  Segment CFL,ABL,ACL;
  Segment BGR,ABR,ACR;
  Segment BFL,CGR;
  Segment BCL,BCR;
  Angle ABCL,BACL,BACR,AFCL,ABGL,AGBR,ACFL,ABGR,ACFR,CBGL;
  Angle BAC,AFC,AGB,ACF,ABG;
  Angle BCF,CBG,BCFL,CBGR;
  Angle ACBR,BCFR;
  Line lAB,lAC;
  Text[] PointLabel=new Text[5];
  Text[] step=new Text[20];
  float sceneTime() {return 130;}
  Scene1() {
    A=(Point)add(new Point(width*0.7,height*0.2));PointLabel[0]=new Text(A,#ff0000,"A",LEFT,BASELINE, true);A.label=PointLabel[0];
    B=(Point)add(new Point(width*0.6,height*0.6));PointLabel[1]=new Text(B,#FF8000,"B",RIGHT,BASELINE, true);B.label=PointLabel[1];  
    C=(Point)add(new Point(width*0.8,height*0.6));PointLabel[2]=new Text(C,#FF8000,"C",LEFT,BASELINE, true);C.label=PointLabel[2];
    F=(Point)add(new Point(A,B,1.3));PointLabel[3]=new Text(F,#000000,"F",RIGHT,BASELINE, true);F.label=PointLabel[3];
    G=(Point)add(new Point(A,C,1.3));PointLabel[4]=new Text(G,#000000,"G",LEFT,BASELINE, true);G.label=PointLabel[4];
    AL=(Point)add(new Point(A.x,A.y));
    BL=(Point)add(new Point(B.x,B.y));
    CL=(Point)add(new Point(C.x,C.y));
    FL=(Point)add(new Point(F.x,F.y));
    GL=(Point)add(new Point(G.x,G.y));
    AR=(Point)add(new Point(A.x,A.y));
    BR=(Point)add(new Point(B.x,B.y));
    CR=(Point)add(new Point(C.x,C.y));
    FR=(Point)add(new Point(F.x,F.y));
    GR=(Point)add(new Point(G.x,G.y));
    lAB=(Line)add(new Line(A,B,#404040));
    lAC=(Line)add(new Line(A,C,#404040));
    ABCL=(Angle)add(new Angle(AL,BL,CL,#000000));
    ACBR=(Angle)add(new Angle(AR,CR,BR,#000000));
    BACL=(Angle)add(new Angle(BL,AL,CL,#ffffff));
    BACR=(Angle)add(new Angle(BR,AR,CR,#ffffff));
    AFCL=(Angle)add(new Angle(AL,FL,CL,#00ff00));
    AGBR=(Angle)add(new Angle(AR,GR,BR,#00ff00));
    ACFL=(Angle)add(new Angle(AL,CL,FL,#ff8000));
    ACFR=(Angle)add(new Angle(AR,CR,FR,#ff8000));
    ABGR=(Angle)add(new Angle(AR,BR,GR,#ff8000));
    ABGL=(Angle)add(new Angle(AL,BL,GL,#ff8000));
    BCFL=(Angle)add(new Angle(BL,CL,FL,#ff00ff));
    BCFR=(Angle)add(new Angle(BR,CR,FR,#ff00ff));
    CBGL=(Angle)add(new Angle(CL,BL,GL,#ff00ff));
    CBGR=(Angle)add(new Angle(CR,BR,GR,#ff00ff));
    BCF=(Angle)add(new Angle(B,C,F,#ff00ff));
    CBG=(Angle)add(new Angle(C,B,G,#ff00ff));
    BAC=(Angle)add(new Angle(B,A,C,#ffffff));
    AFC=(Angle)add(new Angle(A,F,C,#00ff00));
    AGB=(Angle)add(new Angle(A,G,B,#00ff00));
    ACF=(Angle)add(new Angle(A,C,F,#ff8000));
    ABG=(Angle)add(new Angle(A,B,G,#ff8000));
    AB=(Segment)add(new Segment(A,B,#FF0000));
    CA=(Segment)add(new Segment(C,A,#FF0000));
    BC=(Segment)add(new Segment(B,C,#000000));
    BF=(Segment)add(new Segment(B,F,#FFFF00));
    CG=(Segment)add(new Segment(C,G,#FFFF00));
    CF=(Segment)add(new Segment(C,F,#000000));
    BG=(Segment)add(new Segment(B,G,#000000));
    ABL=(Segment)add(new Segment(AL,BL,AB.kolor));
    ACL=(Segment)add(new Segment(AL,CL,CA.kolor));
    ABR=(Segment)add(new Segment(AR,BR,AB.kolor));
    ACR=(Segment)add(new Segment(AR,CR,CA.kolor));
    BGR=(Segment)add(new Segment(BR,GR,BG.kolor));
    CFL=(Segment)add(new Segment(CL,FL,CF.kolor));
    BFL=(Segment)add(new Segment(BL,FL,BF.kolor));
    CGR=(Segment)add(new Segment(CR,GR,CG.kolor));
    BCL=(Segment)add(new Segment(BL,CL,BC.kolor));
    BCR=(Segment)add(new Segment(BR,CR,BC.kolor));
    step[ 0]=new Text(100,100,700,#000000,"Draw a triangle ABC with sides AB and AC equal. Two sides are equal, but are two angles?",LEFT,BASELINE,false);
    step[ 1]=new Text(100,150,700,#000000,"Pick a point F on the line through AB some distance past B, and draw segment BF.",LEFT,BASELINE,false);
    step[ 2]=new Text(100,200,700,#000000,"Find the point G on the line through AC such that the length of CG is the same as the length of BF.",LEFT,BASELINE,false);
    step[ 3]=new Text(100,250,700,#000000,"Complete two more triangles AFC and AGB by drawing sides CF and BG.",LEFT,BASELINE,false);
    step[ 4]=new Text(100,300,700,#000000,"Since AF is the combination of AB and BF...",LEFT,BASELINE,false);
    step[ 5]=new Text(100,450,700,#000000,"...it is congruent to AG, which is the combination of AC and CG.",LEFT,BASELINE,false);
    step[ 6]=new Text(width*0.7,  0,width*0.9,#000000,"Triangles AFC and AGB have angle A in common, and corresponding sides AF and AG are congruent, as are AB and AC.",CENTER,CENTER,false);
    step[ 7]=new Text(width*0.7,  0,width*0.9,#000000,"Therefore by the SAS axiom, all the remaining parts of the triangles are congruent.",CENTER,CENTER,false);
    step[ 8]=new Text(width*0.7,  0,width*0.9,#000000,"Now consider the triangles BFC and CGB",CENTER,CENTER,false);
    step[ 9]=new Text(width*0.7,  0,width*0.9,#000000,"We have already proven angles AFC and AGB to be congruent, as well as sides BG and CF. Sides BF and CG are congruent by construction.",CENTER,CENTER,false);
    step[10]=new Text(width*0.7,150,width*0.9,#000000,"Therefore by the SAS axiom, all the remaining parts are congruent.",CENTER,CENTER,false);
    step[11]=new Text(width*0.7,  0,width*0.95,#000000,"On the left side, angle ABC combines with angle CBG to make angle ABG.",CENTER,CENTER,false);
    step[12]=new Text(width*0.7, 75,width*0.95,#000000,"On the right side, angle ACB combines with angle BCF to make angle ACF.",CENTER,CENTER,false);
    step[13]=new Text(width*0.7,100,width*0.9,#000000,"On each side, you start with equal angles, and subtract equal angles.",CENTER,CENTER,false);
    step[14]=new Text(width*0.7,100,width*0.9,#000000,"Therefore the parts that are left must be equal.",CENTER,CENTER,false);
    step[15]=new Text(width*0.7,150,width*0.9,#ff0000,"Therefore there are two equal angles in an isocoles triangle.",CENTER,CENTER,false);
    step[16]=new Text(100,100,700,#000000,"This proof has come to be known as the 'Pons Asinorum', the bridge of donkeys. It is said to separate the men from the boys, the serious from the dalliers.",LEFT,BASELINE,false);
    step[17]=new Text(100,600,800,#000000,"Nowadays we would call it a 'weedout' course",LEFT,BASELINE,false);
    step[18]=new Text(100,300,800,#000000,"If it seems unnecessarily complicated, that's because it is.",LEFT,BASELINE,false);
    step[19]=new Text(100,600,800,#000000,"Let's try it a different way.",LEFT,BASELINE,false);
    for(Element E:step){
      add(E);
    }

    lAB.addFade(10,11,12,13);
    //This will draw under the triangle during construction of CE
    lAC.addFade(15,16,17,18);
    //Draw the triangle
    A.addFade(0,0.3);
    B.addFade(0.3,0.6);
    AB.addFade(0,1);
    C.addFade(1.0,1.3);
    BC.addFade(1,2);
    CA.addFade(2,3);
    step[0].addFade(0,0.5,9.5,10.0);
    //Draw segment BD
    float fadetime=120;
    BF.addFade(11,12,fadetime,fadetime+1);fadetime+=0.5;
    F.addFade(11,11.5,fadetime,fadetime+1);fadetime+=0.5;
    step[1].addFade(10,10.5,14.5,15);
    //Draw segment CE
    CG.addFade(16,17,fadetime,fadetime+1);fadetime+=0.5;
    G.addFade(16,16.5,fadetime,fadetime+1);fadetime+=0.5;
    step[2].addFade(15,15.5,19.5,20);
    //Draw two new triangles
    CF.addFade(20,21,fadetime,fadetime+1);fadetime+=0.5;
    CFL.addFlash(21,21,22,23);
    ABL.addFlash(21,21,22,23);
    BFL.addFlash(21,21,22,23);
    ACL.addFlash(21,21,22,23);
    BG.addFade(23,24,fadetime,fadetime+1);fadetime+=0.5;
    BGR.addFlash(24,24,25,26);
    ACR.addFlash(24,24,25,26);
    CGR.addFlash(24,24,25,26);
    ABR.addFlash(24,24,25,26);
    step[3].addFade(20,20.5,27.5,28);
    //Show that AD and AE are congruent
    step[4].addFade(28,28.5,44.5,45);
    ABL.addFlash(28,28,29,30);
    BFL.addFlash(30,30,31,32);
    ABL.addFlash(32,32,33,34);
    BFL.addFlash(32,32,33,34);
    step[5].addFade(35,35.5,44.5,45);
    ACR.addFlash(35,35,36,37);
    CGR.addFlash(37,37,38,39);
    ACR.addFlash(39,39,40,41);
    CGR.addFlash(39,39,40,41);
    //Show tht ADC and AEB are congruent
    step[6].addFade(48,48.5,58,58.5);
    //Draw the outside triangles
    ABL.addFade(48,48,67,68);
    ACL.addFade(48,48,67,68);
    BFL.addFade(48,48,67,68);
    CFL.addFade(48,48,67,68);
    ABR.addFade(48,48,67,68);
    ACR.addFade(48,48,67,68);
    BGR.addFade(48,48,67,68);
    CGR.addFade(48,48,67,68);
    //Show the corresponding parts
    BACL.addFade(51,51,52,53);
    BACR.addFade(51,51,52,53);
    BAC.addFade(51,51,52,53);
    ABL.addFlash(53,53,54,55);
    //BFL.addflash(53,53,54,55);
    //ACR.addflash(53,53,54,55);
    //CGR.addflash(53,53,54,55);
    //ACL.addflash(55,55,56,57);
    //ABR.addflash(55,55,56,57);
    //Show the other parts as congruent
    step[7].addFade(59,59.5,69.5,70);
    CFL.addFlash(60,60,61,62);
    BG.addFlash(60,60,61,62);
    CF.addFlash(60,60,61,62);
    BG.addFlash(60,60,61,62);
    AGBR.addFade(62,62,63,64);
    AFCL.addFade(62,62,63,64);
    ABGR.addFade(64,64,65,66);
    ACFL.addFade(64,64,65,66);
    AGB.addFade(62,62,fadetime,fadetime+1);fadetime+=0.5;
    AFC.addFade(62,62,fadetime,fadetime+1);fadetime+=0.5;
    ABG.addFade(64,64,fadetime,fadetime+1);fadetime+=0.5;
    ACF.addFade(64,64,fadetime,fadetime+1);fadetime+=0.5;
    //Show off the small triangles
    step[8].addFade(70,70.5,74.5,75);
    BFL.addFade(70,70,84,85);
    BCL.addFade(70,70,84,85);
    CFL.addFade(70,70,84,85);
    CGR.addFade(70,70,84,85);
    BGR.addFade(70,70,84,85);
    BCR.addFade(70,70,84,85);
    AFCL.addFade(70,70,84,85);
    AGBR.addFade(70,70,84,85);
    step[9].addFade(75,75.5,84.5,85);
    step[10].addFade(80,80.5,84.5,85);
    BCFL.addFade(81,81,82,83);
    CBGR.addFade(81,81,82,83);
    BCF.addFade(81,81,fadetime,fadetime+1);fadetime+=0.5;
    CBG.addFade(81,81,fadetime,fadetime+1);fadetime+=1.5;
    //Show the three angles on the left
    step[11].addFade(85,85.5,94.5,95);
    ABCL.addFade(85,86,fadetime,fadetime+1);fadetime+=0.5; //0,0
    CBGL.addFade(86,87,96,97);                             //0,5
    ABGL.addFade(87,88,97,98);                             //-10,7.5
    step[12].addFade(90,90.5,94.5,95);
    ACBR.addFade(90,91,fadetime,fadetime+1);fadetime+=0.5; //0,0
    BCFR.addFade(91,92,96,97);                             //0,5
    ACFR.addFade(92,93,97,98);                             //10,7.5
    //Subtract the two known equal angles
    step[13].addFade(95,95.5,99.5,100);
  
    step[14].addFade(100,100.5,109.5,110);
    step[15].addFade(103,103.5,109.5,110);
    //Talk about why it is called what it is called.
    step[16].addFade(110,110.5,119.5,120);
    step[17].addFade(115,115.5,119.5,120);
    step[18].addFade(120,120.5,129.5,130);
    step[19].addFade(125,125.5,129.5,130);

  }
  void adjust(float t) {
    float MoveT0=45;
    float MoveT1=48;
    float MoveT2=108;
    float MoveT3=111;
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
      GL.x=G.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
  
      AR.x=A.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      BR.x=B.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      CR.x=C.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      FR.x=F.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      GR.x=G.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    } else if(t<MoveTri1T2) {
      //Leave triangles out
      AL.x=A.x-width*0.3;
      BL.x=B.x-width*0.3;
      CL.x=C.x-width*0.3;
      FL.x=F.x-width*0.3;
      GL.x=G.x-width*0.3;
  
      AR.x=A.x+width*0.3;
      BR.x=B.x+width*0.3;
      CR.x=C.x+width*0.3;
      FR.x=F.x+width*0.3;
      GR.x=G.x+width*0.3;
    } else if(t<MoveTri1T3) {
      //move triangles back
      AL.x=A.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      BL.x=B.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      CL.x=C.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      FL.x=F.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      GL.x=G.x-linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
  
      AR.x=A.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      BR.x=B.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      CR.x=C.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      FR.x=F.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
      GR.x=G.x+linterp(MoveTri1T3,0,MoveTri1T2,width*0.3,t);
    } else {
    }
    //These ranges don't overlap, and both if/then chains do nothing if
    //they are outside their ranges, so it is ok to reuse the variables.
    MoveTri1T0=70;
    MoveTri1T1=72;
    MoveTri1T2=85;
    MoveTri1T3=85;
    
    if(t<MoveTri1T0) {
    } else if(t<MoveTri1T1) {
      //Move triangles out
      AL.x=A.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      BL.x=B.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      CL.x=C.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      FL.x=F.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      GL.x=G.x-linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
  
      AR.x=A.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      BR.x=B.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      CR.x=C.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      FR.x=F.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
      GR.x=G.x+linterp(MoveTri1T0,0,MoveTri1T1,width*0.3,t);
    } else if(t<MoveTri1T2) {
      //Leave triangles out
      AL.x=A.x-width*0.3;
      BL.x=B.x-width*0.3;
      CL.x=C.x-width*0.3;
      FL.x=F.x-width*0.3;
      GL.x=G.x-width*0.3;
  
      AR.x=A.x+width*0.3;
      BR.x=B.x+width*0.3;
      CR.x=C.x+width*0.3;
      FR.x=F.x+width*0.3;
      GR.x=G.x+width*0.3;
    } else if(t<MoveTri1T3) {
      //move triangles back
      AL.x=A.x-linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      BL.x=B.x-linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      CL.x=C.x-linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      FL.x=F.x-linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      GL.x=G.x-linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
  
      AR.x=A.x+linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      BR.x=B.x+linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      CR.x=C.x+linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      FR.x=F.x+linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
      GR.x=G.x+linterp(MoveTri1T3,width*0.15,MoveTri1T2,width*0.3,t);
    } else {
      //Leave triangles out
      AL.x=A.x-width*0.15;
      BL.x=B.x-width*0.15;
      CL.x=C.x-width*0.15;
      FL.x=F.x-width*0.15;
      GL.x=G.x-width*0.15;
  
      AR.x=A.x+width*0.15;
      BR.x=B.x+width*0.15;
      CR.x=C.x+width*0.15;
      FR.x=F.x+width*0.15;
      GR.x=G.x+width*0.15;
    }
    MoveTri1T0=102;
    MoveTri1T1=105;
    
    if(t<MoveTri1T0) {
    } else if(t<MoveTri1T1) {
      //Move angles in
      AL.x=A.x-linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      BL.x=B.x-linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      CL.x=C.x-linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      FL.x=F.x-linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      GL.x=G.x-linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
  
      AR.x=A.x+linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      BR.x=B.x+linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      CR.x=C.x+linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      FR.x=F.x+linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
      GR.x=G.x+linterp(MoveTri1T0,width*0.15,MoveTri1T1,0,t);
    } else {
      //Leave angles in
      AL.x=A.x;
      BL.x=B.x;
      CL.x=C.x;
      FL.x=F.x;
      GL.x=G.x;
  
      AR.x=A.x;
      BR.x=B.x;
      CR.x=C.x;
      FR.x=F.x;
      GR.x=G.x;
    }
    if(t>60) {
      CFL.kolor=#0000ff;
      BGR.kolor=#0000ff;
      CF.kolor=#0000ff;
      BG.kolor=#0000ff;
    }
    //Show the remaining angles to be congruent
    if(t>100 && t<102) {
      ABCL.kolor=color(linterp(100,0,102,255,t));
      ACBR.kolor=color(linterp(100,0,102,255,t));
    } else if(t>102) {
      ABCL.kolor=color(#ffffff);
      ACBR.kolor=color(#ffffff);
    }
  }
}
