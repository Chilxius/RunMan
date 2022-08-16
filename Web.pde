class Web
{
  float x, y, size;
  float offset;
  
  public Web( float x, float y, float size )
  {
    this.x = x;
    this.y = y;
    this.size = size;
  }
      
  void moveWeb( float amount )
  {
    offset = amount;
  }
  
  void drawWeb()
  {
    push();
    translate(-offset,0);
    noFill();
    stroke(175);
    strokeWeight(2);
    
    //Crossed Threads
    line(x+size,y+size,x-size,y-size);
    line(x+size,y-size,x-size,y+size);
    line(x+size/3,y+size,x-size/3,y-size);
    line(x+size/3,y-size,x-size/3,y+size);
    line(x+size,y+size/3,x-size,y-size/3);
    line(x+size,y-size/3,x-size,y+size/3);
    
    //Outer row of curved threads
    curve(x+size*2,y+size*2,x+size,y+size,x+size,y+size/3,x+size*2,y+size/3*2);
    curve(x+size*2,y+size/3*2,x+size,y+size/3,x+size,y-size/3,x+size*2,y-size/3*2);
    curve(x+size*2,y-size/3*2,x+size,y-size/3,x+size,y-size,x+size*2,y-size*2);
    
    curve(x+size*2,y-size*2,x+size,y-size,x+size/3,y-size,x+size/3*2,y-size*2);
    curve(x+size/3*2,y-size*2,x+size/3,y-size,x-size/3,y-size,x-size/3*2,y-size*2);
    curve(x-size/3*2,y-size*2,x-size/3,y-size,x-size,y-size,x-size*2,y-size*2);
    
    curve(x-size*2,y+size*2,x-size,y+size,x-size,y+size/3,x-size*2,y+size/3*2);
    curve(x-size*2,y+size/3*2,x-size,y+size/3,x-size,y-size/3,x-size*2,y-size/3*2);
    curve(x-size*2,y-size/3*2,x-size,y-size/3,x-size,y-size,x-size*2,y-size*2);
    
    curve(x+size*2,y+size*2,x+size,y+size,x+size/3,y+size,x+size/3*2,y+size*2);
    curve(x+size/3*2,y+size*2,x+size/3,y+size,x-size/3,y+size,x-size/3*2,y+size*2);
    curve(x-size/3*2,y+size*2,x-size/3,y+size,x-size,y+size,x-size*2,y+size*2);
    
    //Inner row of curved threads
    curve(x+size,y+size,x+size/2,y+size/2,x+size/2,y+size/6,x+size,y+size/3);
    curve(x+size,y+size/3,x+size/2,y+size/6,x+size/2,y-size/6,x+size,y-size/3);
    curve(x+size,y-size/3,x+size/2,y-size/6,x+size/2,y-size/2,x+size,y-size);
    
    curve(x+size,y-size,x+size/2,y-size/2,x+size/6,y-size/2,x+size/3,y-size);
    curve(x+size/3,y-size,x+size/6,y-size/2,x-size/6,y-size/2,x-size/3,y-size);
    curve(x-size/3,y-size,x-size/6,y-size/2,x-size/2,y-size/2,x-size,y-size);
    
    curve(x-size,y+size,x-size/2,y+size/2,x-size/2,y+size/6,x-size,y+size/3);
    curve(x-size,y+size/3,x-size/2,y+size/6,x-size/2,y-size/6,x-size,y-size/3);
    curve(x-size,y-size/3,x-size/2,y-size/6,x-size/2,y-size/2,x-size,y-size);
    
    curve(x+size,y+size,x+size/2,y+size/2,x+size/6,y+size/2,x+size/3,y+size);
    curve(x+size/3,y+size,x+size/6,y+size/2,x-size/6,y+size/2,x-size/3,y+size);
    curve(x-size/3,y+size,x-size/6,y+size/2,x-size/2,y+size/2,x-size,y+size);
    //translate(-offset,0);
    pop();
  }
  
  boolean playerStuck()
  {
    if( dist( width/2, runMan.y, x-offset, y ) < size )
      return true;
    return false;
  }
}
