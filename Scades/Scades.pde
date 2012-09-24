PGraphics buffer;
PImage bufferImg;
boolean lineStarted=false;
int[] rows;
int reso = 40;
float ix,iy;
int xStep,yStep;
float aspectRatio;
void setup()
{
  size(800,800,JAVA2D);
  ellipseMode(RADIUS);
  aspectRatio = width/(float)height;
  xStep = width/reso;
  yStep = height/reso;
  rows = new int[reso+1];
  for(int i=0;i<=reso;i++)
  {
    rows[i] = yStep*i;
  }
  
  buffer = createGraphics(width,height,JAVA2D);
  buffer.beginDraw();
  buffer.background(16);
  buffer.endDraw();
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
  for(int y=0;y<reso;y++)
  {
    rows[y]+=1;
    if(rows[y]>=height)
      rows[y]=0;
    
    for(int x=0;x<=reso;x++)
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
