void setup()
{
  size(640,640,JAVA2D);
  ellipseMode(RADIUS);
}

void draw()
{
  background(128);
  strokeWeight(p5Params.lineWidth);
  ellipse(width/2,height/2,p5Params.radiusX,p5Params.radiusY);
}

