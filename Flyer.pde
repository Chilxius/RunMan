class Flyer
{
  float x, y, offset;
  float ySpeed;
  float size;
  float eyeOffsetX, eyeOffsetY;
  boolean active;
  boolean recentlyStolen;
  int thiefCounter;
  
  public Flyer( float x, float y, float size )
  {
    this.x = x;
    this.y = y;
    this.size = size;
    this.active = true;
    recentlyStolen = false;
    thiefCounter = 0;
  }
  
  void drawFlyer()
  {   
    eyeOffsetX = (width/2-x+offset)/32.5;
    eyeOffsetY = (runMan.y-y)/45;
  
    noStroke();
    fill(100,0,50);
    ellipse(x-offset,y,50,50);
    
    stroke(100,0,50);
    strokeWeight(3);
    noFill();
    arc(x-offset,y-25,60,50,0,PI);
    arc(x-offset,y-20,75,40,0,PI);
    arc(x-offset,y+25,60,50,PI,2*PI);
    arc(x-offset,y+20,75,40,PI,2*PI);
    
    fill(255);  //Eye
    ellipse(x-offset+eyeOffsetX,y+eyeOffsetY,20,20);
    fill(100,0,50);

    fill(0);  //Pupil
    ellipse(x-offset+eyeOffsetX*1.2,y+eyeOffsetY*1.2,10,10);
    fill(100,0,50);
    stroke(100,0,50);
    arc(x-offset+eyeOffsetX,y+eyeOffsetY,22,22,1.2*PI,1.8*PI,OPEN);
    arc(x-offset+eyeOffsetX,y+eyeOffsetY,22,22,.3*PI,.7*PI,OPEN);
  } 
  
  void moveFlyer( float amount )
  {
    offset = amount;
    x+=max(0,runMan.xSpeed*.75);
    if(x-offset < -1000)
      active = false;
      
    y+= ySpeed;
    
    if( y > runMan.y-50 && y < runMan.y+50 && abs((x-offset) - width/2) < 500 && (x-offset) > width/2 )
      x-= (500-((x-offset)-width/2))/50;
    
    if( x-offset > width/2 && x-offset < width )
    {
      if( y > runMan.y+20 )
      {
        ySpeed -= .1;
        if(ySpeed<4)
          ySpeed = -4;
      }
      else if( y < runMan.y-20 )
      {
        ySpeed += .3;
        if(ySpeed > 5)
          ySpeed = 5;
      }
      else
        ySpeed /= 1.1;
    }
    else
      ySpeed /=1.2;
  }
  
  void justStole()
  {
    recentlyStolen = true;
    thiefCounter = 20;
  }
  
  void thiefReset()
  {
    thiefCounter--;
    if(thiefCounter<=0)
      recentlyStolen = false;
  }
}
