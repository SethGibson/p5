boolean exploding;
float burstRadius = 0.25;
int NUM_PTS = 500;
int x[] = new int[NUM_PTS];
int y[] = new int[NUM_PTS];
int dx[] = new int[NUM_PTS];
int dy[] = new int[NUM_PTS];
float shockwave;
float seismicRadius;
float epiX,epiY;
float weight,redTerm;
float screenDist;
float activeDist;
PImage img;
PGraphics buffer;

/* @pjs preload="TBar/header.png"; */
void setup()
{
  img = loadImage("TBar/header.png");
  img.loadPixels();
  int i=0;
  while(i<NUM_PTS)
  {
    int x0 = (int)random(0,img.width-1);
    int y0 = (int)random(0,img.height-1);
    int idx = y0*img.width+x0;
    if(img.pixels[idx]==color(0))
    {
      x[i]=x0;
      y[i]=y0;
      dx[i]=(int)random(1,2);
      dy[i]=(int)random(1,2);
      ++i;
    }
  }
  
  size(750,200,JAVA2D);
  ellipseMode(RADIUS);
  noStroke();
  
  screenDist = dist(0,0,width/2,height/2);
  buffer = createGraphics(width,height,JAVA2D);
  buffer.beginDraw();
  buffer.background(16);
  buffer.endDraw();
}

void draw()
{
  img.loadPixels();
  buffer.beginDraw();
  buffer.noStroke();

  buffer.pushStyle();
  buffer.fill(0,8);
  buffer.rect(0,0,width,height);
  buffer.popStyle();
  for(int i=0;i<NUM_PTS;i++)
  {
    //The bounds checking...oh my god so much bounds checking
    x[i]=x[i]+dx[i]>=width?width-1:x[i]+dx[i];
    y[i]=y[i]+dy[i]>=height?height-1:y[i]+dy[i];
    int x0=x[i]-1<=0?0:x[i]-1;
    int x1=x[i]+1>=width?width-1:x[i]+1;
    int y0=y[i]-1<=0?0:y[i]-1;
    int y1=y[i]+1>=height?height-1:y[i]+1;
    //-------------------------------------------------------
    
    int idx0 = y[i]*width+x0;
    int idx1 = y[i]*width+x1;
    int idy0 = y0*width+x[i];
    int idy1 = y1*width+x[i];
    
    if(x[i]<=0||x[i]>=width||img.pixels[idx0]==color(255)||img.pixels[idx1]==color(255))
    {
      dx[i]*=-1;      
    }
    if(y[i]<=0||y[i]>=height||img.pixels[idy0]==color(255)||img.pixels[idy1]==color(255))
    {
      dy[i]*=-1;      
    }
    
    activeDist = dist(x[i],y[i],mouseX,mouseY);
    
    if(exploding)
    {
      activeDist = dist(x[i],y[i],epiX,epiY);
      if(activeDist<=shockwave)
      {
        weight = max(1,(activeDist/shockwave)*15);
        redTerm = max(1,(activeDist/shockwave)*255);
      }
      else
      {
        weight = 1;
        redTerm = 1;
      }
    }
    else
    {
      weight = max(1,lerp(15,1,activeDist/(screenDist*burstRadius)));
      redTerm = max(1,lerp(255,1,activeDist/(screenDist*burstRadius)));
      if(mouseX>=width-10||mouseX<=10||mouseY>=height-10||mouseY<=10)
      {
        weight = 1;
        redTerm = 1;
      }
    }
    buffer.pushStyle();
    buffer.stroke(255,redTerm,0);
    buffer.strokeWeight(weight);
    buffer.line(x[i]-dx[i],y[i]-dy[i],x[i],y[i]);
    buffer.popStyle();
    buffer.noStroke();
  }
  buffer.endDraw();  
  image(buffer,0,0);
  if(exploding)
  {
    if(shockwave>=seismicRadius)
    {
      exploding=false;
    }
    else
    {
      shockwave+=16;
    }
  }
  pushStyle();
  fill(32);
  text("#181",710,190);
  popStyle();
}

void mousePressed()
{
  if(!exploding)
  {
    epiX=mouseX;
    epiY=mouseY;
    exploding=true;
    shockwave=0;
    seismicRadius = max(abs(width-epiX),epiX);
  }
}
