class Splat
{
  int mAge, mLife;
  int mMax;
  int mCX, mCY;
  float[] mPosX;
  float[] mPosY;
  float[] mDirX;
  float[] mDirY;
  
  Splat(){}
  Splat(int _life, int _max, int _cx, int _cy)
  {
    this.mAge=this.mLife=_life;
    this.mMax=_max;
    this.mCX=_cx;
    this.mCY=_cy;
    this.mPosX = new float[_max];
    this.mPosY = new float[_max];    
    this.mDirX = new float[_max];
    this.mDirY = new float[_max];
    for(int i=0;i<this.mMax;i++)
    {
      mPosX[i]=this.mCX;
      mPosY[i]=this.mCY;
      mDirX[i]=random(-5,5);
      mDirY[i]=random(-5,5);
    }
  }
    
  void update()
  {
    if(this.mAge>0)
    {
      for(int i=0;i<this.mMax;i++)
      {
        this.mPosX[i]+=this.mDirX[i];
        this.mPosY[i]+=this.mDirY[i];
      }
      --this.mAge;
    }
  }
    
  void render(PGraphics _buffer)
  {
    for(int i=0;i<this.mMax;i++)
    {
      float nAge=this.mAge/(float)this.mLife;
      float rad = 10.0*nAge;
      float al = 255*nAge;
      float r=map(this.mCX,0,width,0,255);
      float b=map(this.mCY,0,height,0,255);
      _buffer.fill(192,r*.25,b*.1,al);
      _buffer.ellipse(this.mPosX[i],this.mPosY[i],rad,rad);
    }
  }
} 
