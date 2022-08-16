class Laser
{
  float x, y;
  float laserTimer;
  boolean shotRight;
  
  public Laser( float x, float y, boolean right )
  {
    this.x = x;
    this.y = y;
    laserTimer = 90+display.powerLevel[0]*20;
    this.shotRight = right;
  }
  
  boolean drawLaser() //returns true if laser if finished
  {
    stroke(100,100,255,180);
    strokeWeight(laserTimer/3+((display.powerLevel[0]*20)*(laserTimer/90)));
    if(shotRight)
      line(x+25+display.powerLevel[0]*10,y,width+200,y);
    else
      line(x-(25+display.powerLevel[0]*10),y,-200,y);
    laserTimer-=5;
    if( laserTimer <=0 )
      return true;
    return false;
  }
}
