ArrayList<PVector> points;
float tr = 1;
/*
class Params
{
	int spawncount;
	int clearmode;
	boolean organic;
	
	Params()
	{
		this.spawncount=5;
		this.clearmode=3;
		this.organic=true;
	}
}
Params p5Params = new Params();
*/
void setup()
{
  size(640,640,JAVA2D);
  background(16);
  stroke(0);
  ellipseMode(RADIUS);
  smooth();
  
  points = new ArrayList();
}

void draw()
{
  switch(p5Params.clearmode)
  {
    case 'clear':
    {
      background(16);
      break;
    }
    case 'accumulate':
    {
      fill(0,8);
      rect(0,0,width,height);
      break;
    }
    case 'none':
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
    if(p5Params.organic)
      er = p.z*random(10,30);
    ellipse(p.x*(width/2),p.y*(height/2),er,er);
    popMatrix();
  }
}

void mousePressed()
{
  if(mouseButton==LEFT)
  {
	  for(int c=0;c<p5Params.spawncount;c++)
	  {
		float _z = 2.0*random(0,1)-1.0;
		float _t = 2.0*PI*random(0,1);
		float _r = sqrt(1.0-(_z*_z));
		
		points.add(new PVector(_r*cos(_t), _r*sin(_t), _z));
	  }
	  tr=-tr;
  }
  else
  {
	points.clear();
  }
}