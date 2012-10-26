class Params
{
  boolean organic;
  boolean accumulate;
  int bugs; 
  float xDivisor;
  float yDivisor;
  
  Params()
  {
    this.organic = false;
    this.accumulate = true;
    this.bugs = 100;
    this.xDivisor = 2;
    this.yDivisor = 5;
  }
}
Params p5Params = new Params();

int count;
float xterm = 0;
float yterm = 0;
PVector[] swarm;

void setup()
{
  size(640,640,JAVA2D);
  background(16);
  stroke(16);
  swarm = new PVector[p5Params.bugs];
  count = p5Params.bugs;
  ellipseMode(RADIUS);
  for(int i=0;i<count;i++)
  {
    swarm[i] = new PVector(random(0,width/2), random(-1,1), random(5,15));    
  }
}

void draw()
{
  if(p5Params.accumulate)
  {
    fill(0,8);
    rect(0,0,width,height);
  }
  else
  {
    background(16);
  }
  for(int i=0;i<count;i++)
  {
    float rad = swarm[i].z;
    float spd = map(i,0,count,0.1,1);
    if(p5Params.organic)
    {
      rad = random(2,swarm[i].z);
      spd = swarm[i].y;
    }
    
    float x0 = (swarm[i].x*sin(frameCount*PI/120*p5Params.xDivisor*spd))*xterm+width/2;
    float y0 = (swarm[i].x*cos(frameCount*PI/120*p5Params.yDivisor*spd))*yterm+height/2;
    float rt = map(x0,0,width,0,255);
    float bt = map(y0,0,height,0,255);
    fill(rt,128,bt);
    ellipse(x0,y0,rad,rad);
  }  
}

void mouseDragged()
{
  xterm = map((mouseX-width/2),0,width/2,0,1);
  yterm = map((mouseY-height/2),0,height/2,0,1);
}
