/*
class Params
{
  int xResolution;
  boolean accumulate;
  boolean xRotate;
  boolean yRotate;
  boolean zRotate;
  
  Params()
  {
    this.xResolution=32;
    this.accumulate=true;
    this.xRotate=false;
    this.yRotate=true;
    this.zRotate=true;
  }
}
Params p5Params = new Params();
*/
float xCenter;
float yCenter;
float zTrans = -1000;
void setup()
{
  size(640,640,P3D);
  background(0xFF000000);
  noStroke();
  xCenter=yCenter=width/2;
}

void draw()
{
  if(p5Params.accumulate==false)
  {
    background(0xFF101010);
  }
  noStroke();
  lights();
  pushMatrix();
  translate(xCenter,yCenter,zTrans);
  if(p5Params.xRotate)
    rotateX(frameCount*PI/120);
  if(p5Params.yRotate)
    rotateY(frameCount*PI/120);
  if(p5Params.zRotate)
    rotateZ(frameCount*PI/120);
  float yRes = p5Params.xResolution/2;  
  float thStep = 1.0/yRes;
  float phStep = 1.0/p5Params.xResolution;
  
  for(float th=0;th<=1;th+=thStep)
  {
    for(float ph=0;ph<=1;ph+=phStep)
    {
      float z = 2*th-1.0;
      float t = 2.0*PI*ph;
      float r = sqrt(1.0-(z*z));
      float x = r*sin(t);
      float y = r*cos(t);
      pushMatrix();
      translate(x*width,y*width,z*width);
      float cr = map(x,-1,1,0,255);
      float cb = map(y,-1,1,0,255);
      fill(cr,128,cb);
      box(50,50,50);
      popMatrix();
    }
  }
  popMatrix();
  if(p5Params.accumulate)
  {
    fill(0x08000000);
    rect(0,0,width,height);
  }
  
}
