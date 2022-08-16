class WarpTrail
{
  float x,y,offset;
  float dist;
  float timer;
  boolean active;
  
  public WarpTrail( float x, float y, float dist )
  {
    this.x = x;
    this.y = y;
    this.dist = dist;
    timer = 25+display.powerLevel[1]*4;
  }
  
  boolean drawTrail( float amount ) //returns true when the animation is done
  {
    timer--;
    if(timer<=0)
      return true;
      
    offset = amount;
      
    strokeWeight(40);
    stroke(255,100,100,timer*10);
    line(width/2,y,x-dist,y);
    
    return false;
  }
}
