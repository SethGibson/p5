ArrayList<Splat> fitti;
PGraphics buffer;
PImage src;
void setup()
{
  src=loadImage("filter.jpg");
  size(src.width,src.height,P2D);
  buffer=createGraphics(width,height,P2D);
  fitti = new ArrayList();
  buffer.beginDraw();
  buffer.background(0);
  buffer.noStroke();
  buffer.fill(255);
  buffer.ellipseMode(RADIUS);
  buffer.endDraw();
}

void draw()
{
  image(src,0,0);
  buffer.beginDraw();
  for(int i=fitti.size()-1;i>=0;i--)
  {
    fitti.get(i).update();
    if(fitti.get(i).mAge<=0)
      fitti.remove(i);
    else
      fitti.get(i).render(buffer);
  }
  buffer.endDraw();
  buffer.blend(src,0,0,600,600,0,0,600,600,MULTIPLY);
  image(buffer,0,0);
}

void mousePressed()
{
  fitti.add(new Splat((int)random(15,30),(int)random(20,50),mouseX,mouseY));
}
