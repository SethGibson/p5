/*class Params
{
  int lineWidth;
  boolean asLines;
  Params()
  {
    this.lineWidth=1;
    this.asLines=true;
  }
}

Params p5Params = new Params();
*/
int bs;
int dir;
float ex, ey, lex, ley;
float mtx, mty;
float scx, scy;
float r,b;
float sd;
PGraphics buffer;

void setup()
{
  size(640,640,JAVA2D);
  background(0);
  noStroke();
  ellipseMode(RADIUS);
  buffer=createGraphics(width,height,JAVA2D);
  sd = dist(0,0,width/2,height/2);
  scx=width/2;
  scy=height/2;
  mtx=.25;
  mty=.25;
  bs=5;
  dir=1;
  r=map(mouseX,0,width,0,255);
  b=map(mouseY,0,height,0,255);
  lex=width/2;
  ley=height/2;  
}

void draw()
{
  background(0);
  buffer.beginDraw();
  //buffer.noStroke();
  buffer.ellipseMode(RADIUS);
  ex = (width/2*sin((dir*frameCount)*PI/30)*mtx)+scx;
  ey = (height/2*cos((dir*frameCount)*PI/30)*mty)+scy;

  if(mousePressed)
  {
    if(mouseButton==LEFT)
    {
      r=map(ex,0,width,0,255);
      b=map(ey,0,height,0,255);
      if(dist(pmouseX,pmouseY,mouseX,mouseY)==0)
      {
        scx=mouseX;
        scy=mouseY;
        mtx=map(mouseX,width/2,width,0,1);
        mty=map(mouseY,height/2,height,0,1);
        float er=dist(ex,ey,width/2,height/2);
        er = map(er,0,sd,5,20);        
        if(p5Params.asLines)
        {
          buffer.stroke(r,128,b);
          buffer.strokeWeight(p5Params.lineWidth);
          buffer.line(lex,ley,ex,ey);          
        }
        else
        {
          buffer.stroke(0);
          buffer.strokeWeight(1);
          buffer.fill(r,128,b);
          buffer.ellipse(ex,ey,er,er);
        }
      }
    }
  }
  
  buffer.endDraw();
  image(buffer,0,0);
  ellipse(ex,ey,bs,bs);
  lex=ex;
  ley=ey;
  
}

