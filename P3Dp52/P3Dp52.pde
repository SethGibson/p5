class boxy
{
  float y;
  float b;
  float a;
  float st;
  color c;
  
  boxy(){}
  boxy(float y, float b, float a, float st, color c)
  {
    this.y=y;
    this.b=b;
    this.a=a;
    this.st=st;
    this.c=c;
  }
}

int numCubes = 1100;
float xdiv = 5;
float ydiv = 3;
float zdiv = 2;
float[] xs;
float[] ys;
float[] zs;
float[] aw;
float[] ah;

boxy[] boxes = new boxy[numCubes];

void setup()
{
  size(800,450,OPENGL);
  for(int i=0;i<numCubes;i++)
  {
    float t = random(0,1);
    float y = random(-height,height);
    float b = random(5,15);
    float a = random(-width,width);
    float st = random(0.01,0.5);
    color c = color(0,random(46,192),random(128,255));
    boxes[i] = new boxy(y,b,a,st,c);
  }
  noStroke();
  frameRate(60);
}

void draw()
{
  background(0);
  pushMatrix();
  translate(width/2,height/2,0);
  rotateZ(frameCount*PI/240);
  //rotateY(frameCount*PI/240);
  //rotateX(frameCount*PI/240);
  rotateY((frameCount+mouseY)*PI/240);  
  rotateX((frameCount+mouseX)*PI/240);
  for(int i=0;i<numCubes;i++)
  {
    float al = map(abs(boxes[i].a),0,width,0,255);      
    fill(boxes[i].c,255-al);
    float x = boxes[i].a*sin(frameCount*boxes[i].st*PI/60)/xdiv;
    float y = boxes[i].a*sin(frameCount*boxes[i].st*PI/120)/ydiv;
    float z = boxes[i].a*cos(frameCount*boxes[i].st*PI/60)/zdiv;
    pushMatrix();
    translate(x,y,z);
    box(boxes[i].b,boxes[i].b,boxes[i].b);
    popMatrix();
  }
  popMatrix();
}

void keyPressed()
{
  if(key=='q')
    ++xdiv;
  if(key=='a')
    --xdiv;
  if(key=='w')
    ++ydiv;
  if(key=='s')
    --ydiv;
  if(key=='e')
    ++zdiv;
  if(key=='d')
    --zdiv;
}
