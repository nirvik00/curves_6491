void setup(){
  size(550,500);
}
void draw(){
  //background(255);
}

void mousePressed(){
  update();
}

void update(){
  background(255);
  fill(0);
  
  pt P0=new pt(250,250);  
  pt P1=new pt(350,250);
  pt P2=new pt(450,100);  
  pt P3=new pt(450,400);
  
  vec V01=V(P0,P1);
  vec V12=V(P1,P2);
  vec rV12=R(V(P1,P2));
  vec V13=V(P1,P3);
  vec rV13=R(V(P1,P3));
  
  float d0=det(V01,V12);
  float d1=det(V01,V13);
  
  line(P0.x,P0.y,P1.x,P1.y);
  line(P1.x,P1.y,P2.x,P2.y);
  line(P1.x,P1.y,P3.x,P3.y);
  
  println(d0, d1);
  
  text("0",240,250);
  text("1",370,250);
  text("2",460,100);
  text("3",460,400);
  
}