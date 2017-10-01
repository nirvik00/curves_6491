void setup(){
    size(500,500);
}
void draw(){
    float x0=10, y0=40, x1=40, y1=10;
    float x2=40, y2=10, x3=70, y3=40;
    line(x0,y0,x1,y1);
    line(x2,y2,x3,y3);
    
    vec V=V(P(x0,y0),P(x1,y1));
    vec rV=R(V);  
    pt M=P((x0+x1)/2, (y0+y1)/2);
    pt Q=new pt(M.x, M.y).add(rV);
    line(M.x,M.y,Q.x,Q.y);
    
    vec U=V(P(x2,y2),P(x3,y3));
    vec rU=R(U);
    pt N=P((x2+x3)/2,(y2+y3)/2);
    pt R=new pt(N.x,N.y).add(rU);
    line(N.x,N.y,R.x,R.y);  
    findInterX(M,Q,N,R);
}

void findInterX(pt A, pt B, pt C, pt D ){
   float x0=A.x, y0=A.y, x2=C.x, y2=C.y;
   vec V=V(A,B), U=V(C,D);
   float mu=(((y2-y0)/V.y)-((x2-x0)/V.x))/((U.x/V.x)-(U.y/V.y));
   float x=x2+(mu*U.x);
   float y=y2+(mu*U.y);
   ellipse(x,y,5,5);
}

void mousePressed(){
    float x0=100, y0=100, x1=400, y1=400;
    float vx=x1-x0, vy=y1-y0;
    float x2=x0-vy, y2=y0+vx;
    line(x0,y0,x1,y1);
    println(x2,y2);
    line(x0,y0,x2,y2);
}