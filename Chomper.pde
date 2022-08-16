class Chomper
{
  float x, y;
  boolean mouthClosed;
  float offset;
  float slowMultiplier = 1;
  boolean dangerMessageSent = false;
  
  public Chomper()
  {
    x = 100;
    y = height/2;
    mouthClosed = true;
  }
  
  void moveChomper( float amount )
  {
    offset=amount;
    x+=(3+millis()/20000)*slowMultiplier;
    if( !dangerMessageSent && millis() >= 220000 )
    {
      text = new GhostWords("He's faster than you now...");
      dangerMessageSent = true;
    }
    if(y>runMan.y+50)
      y-=10;
    if(y<runMan.y-50)
      y+=10;
      
    if(slowMultiplier<0)
      slowMultiplier = abs(slowMultiplier);
    if(slowMultiplier<1)
      slowMultiplier *= 1.05;
  }
  
  void drawChomper()
  {
    noStroke();
    if(millis()%1000<500)
      mouthClosed = true;
    else
      mouthClosed = false;
      //625,450
    if(slowMultiplier<1)
      fill(0,0,75);
    else
      fill(75,0,0);
    translate(x-offset,y);
    float rotation = atan2( runMan.y-y, width/2-(x-offset));
    rotate( rotation );
    if(mouthClosed)
    {
      ellipse(0,0,400,400);
      fill(150,150,120);
      triangle(195,0,145,0,160,100);
      triangle(115,0,65,0,80,70);
      stroke(0);
      strokeWeight(2);
      line(0,0,200,0);
      noStroke();
    }
    else
    {
      fill(150,150,120);
      triangle(125,-130,85,-100,135,-50);
      triangle(115,130,75,100,125,50);
      triangle(75,-130,35,-100,85,-50);
      triangle(65,130,25,100,75,50);
      
      if(slowMultiplier<1)
        fill(0,0,75);
      else
        fill(75,0,0);
      arc(0,0,400,400,PI*0.25,PI*1.75);
    }
    rotate( -rotation );
    translate(-(x-offset),-y);
  }
  
  void slowDown()
  {
    slowMultiplier = 1 / min(10000,(10000-dist( x, 0, runMan.x-width/2, 0 ) ) );
    
    //println(min(10000,(10000-dist( x, 0, runMan.x-width/2, 0 ) )));
    //println( 1.0 / 100 );
    //println( 1.0 / 1000 );
    //println( 1.0 / 5000 );
    //println( 1.0 / 10000 ); //<>//
  }
}
