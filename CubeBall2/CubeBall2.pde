float bound = 640;
float xCenter = bound/2;
float yCenter = bound/2;
float zTrans = -1000;
float xRes = 32;
PGraphics buffer;
boolean accumulate =true;
void setup()
{
  size((int)bound,(int)bound,P3D);
  background(0);
  buffer = createGraphics(width,height,P3D);
  noStroke();
}

void draw()
{
  buffer.beginDraw();
  if(accumulate==false)
  {
    buffer.background(0);
  }
  buffer.noStroke();
  buffer.lights();
  buffer.translate(xCenter,yCenter,zTrans);
  //buffer.rotateX(frameCount*PI/120);
  buffer.rotateY(frameCount*PI/120);
  buffer.rotateZ(frameCount*PI/120);
  float yRes = xRes/2;  
  float thStep = 1.0/yRes;
  float phStep = 1.0/xRes;
  
  for(float th=0;th<=1;th+=thStep)
  {
    for(float ph=0;ph<=1;ph+=phStep)
    {
      float z = 2*th-1.0;
      float t = 2.0*PI*ph;
      float r = sqrt(1.0-(z*z));
      float x = r*sin(t);
      float y = r*cos(t);
      buffer.pushMatrix();
      buffer.translate(x*bound,y*bound,z*bound);
      float cr = map(x,-1,1,0,255);
      float cb = map(y,-1,1,0,255);
      buffer.fill(cr,128,cb);
      buffer.box(50,50,50);
      buffer.popMatrix();
    }
  }
  buffer.endDraw();
  image(buffer,0,0,width,height);
  if(accumulate)
  {
    buffer.beginDraw();    
    buffer.fill(0,16);
    buffer.rect(0,0,width,height);
    buffer.endDraw();    
  }
}

void keyPressed()
{
  if(key=='q')
    xRes+=2;
  if(key=='a')
    xRes-=2;
  if(key=='w')
    zTrans-=10;
  if(key=='s')
    zTrans+=10;
  if(keyCode==UP)
    --yCenter;
  if(keyCode==DOWN)
    ++yCenter;
  if(keyCode==RIGHT)
    ++xCenter;
  if(keyCode==LEFT)
    --xCenter;
}
