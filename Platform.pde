class Platform
{
  float x, y, offset;
  float size;
  
  public Platform( float x, float y, float s )
  {
    this.x = x;
    this.y = y;
    this.size = s;
  }
  
  void drawPlatform()
  {
    rectMode(CENTER);
    fill(100,80,50);
    rect(x-offset,y,size,size/8);
    //fill(255);
    //text(size,x-offset,y); //testing
  }
  
  void movePlatform( float amount )
  {
    offset = amount;
  }
  
  boolean goneTooFar()
  {
    if( x - offset < -10000 )
      return true;
    return false;
  }
}
