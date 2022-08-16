class Star
{
  float x, y, offset;
  boolean isPlanet;
  color col;
  float size;
  
  public Star()
  {
    if( random(400) < 2 )
      isPlanet = true;
    
    if(isPlanet)
    {
      size = random(150,1000);
      x = progress+width+size;
      y = random(height+size/2);
      col = color( random(200), random(150), random(150) );
    }
    else
    {
      x = progress+width+10;
      y = random(height-100);
    }
  }
  
  public Star( float x, float y )
  {
    this.x = x;
    this.y = y;
    isPlanet = false;
  }
  
  void drawStar()
  {
    noStroke();
    if(isPlanet)
    {
      fill(col);
      circle(x-offset,y,400);
    }
    else
    {
      fill(170, 200, 100);
      circle(x-offset,y,3);
    }
  }
  
  void moveStar( float amount )
  {
    if(!isPlanet)
      offset = amount*.9; //parallax
    else
      offset = amount/2; //parallax
  }  
  
  boolean goneTooFar()
  {
    if( x - offset < -10000 )
      return true;
    return false;
  }
}
