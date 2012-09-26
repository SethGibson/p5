class Params
{
  boolean organic = false;
  boolean accumulate = true;
  int bugs = 100; 
  float xDivisor = 111;
  float yDivisor = 29;
}

float xterm = 0;
float yterm = 0;
//float[] a;
//float[] r;
//float[] s;

void setup()
{
  size(640,640);
  background(16);
  stroke(16);
  a = new float[pts];
  r = new float[pts];
  s = new float[pts];
  ellipseMode(RADIUS);
  for(int i=0;i<pts;i++)
  {
    a[i] = random(0,width/2);
    r[i] = random(5,15);
    s[i] = random(0,2);
  }
}

void draw()
{
  fill(0,8);
  rect(0,0,width,height);
  for(int i=0;i<pts;i++)
  {
    float x0 = (a[i]*sin(frameCount*PI/xdend*s[i]))*xterm+width/2;
    float y0 = (a[i]*cos(frameCount*PI/ydend*s[i]))*yterm+height/2;
    float rt = map(x0,0,width,0,255);
    float bt = map(y0,0,height,0,255);
    float rad = r[i];
    if(organic)
      rad = random(2,r[i]);
    fill(rt,128,bt);
    ellipse(x0,y0,rad,rad);
  }  
}

void mouseDragged()
{
  xterm = map((mouseX-width/2),0,width/2,0,1);
  yterm = map((mouseY-height/2),0,height/2,0,1);
}
