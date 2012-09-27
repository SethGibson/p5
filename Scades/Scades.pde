/*class Params
{
  int resolution;
  Params()
  {
    this.resolution = 64;
  }
}
Params p5Params = new Params();
*/
PGraphics buffer;
PImage bufferImg;
boolean lineStarted=false;
int[] rows;
int activeRes;
float ix,iy;
int xStep,yStep;
float aspectRatio;
void setup()
{
  size(640,640,JAVA2D);
  ellipseMode(RADIUS);
  reset();
}

void draw()
{
  background(0);
  buffer.beginDraw();
  if(mousePressed&&mouseButton==LEFT)
  {
    if(!lineStarted)
    {
      ix=mouseX;
      iy=mouseY;
      lineStarted=true;
    }
    float sw = dist(ix,iy,mouseX,mouseY);
    float r = map(mouseX,0,width,0,255);
    float b = map(mouseY,0,height,0,255);
    buffer.stroke(r,128,b);
    buffer.strokeWeight(sw*.1);
    buffer.line(pmouseX,pmouseY,mouseX,mouseY);
  }
  buffer.noStroke();
  buffer.fill(0,8);
  buffer.rect(0,0,width,height);
  
  buffer.endDraw();
  buffer.loadPixels();
  for(int y=0;y<activeRes;y++)
  {
    rows[y]+=1;
    if(rows[y]>=height)
      rows[y]=0;
    
    for(int x=0;x<=activeRes;x++)
    {
      int xs = xStep*x;
      if(xs>width)
        xs=width;
      int idx=rows[y]*width+(xs);      
      if(idx>=width*height)
        idx=width*height-1;

      color c= color(buffer.pixels[idx]);
      fill(c);      
      ellipse(xStep*x,rows[y],xStep/2,yStep/2);
    }
  }
}

void mouseReleased()
{
  lineStarted=false;
}

void reset()
{
  activeRes = p5Params.resolution;
  aspectRatio = width/(float)height;
  xStep = width/activeRes;
  yStep = height/activeRes;
  rows = new int[activeRes+1];
  for(int i=0;i<=activeRes;i++)
  {
    rows[i] = yStep*i;
  }
  
  buffer = createGraphics(width,height,JAVA2D);
  buffer.beginDraw();
  buffer.background(16);
  buffer.endDraw();
}
