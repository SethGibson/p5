int PER_CLICK = 5;
int bgmode = 3;
boolean organic = true;
ArrayList<PVector> points;
float tr = 1;
void setup()
{
  size(800,800,P2D);
  background(0);
  stroke(0);
  ellipseMode(RADIUS);
  smooth();
  
  points = new ArrayList();
}

void draw()
{
  switch(bgmode)
  {
    case 1:
    {
      background(0);
      break;
    }
    case 2:
    {
      fill(0,8);
      rect(0,0,width,height);
      break;
    }
    case 3:
    {
      break;
    }
  }
  for(int i=0;i<points.size();i++)
  {
    PVector p = (PVector)points.get(i);
    pushMatrix();
    translate(width/2,height/2);
    rotate((frameCount*tr)*PI/60);
    float r = map(p.x,-1,1,0,255);
    float b = map(p.y,-1,1,0,255);
    
    fill(r,128,b);
    float er = p.z*30;
    if(organic)
      er = p.z*random(10,30);
    ellipse(p.x*(width/2),p.y*(height/2),er,er);
    popMatrix();
  }
}

void mousePressed()
{
  for(int c=0;c<PER_CLICK;c++)
  {
    float _z = 2.0*random(0,1)-1.0;
    float _t = 2.0*PI*random(0,1);
    float _r = sqrt(1.0-(_z*_z));
    
    points.add(new PVector(_r*cos(_t), _r*sin(_t), _z));
  }
  tr=-tr;
}

void keyPressed()
{
  if(key=='1')
  {
    bgmode=1;
  }
  else if(key=='2')
  {
    bgmode=2;
  }
  else if(key=='3')
  {
    bgmode=3;
  }
  else
  {
    points.clear();
  }
}
