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
}

void draw()
{

  background(src);
  src.loadPixels();
  //drip = (int)(width/2*sin(frameCount*PI/120)+width/2);
  drip = (int)(random(0,width-1));
  bouncies.add(new PVector(drip,0,random(6,10)));
    
  buffer.beginDraw();
  buffer.ellipseMode(RADIUS);
  //buffer.fill(0,4);
  //buffer.rect(0,0,width,height);
  //buffer.background(0,4);
  buffer.noStroke();
  
  for(int i=bouncies.size()-1;i>=0;i--)
  {
    PVector p = bouncies.get(i);
    int idx = (int)(p.y*width+p.x);
    float r=map(p.x,0,width,0,255);
    float b=map(p.y,0,height,0,255);
    float al = map(p.y,0,height-1,0,128);
    buffer.fill(192,0,0,(int)map(p.z,10,3,128,16));
    //buffer.fill(192,0,0,al);
    int rt = (int)(random(2,5));
    float rx = 2;
    float ry = 2;
    if(src.pixels[idx]==color(0))
    {
      rx=p.z;
      ry=p.z+rt;
      buffer.fill(192,0,0,64);
    }
    buffer.ellipse(p.x,p.y,rx,ry);
    p.y+=(int)(p.z*0.5);
    p.z*=0.99;
    if(p.z<=3)
      p.z=3;
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
