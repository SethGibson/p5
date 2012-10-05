ArrayList<PVector> bouncies;
PImage src;
PImage dest;
PGraphics buffer;
int drip;

void setup()
{
  src = loadImage("filter.jpg");
  size(src.width,src.height,JAVA2D);
  dest = createImage(width,height,RGB);
  ellipseMode(RADIUS);
  noStroke();
  bouncies = new ArrayList();
  buffer = createGraphics(width,height,JAVA2D);
  frameRate(60);
  background(16);
}

void draw()
{

  //background(src);
  src.loadPixels();
  drip = (int)(width/2*sin(frameCount*PI/240)+width/2);
  //drip = (int)(random(0,width-1));
  bouncies.add(new PVector(drip,0,random(6,10)));
    
  buffer.beginDraw();
  buffer.ellipseMode(RADIUS);
  buffer.fill(0,4);
  buffer.rect(0,0,width,height);
  //buffer.background(0,4);
  buffer.noStroke();
  
  for(int i=bouncies.size()-1;i>=0;i--)
  {
    PVector p = bouncies.get(i);
    int idx = (int)(p.y*width+p.x);
    if(src.pixels[idx]==color(0))
    {
      buffer.fill(128,0,0);
      buffer.ellipse(p.x,p.y,1,1);
    }

    p.y+=(int)(p.z*random(.1,.5));
    if(p.y>=height-1)
      bouncies.remove(i);
    else
      bouncies.set(i,p);
  }
  buffer.endDraw();
  //src.updatePixels();
  //dest=src.get();
  //blend(buffer,0,0,width,height,0,0,width,height,OVERLAY);
  image(buffer,0,0);  
  //image(src,0,0);
}
