class boxy
{
  float b;
  float a;
  float st;
  color c;
  
  boxy(){}
  boxy(float b, float a, float st, color c)
  {
    this.b=b;
    this.a=a;
    this.st=st;
    this.c=c;
  }
}

int numCubes = 1500;
boxy[] boxes = new boxy[numCubes];
/*
class Params
{
	boolean wireframe;
	boolean rotateX;
	boolean rotateY;
	boolean rotateZ;
	float divideX;
	float divideY;
	float divideZ;
	
	Params()
	{
		this.wireframe=false;
		this.rotateX=true;
		this.rotateY=true;
		this.rotateZ=true;	
		this.divideX=4;
		this.divideY=3;
		this.divideZ=2;
	}
}
Params p5Params = new Params();
*/
void setup()
{
  size(640,640,P3D);
  for(int i=0;i<numCubes;i++)
  {
    float b = random(5,15);
    float a = random(-900,900);
    float st = random(0.025,0.7);
    color c = color(0,random(46,192),random(128,255));
    boxes[i] = new boxy(b,a,st,c);
  }
  noStroke();
  frameRate(60);
}

void draw()
{
  background(0);
  lights();
  pushMatrix();
  translate(width/2,height/2,0);
  if(p5Params.rotateZ)
	rotateZ(frameCount*PI/100);
  if(p5Params.rotateX)  
	rotateX(frameCount*PI/200);
  if(p5Params.rotateY)	
	rotateY(frameCount*PI/150);
  for(int i=0;i<numCubes;i++)
  {
    float x = boxes[i].a*sin(frameCount*boxes[i].st*PI/60)/p5Params.divideX;
    float y = boxes[i].a*sin(frameCount*boxes[i].st*PI/120)/p5Params.divideY;
    float z = boxes[i].a*cos(frameCount*boxes[i].st*PI/60)/p5Params.divideZ;
    pushMatrix();
    translate(x,y,z);
	if(p5Params.wireframe)
	{
		noFill();
		stroke(boxes[i].c);
	}
	else
	{
		noStroke();
		fill(boxes[i].c);
	}
    box(boxes[i].b,boxes[i].b,boxes[i].b);
    popMatrix();
  }
  popMatrix();
}