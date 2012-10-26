ArrayList<PVector> blood;
PImage src;
PGraphics buffer;
PGraphics gradient;
int drip;
int maxr;

/* @pjs preload="data/filter.jpg"; */
void setup()
{
  src = loadImage("filter.jpg");
  size(600,600,P2D);
  ellipseMode(RADIUS);
  noStroke();
  blood = new ArrayList();
  buffer = createGraphics(width,height,P2D);
  maxr=(int)(dist(0,0,width/2,height/2));
  gradient = createGraphics(width,height,P2D);
  gradient.beginDraw();
  gradient.noFill();
  gradient.strokeWeight(16);
  gradient.ellipseMode(RADIUS);
  for(int i=maxr;i>=1;i-=15)
  {
    gradient.stroke(map(i,1,maxr,64,0),0,0);
    gradient.ellipse(width/2,height/2,i,i);
  }
  gradient.endDraw();
  
  //frameRate(60);
}

void draw()
{

  image(gradient,0,0);
  src.loadPixels();
  drip = (int)(width/2*sin(frameCount*PI/240)+width/2);
  blood.add(new PVector(drip,0,random(6,10)));
  blood.add(new PVector(width-drip,0,random(6,10)));  
    
  buffer.beginDraw();
  buffer.ellipseMode(RADIUS);
  buffer.fill(0,3);
  buffer.rect(0,0,width,height);
  
  buffer.noStroke();
  
  for(int i=blood.size()-1;i>=0;i--)
  {
    PVector p = blood.get(i);
    int idx = (int)(p.y*width+p.x);
    if(src.pixels[idx]==color(0))
    {
      buffer.fill(255,0,0);
      buffer.ellipse(p.x,p.y,2,3);
    }
    else
    {
      buffer.fill(128,0,0);
      buffer.ellipse(p.x,p.y,1,2);
    }

    p.y+=(int)(p.z*random(.25,.75));
    if(p.y>=height-1)
      blood.remove(i);
    else
      blood.set(i,p);
  }
  buffer.endDraw();
  image(buffer,0,0);  
}
