PGraphics buffer;
PImage img;
int sw;
float vx=0;
float vy=1;
float lpx,lpy;
float ds, dm;
int num_pts=2000;
float[] px = new float[num_pts];
float[] py = new float[num_pts];
float[] pz = new float[num_pts];

/* @pjs preload="TBar2/data/icodeart.png"; */
void setup()
{
  size(1150,250,JAVA2D);
  buffer = createGraphics(width,height,JAVA2D);
  ds = dist(0,0,width/2,height/2);
  img=loadImage("TBar2/data/icodeart.png");
  //img=loadImage("icodeart.png");
  for(int i=0;i<num_pts;i++)
  {
    px[i] = random(0,width-1);
    py[i] = random(0,height-1);
    pz[i] = random(.1,1);
  }
  buffer.beginDraw();
  buffer.background(16);
  buffer.noFill();
  buffer.noStroke();
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
  if(d.x!=0)
	vx=d.x;
  if(d.y!=0)
	vy=d.y;

  buffer.pushStyle();
  for(int i=0;i<num_pts;i++)
  {
    lpx = px[i];
    lpy = py[i];
    
    if(mousePressed)
    {
      px[i]+=((px[i]-mouseX)*0.025);
      py[i]+=((py[i]-mouseY)*0.025);
	  dm = dist(mouseX,mouseY,px[i],py[i]);
	  float dr = constrain(dm/ds,0,1);
	  sw = (int)lerp(1,5,dr);
    }
    else
    {
      px[i]+=vx*pz[i];
      py[i]+=vy*pz[i];
	  sw = int(lerp(1,5,pz[i]));
    }
    if(px[i]>width-1)
    {
      px[i] = random(0,width/2);
    }
    if(px[i]<=0)
    {
      px[i]=random(width/2,width-1);
    }
    if(py[i]>height-1)
    {
      py[i] = random(0,height/2);
    }
    if(py[i]<=0)
    {
      py[i]=random(height/2,height-1);
    }

    int idx=(int)py[i]*width+(int)px[i];
    if(img.pixels[idx]==color(255))
    {
        buffer.strokeWeight(sw);
        buffer.stroke(140,103,64);		
        buffer.point(px[i],py[i]);
    }
  }
  buffer.popStyle();  
  buffer.endDraw();
  image(buffer,0,0);
}
