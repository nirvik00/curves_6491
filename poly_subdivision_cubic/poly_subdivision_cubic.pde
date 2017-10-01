int ite=0;
boolean lock=false;
int locked_index;
pt locked_pt;

int click_counter=0;
pt A=new pt(200,400);
pt B=new pt(100,300);
pt C=new pt(250,50);
pt D=new pt(450,300);
pt E=new pt(425,400);
pt A_,B_,C_,D_;


ArrayList<pt>ptList;
ArrayList<pt>dupPtList;
ArrayList<pt>cubicPtList;

void setup(){
 size(500,500);
 ptList=new ArrayList<pt>();
 dupPtList=new ArrayList<pt>();
 cubicPtList=new ArrayList<pt>();
 ptList.add(A);
 ptList.add(B);
 ptList.add(C);
 ptList.add(D);
 ptList.add(E); 
 dupPtList.addAll(ptList);
 background(255);
}

void draw(){
  background(255);
  fill(0);
  if(click_counter<ite){
    click_counter++;
    cubicSubdivision();
  }
  drawInfo();
}

void drawInfo(){  
  fill(0);
  for(int i=0; i<dupPtList.size(); i++){
    pt P,Q;
    if(i<dupPtList.size()-1){
      P=dupPtList.get(i);
      Q=dupPtList.get(i+1);
    }else{
      P=dupPtList.get(i);
      Q=dupPtList.get(0);
    }
    stroke(0,0,0);
    strokeWeight(1);
    ellipse(P.x,P.y,10,10);
    //text(""+i,P.x-15,P.y-10);
    line(P.x,P.y,Q.x,Q.y);
  }
  
  for(int i=0; i<ptList.size(); i++){
    pt P,Q;
    if(i<ptList.size()-1){
      P=ptList.get(i);
      Q=ptList.get(i+1);
    }else{
      P=ptList.get(i);
      Q=ptList.get(0);
    }
    stroke(150,0,0);
    strokeWeight(2);
    line(P.x,P.y,Q.x,Q.y);
    //text(""+i, P.x-10, P.y-10);
  }
}

void cubicSubdivision(){
  ArrayList<pt>temp=new ArrayList<pt>();
  for(int i=0; i<ptList.size(); i++){
    pt P, Q;
    if(i<ptList.size()-1){
      P=ptList.get(i);
      Q=ptList.get(i+1); 
      println("split 1 : ", i, (i+1));
    }else{
      P=ptList.get(i);
      Q=ptList.get(0);
      println("split 2 : ", i, 0);
    }    
    temp.add(P);
    pt p=cubicSplit(P,Q);    
    temp.add(p); 
  }
  ptList.clear();
  ptList.addAll(temp);
  cubicAverage();
}

pt cubicSplit(pt P, pt Q){  
  float x=(P.x+Q.x)/2;
  float y=(P.y+Q.y)/2;
  pt a=new pt(x,y);
  return a;
}

void cubicAverage(){
 ArrayList<pt>temp=new ArrayList<pt>();
 for(int i=0; i<ptList.size(); i++){
   pt P,Q,R;
   if(i==0){
     P=ptList.get(ptList.size()-1);
     Q=ptList.get(0);
     R=ptList.get(1);
     println("avg 1 : ", (ptList.size()-1), 0, 1); 
   }else if(i>0 && i<ptList.size()-1){
     P=ptList.get(i-1);
     Q=ptList.get(i);
     R=ptList.get(i+1);
     println("avg 2 : ", (i-1), i, i+1);
   }else{
     P=ptList.get(i);
     Q=ptList.get(0);
     R=ptList.get(1);
     println("avg 3 : ", (i), 0, 1);
   }
   float d=dis(P,R);
   vec rPR=S(2,U(R(V(P,R))));
   pt s;
   if(i<ptList.size()-1){
     s=cubicSplit(Q,R);
   }else{
     s=cubicSplit(P,Q);
   }
   s.add(rPR);
   temp.add(s);   
 }
 ptList.clear();
 ptList.addAll(temp);
}

void mousePressed(){
  float x=mouseX;
  float y=mouseY;
  float r=50;
  for(int i=0; i<dupPtList.size(); i++){
    pt p0=dupPtList.get(i);
  if(dis(x,y,p0.x,p0.y)<25){
      lock=true;
      locked_pt=p0;
      locked_index=i;
    }
  }
}

public void mouseDragged(){
  if(lock==true){
    pt P=dupPtList.get(locked_index);
    P.x=(mouseX);
    P.y=(mouseY);
  }
  ptList.clear();
  ptList.addAll(dupPtList);
  click_counter=0;
}

public void keyPressed(){
  if(key=='a'){
    ite++;
  }else if(key=='s'){
    ite--;
  }
}

public float dis(float x, float y, float a, float b){
  float d=sqrt(sq(x-a) + sq(y-b));
  return d;
}

public float dis(pt P, pt Q){
  float d=sqrt(sq(P.x-Q.x) + sq(P.y-Q.y));
  return d;
}