ArrayList<pt> bezPtList;
ArrayList<pt> bez2PtList;
ArrayList<pt> nevPtList;
ArrayList<pt> ptList;
pt A=new pt(200,400);
pt B=new pt(100,300);
pt C=new pt(250,50);
pt D=new pt(450,100);
pt E=new pt(400,300);
pt F=new pt(300,350);


boolean lock=false;
int locked_index;
pt locked_pt;


float t=0.01;
void setup(){
  size(500,500);
  bezPtList=new ArrayList<pt>();
  bez2PtList=new ArrayList<pt>();
  nevPtList=new ArrayList<pt>();
  ptList=new ArrayList<pt>();
  locked_pt=A;
  ptList.add(A);
  ptList.add(B);
  ptList.add(C);
  ptList.add(D);
  ptList.add(E);
  ptList.add(F);
}
void draw(){
  background(255);
  fill(0);  
  for(int i=0; i<ptList.size(); i++){
    pt p0=ptList.get(i);
    fill(0);
    ellipse(p0.x,p0.y,10,10);
    noFill();    
    text("#"+i,p0.x,p0.y-15);
  }  
  if(locked_index>-1 && lock==true){
    float r=50;
    ellipse(locked_pt.x,locked_pt.y,r,r);
  }
  strokeWeight(3);
  line(A.x,A.y,B.x,B.y);
  line(C.x,C.y,B.x,B.y);
  line(E.x,E.y,F.x,F.y);
  quadBezier();
  doubleQuadBezier();
  neville();
}

public void quadBezier(){
  strokeWeight(1);
  bezPtList.clear();
  for(float i=0; i<=1+t; i+=t){
    pt Q=new pt(A.x,A.y).add(S(i,V(A,B)));
    pt R=new pt(B.x,B.y).add(S(i,V(B,C)));    
    pt F=new pt(Q.x,Q.y).add(S(i*d(Q,R),U(V(Q,R))));
    bezPtList.add(new pt(F.x,F.y));
  }
  genShape(bezPtList);
}

public void doubleQuadBezier(){  
  strokeWeight(1);
  bez2PtList.clear();
  for(float i=0; i<=1+t; i+=t){
    pt Q=new pt(A.x,A.y).add(S(i,V(A,B)));
    pt R=new pt(B.x,B.y).add(S(i/2,V(B,C)));  
    pt S=new pt(C.x,C.y).add(S(i,V(C,D)));
    pt F=new pt(Q.x,Q.y).add(S(i*d(Q,R),U(V(Q,R))));
    bez2PtList.add(new pt(F.x,F.y));
  }  
  genShape(bez2PtList);
}

public void neville(){
  strokeWeight(1);
  nevPtList.clear();
  for(float i=0; i<=1+t; i+=t){
    pt Q=new pt(A.x,A.y).add(S(i,V(A,B)));
    pt R=new pt(E.x,E.y).add(S(i,V(E,F)));    
    pt F=new pt(Q.x,Q.y).add(S(i*d(Q,R),U(V(Q,R))));
    nevPtList.add(new pt(F.x,F.y));
  }  
  genShape(nevPtList);
}

public void genShape(ArrayList<pt>pt_li){
    PShape ps;
  ps=createShape();
  ps.beginShape();
  for(int i=0; i<pt_li.size(); i++){
    pt P=pt_li.get(i);
    ps.vertex(P.x, P.y);
  }
  shape(ps);
  endShape();
}

void mousePressed(){
  float x=mouseX;
  float y=mouseY;
  float r=50;
  for(int i=0; i<ptList.size(); i++){
    pt p0=ptList.get(i);
  if(dis(x,y,p0.x,p0.y)<25){
      lock=true;
      locked_pt=p0;
      locked_index=i;
    }
  }
}

public void mouseDragged(){
  if(lock==true){
    pt P=ptList.get(locked_index);
    P.x=(mouseX);
    P.y=(mouseY);
  }
  //lock=false;
}

public double dis(float x, float y, float a, float b){
  double d=sqrt(sq(x-a) + sq(y-b));
  return d;
}