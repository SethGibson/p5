/*
class Params
{
  int agents;
  int minimumX,maximumX;
  int minimumY,maximumY;
  int fade;
  
  Params()
  {
    this.agents = 10;
    this.minimumX = -10;
    this.maximumX = 10;
    this.minimumY = -10;
    this.maximumY = 10;
    this.fade = 2;
  }
}
Params p5Params = new Params();
*/
int activeAgents;
PGraphics lineBuffer;
PVector[] positions;
void setup()
{
  size(640,640,JAVA2D);
  stroke(0);
  lineBuffer = createGraphics(width,height,JAVA2D);
  positions = new PVector[p5Params.agents];  
  for(int i=0;i<p5Params.agents;i++)
  {
    positions[i] = new PVector(width,height);
  }
  smooth();
  activeAgents = p5Params.agents;
}

void draw()
{
  background(0);
  lineBuffer.beginDraw();
  lineBuffer.fill(0,p5Params.fade);
  lineBuffer.noStroke();
  lineBuffer.rect(0,0,width,height);
  for(int i=0;i<activeAgents;i++)
  {
    float xt = random((float)p5Params.minimumX,(float)p5Params.maximumX);
    float yt = random((float)p5Params.minimumY,(float)p5Params.maximumY);
    int sw = (int)abs((xt+yt)/2);    
    int r = (int)map(positions[i].x,0,width,0,255);
    int b = (int)map(positions[i].y,0,height,0,255);
    lineBuffer.stroke(0);
    lineBuffer.strokeWeight(sw+3);
    lineBuffer.line(positions[i].x,positions[i].y,positions[i].x+xt,positions[i].y+yt);    
    lineBuffer.stroke(r,128,b);
    lineBuffer.strokeWeight(sw);
    lineBuffer.line(positions[i].x,positions[i].y,positions[i].x+xt,positions[i].y+yt);
    positions[i].x+=xt;
    positions[i].y+=yt;
  }
  lineBuffer.endDraw();
  image(lineBuffer,0,0);
  for(int i=0;i<activeAgents;i++)
  {
    if(positions[i].x<0)
      positions[i].x=width;
    if(positions[i].x>width)
      positions[i].x=0;
    if(positions[i].y<0)
      positions[i].y=height;
    if(positions[i].y>height)
      positions[i].y=0;
    int r = (int)map(positions[i].x,0,width,0,255);
    int b = (int)map(positions[i].y,0,height,0,255);
    int rx = (int)map(positions[i].x,0,width,10,30);
    int ry = (int)map(positions[i].y,0,height,10,30);
    int rf = (rx+ry)/2;
    
    fill(r,128,b);
    stroke(0);
    strokeWeight(1);
    ellipse(positions[i].x,positions[i].y,rf,rf);
  }
}

void mousePressed()
{
  lineBuffer = createGraphics(width,height,JAVA2D);  
  positions = new PVector[p5Params.agents];
  for(int i=0;i<p5Params.agents;i++)
  {
    float nxt = random(p5Params.minimumX,p5Params.maximumX);
    float nyt = random(p5Params.minimumY,p5Params.maximumY);
    if(nxt==0) {nxt=nyt;}
    if(nyt==0) {nyt=nxt;}
    positions[i] = new PVector(mouseX+nxt,mouseY+nyt);
  }
  activeAgents = p5Params.agents;
}


