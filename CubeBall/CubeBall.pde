float bound = 640;
float zTrans = -1000;
float xMul = bound;
float yMul = bound;
float zMul = bound;
float thStep = 0.1;
float phStep = 0.1;
void setup()
{
  size((int)bound,(int)bound,OPENGL);
}

void draw()
{
  background(0);
  lights();
  translate(width/2,height/2,zTrans);
  rotateX(frameCount*PI/120);
  rotateY(frameCount*PI/120);
  rotateZ(frameCount*PI/120);
  for(float th=-1;th<=1;th+=thStep)
  {
    for(float ph=0;ph<2*PI;ph+=phStep)
    {
      float x = cos(th)*cos(ph);
      float z = cos(th)*sin(ph);
      float y = sin(th);
      pushMatrix();
      translate(x*xMul,y*yMul,z*zMul);
      float r = map(x,-1,1,0,255);
      float b = map(y,-1,1,0,255);
      fill(r,128,b);
      box(50,50,50);
      popMatrix();
    }
  }
}

void keyPressed()
{
  if(key=='w')
    yMul+=10;
  if(key=='s')
    yMul-=10;
  if(key=='a')
    xMul-=10;
  if(key=='d')
    xMul+=10;
}
