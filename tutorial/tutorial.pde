void setup()
{
  size(400,400,P2D);
  ellipseMode(RADIUS);
}

void draw()
{
  background(128);
  strokeWeight(ellipseParams.lineWidth);
  ellipse(width/2,height/2,ellipseParams.radiusX,ellipseParams.radiusY);
}

