class Scene1 implements Scene {
  Point A,B,C,F,G;
  Point AL,BL,CL,FL,GL;
  Point AR,BR,CR,FR,GR;
  Segment AB,CA,BC,BF,CG,CF,BG;
  Segment AFLflash,CFLflash,ABLflash,ACLflash;
  Segment AGRflash,BGRflash,ABRflash,ACRflash;
  Segment BFLflash,CGRflash;
  Segment BGflash,CFflash;
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
    A=new Point(width*0.7,height*0.2);PointLabel[0]=new Text(A,#ff0000,"A",LEFT,BASELINE, true);A.label=PointLabel[0];
    B=new Point(width*0.6,height*0.6);PointLabel[1]=new Text(B,#FF8000,"B",RIGHT,BASELINE, true);B.label=PointLabel[1];  
    C=new Point(width*0.8,height*0.6);PointLabel[2]=new Text(C,#FF8000,"C",LEFT,BASELINE, true);C.label=PointLabel[2];
    F=new Point(A,B,1.3);PointLabel[3]=new Text(F,#000000,"F",RIGHT,BASELINE, true);F.label=PointLabel[3];
    G=new Point(A,C,1.3);PointLabel[4]=new Text(G,#000000,"G",LEFT,BASELINE, true);G.label=PointLabel[4];
    AL=new Point(A.x,A.y);
    BL=new Point(B.x,B.y);
    CL=new Point(C.x,C.y);
    FL=new Point(F.x,F.y);
    GL=new Point(G.x,G.y);
    AR=new Point(A.x,A.y);
    BR=new Point(B.x,B.y);
    CR=new Point(C.x,C.y);
    FR=new Point(F.x,F.y);
    GR=new Point(G.x,G.y);
    ABCL=new Angle(AL,BL,CL,#000000);
    ACBR=new Angle(AR,CR,BR,#000000);
    BACL=new Angle(BL,AL,CL,#ffffff);
    BACR=new Angle(BR,AR,CR,#ffffff);
    AFCL=new Angle(AL,FL,CL,#00ff00);
    AGBR=new Angle(AR,GR,BR,#00ff00);
    ACFL=new Angle(AL,CL,FL,#ff8000);
    ACFR=new Angle(AR,CR,FR,#ff8000);
    ABGR=new Angle(AR,BR,GR,#ff8000);
    ABGL=new Angle(AL,BL,GL,#ff8000);
    BCFL=new Angle(BL,CL,FL,#ff00ff);
    BCFR=new Angle(BR,CR,FR,#ff00ff);
    CBGL=new Angle(CL,BL,GL,#ff00ff);
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
  }
  void draw(float t) {
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
    float fadetime=120;
    BF.draw(11,12,fadetime,fadetime+1,t);fadetime+=0.5;
    F.draw(11,11.5,fadetime,fadetime+1,t);fadetime+=0.5;
    step[1].draw(10,10.5,14.5,15,t);
    //Draw segment CE
    CG.draw(16,17,fadetime,fadetime+1,t);fadetime+=0.5;
    G.draw(16,16.5,fadetime,fadetime+1,t);fadetime+=0.5;
    step[2].draw(15,15.5,19.5,20,t);
    //Draw two new triangles
    CF.draw(20,21,fadetime,fadetime+1,t);fadetime+=0.5;
    CFLflash.draw(21,21,22,23,t);
    AFLflash.draw(21,21,22,23,t);
    ACLflash.draw(21,21,22,23,t);
    BG.draw(23,24,fadetime,fadetime+1,t);fadetime+=0.5;
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
    AGB.draw(62,62,fadetime,fadetime+1,t);fadetime+=0.5;
    AFC.draw(62,62,fadetime,fadetime+1,t);fadetime+=0.5;
    ABG.draw(64,64,fadetime,fadetime+1,t);fadetime+=0.5;
    ACF.draw(64,64,fadetime,fadetime+1,t);fadetime+=0.5;
    //Show off the small triangles
    step[8].draw(70,70.5,74.5,75,t);
    BFL.draw(70,70,84,85,t);
    BCL.draw(70,70,84,85,t);
    CFL.draw(70,70,84,85,t);
    CGR.draw(70,70,84,85,t);
    BGR.draw(70,70,84,85,t);
    BCR.draw(70,70,84,85,t);
    AFCL.draw(70,70,84,85,t);
    AGBR.draw(70,70,84,85,t);
    step[9].draw(75,75.5,84.5,85,t);
    step[10].draw(80,80.5,84.5,85,t);
    BCFL.draw(81,81,82,83,t);
    CBGR.draw(81,81,82,83,t);
    BCF.draw(81,81,fadetime,fadetime+1,t);fadetime+=0.5;
    CBG.draw(81,81,fadetime,fadetime+1,t);fadetime+=1.5;
    //Show the three angles on the left
    step[11].draw(85,85.5,94.5,95,t);
    ABCL.draw(0,0,85,86,fadetime,fadetime+1,t);fadetime+=0.5;
    CBGL.draw(0,5,86,87,96,97,t);
    ABGL.draw(-10,7.5,87,88,97,98,t);
    step[12].draw(90,90.5,94.5,95,t);
    ACBR.draw(0,0,90,91,fadetime,fadetime+1,t);fadetime+=0.5;
    BCFR.draw(0,5,91,92,96,97,t);
    ACFR.draw(10,7.5,92,93,97,98,t);
    //Subtract the two known equal angles
    step[13].draw(95,95.5,99.5,100,t);
  
    //Show the remaining angles to be congruent
    if(t>100 && t<102) {
      ABCL.kolor=color(linterp(100,0,102,255,t));
      ACBR.kolor=color(linterp(100,0,102,255,t));
    } else if(t>102) {
      ABCL.kolor=color(#ffffff);
      ACBR.kolor=color(#ffffff);
    }
    step[14].draw(100,100.5,109.5,110,t);
    step[15].draw(103,103.5,109.5,110,t);
    //Talk about why it is called what it is called.
    step[16].draw(110,110.5,119.5,120,t);
    step[17].draw(115,115.5,119.5,120,t);
    step[18].draw(120,120.5,129.5,130,t);
    step[19].draw(125,125.5,129.5,130,t);
  }
}
