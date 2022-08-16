class Explosion
{
  float x, y;
  int counter;
  float offX1, offY1, offX2, offY2, offX3, offY3;
  
  public Explosion( float x, float y )
  {
    this.x = x;
    this.y = y;
    counter = 0;
    offX1 = random(-25,25);
    offY1 = random(-25,25);
    offX2 = random(-25,25);
    offY2 = random(-25,25);
    offX3 = random(-25,25);
    offY3 = random(-25,25);
  }
  
  public boolean drawExplosion() //returns true when finished
  {
    counter+=2;
    noStroke(); //<>//
    if(counter < 30)
    {
      fill(200-counter*2,100,0);
      ellipse(x+offX1,y+offY1,5+counter,5+counter);
    }
    if(counter >= 10 && counter < 40)
    {
      fill(200-(counter-10)*2,100,0);
      ellipse(x+offX2,y+offY2,5+(counter-10),5+(counter-10));
    }
    if(counter >= 20 && counter < 50)
    {
      fill(200-(counter-20)*2,100,0);
      ellipse(x+offX3,y+offY3,5+(counter-20),5+(counter-20));
    }
    if(counter >= 50)
      return true;
    return false;
  }
}

// first burst - 0 -> 30
//second burst- 10 -> 40
// third burst- 20 -> 50
