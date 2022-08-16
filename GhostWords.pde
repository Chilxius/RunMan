class GhostWords
{
  String text;
  float counter;
  float x, y;
  boolean active;
  
  public GhostWords( String t )
  {
    text = t;
    counter = 100;
    x = 150;
    y = height -75;
    active = true;
  }
  
  public GhostWords( int type, int level )
  {
    if( type == 0 )
    {
      if( level == 1 )
        text = "Lasers slow the Chomper now!";
      else if( level == 2 )
        text = "Never enough Lasers!";
    }
    else if( type == 1 )
    {
      if( level == 1 )
        text = "Longer warp, speed boost!";
      else if( level == 2 )
        text = "Longest warp, better boost!";
    }
    else if( type == 2 )
    {
      if( level == 1 )
        text = "Faster!";
      else if( level == 2 )
        text = "GO! GO! GO!";
    }
    else if( type == 5 )
      text = "Crystals appear more often now!";

    counter = 100;
    x = 150;
    y = height -75;
    active = true;
  }
  
  void displayText()
  {
    fill(255,175);
    textSize(50);
    text(text,x,y);
    y-=.5;
    counter--;
    if(counter <= 0)
      active = false;
  }
}
