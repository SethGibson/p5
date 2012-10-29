PGraphics buffer;
PImage img;
boolean asLine=true;
float vx=0;
float vy=1;
int num_pts=2000;
float[] px = new float[num_pts];
float[] py = new float[num_pts];
float[] pz = new float[num_pts];
void setup()
{
  size(960,210,JAVA2D);
  buffer = createGraphics(width,height,JAVA2D);
  img=loadImage("icodeart.png");
  for(int i=0;i<num_pts;i++)
  {
    px[i] = random(0,width-1);
    py[i] = random(0,height-1);
    pz[i] = random(.1,1);
  }
  buffer.beginDraw();
  buffer.background(16);
  buffer.noFill();
  buffer.stroke(116,100,68);
  buffer.endDraw();
}

void draw()
{
  buffer.beginDraw();
  buffer.fill(0,8);
  buffer.rect(0,0,width,height);
  buffer.noFill();
  img.loadPixels();
  PVector d = new PVector(mouseX-pmouseX,mouseY-pmouseY);
  if(abs(d.x)>0&&abs(d.y)>0)
  {
    vx=d.x;
    vy=d.y;
  }

  for(int i=0;i<num_pts;i++)
  {
    float lpx = px[i];
    float lpy = py[i];
    
    if(mousePressed)
    {
      px[i]-=((mouseX-px[i])*pz[i]*0.1);
      py[i]-=((mouseY-py[i])*pz[i]*0.1);
    }
    else
    {
      px[i]+=vx*pz[i];
      py[i]+=vy*pz[i];
    }
    if(px[i]>width-1)
    {
      px[i] = random(0,width/2);
      asLine=false;
    }
    if(px[i]<0)
    {
      px[i]=random(width/2,width-1);
      asLine=false;
    }
    if(py[i]>height-1)
    {
      py[i] = random(0,height/2);
      asLine=false;
    }
    if(py[i]<0)
    {
      py[i]=random(height/2,height-1);
      asLine=false;
    }
    //buffer.strokeWeight(int(lerp(1,4,pz[i])));
    if(asLine)
      buffer.line(lpx,lpy,px[i],py[i]);
    else
      buffer.point(px[i],py[i]);
    asLine=true;
    

  }
  buffer.endDraw();
  buffer.blend(img,0,0,width,height,0,0,width,height,MULTIPLY);
  image(buffer,0,0);
}
