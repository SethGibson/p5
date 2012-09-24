PGraphics lineBuffer;
PVector[] positions = new PVector[numAgents];
int agentCount = numAgents;
void setup()
{
  size(800,450,P2D);
  stroke(0);
  lineBuffer = createGraphics(width,height,P2D);
  for(int i=0;i<numAgents;i++)
  {
    positions[i] = new PVector(width,height);
  }
  smooth();
}

void draw()
{
  background(0);
  lineBuffer.beginDraw();
  lineBuffer.fill(0,bgAlpha);
  lineBuffer.noStroke();
  lineBuffer.rect(0,0,width,height);
  for(int i=0;i<agentCount;i++)
  {
    float xt = random((float)minX,(float)maxX);
    float yt = random((float)minY,(float)maxY);
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
  for(int i=0;i<agentCount;i++)
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
  positions = new PVector[numAgents];
  for(int i=0;i<numAgents;i++)
  {
    float nxt = random(minX,maxX);
    float nyt = random(minY,maxY);
    if(nxt==0) {nxt=nyt};
    if(nyt==0) {nyt=nxt};
    positions[i] = new PVector(mouseX+nxt,mouseY+nyt);
  }
  agentCount = numAgents;  
}


