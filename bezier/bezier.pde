
float Ax=100, Ay=400, Bx=250, By=100, Cx=450, Cy=300;
pt A=new pt(Ax,Ay);
pt B=new pt(Bx,By);
pt C=new pt(Cx,Cy);
vec AB= V(A,B);
vec BA= V(B,A);
vec BC= V(B,C);

pt P=new pt(A.x, A.y);
float e=0.001;

vec vel=S(2,AB);
vec acc=S(2,BA.add(BC));
vec D=S(e,vel).add(S(sq(e)/2,acc));
vec W=S(e,acc);
  
void setup(){
  size(500,500);
}
void draw(){
  background(255);
  line(Ax,Ay,Bx,By);
  line(Cx,Cy,Bx,By);  
  update();
}
void mousePressed(){   
}

void update(){
  println(vel.x, vel.y);  
  ellipse(P.x,P.y,5,5);
  vel.add(acc);
  P.add(D);
  e+=e/2;
}