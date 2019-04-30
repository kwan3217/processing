class Scene2 extends ElementLayerScene {
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
  Scene2() {
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
