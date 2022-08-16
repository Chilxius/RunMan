class Jumper
{
  float x,y;
  float xSpeed, ySpeed;
  boolean rightPressed, leftPressed, jumpPressed;
  boolean jumping;
  boolean facingRight;
  boolean platformSnap;
  boolean webbed;
  float size;
  float rotation;
  DrawMode mode;
  int [] blings = new int[6];
  
  int health, maxHealth;
  
  float speedBoostTimer, speedBoostAmount;
  boolean boosted;
  
  public Jumper( float x, float y )
  {
    this.x = x;
    this.y = y;
    ySpeed = 0;
    xSpeed = 0;
    jumping = false;
    size = 50;
    platformSnap=false;
    mode = DrawMode.STILL;
    facingRight = true;
    rotation = 0;
    health = maxHealth = 4;
    speedBoostTimer = 0;
    speedBoostAmount = 15;
    boosted = false;
  }
  
  public void jump( boolean result )
  {
    jumpPressed = result;
    //if(jumpPressed)
    //  jumping = true;
  }
  
  public void runRight( boolean result )
  {
    rightPressed = result;
    if(rightPressed)
      facingRight = true;
  }
  
  public void runLeft( boolean result )
  {
    leftPressed = result;
    if(leftPressed)
      facingRight = false;
  }
  
  public void moveJumper()
  {
    if( jumpPressed && ( onGround() || onPlatform() != -1 ) )// && !jumping )
    {
      ySpeed -= 20;
      jumping = true;
      jumpSound.play();
    }
    else if( !onGround() && onPlatform() == -1 )
      ySpeed+=.5;
    else if( onGround() )
    {
      y=height-100;
      ySpeed = 0;
      jumping = false;
    }
    else if( onPlatform() != -1 )
    {
      ySpeed = 0;
      jumping = false;
    }
    
    if(!webbed)
      y += ySpeed;
    else
      y += ySpeed/5;
    
    if(boosted)
    {
      if(rightPressed && xSpeed < 10+speedBoostAmount+(display.powerLevel[2]*7.5) )
        xSpeed += 4;
      if(leftPressed && xSpeed > -(10+speedBoostAmount+(display.powerLevel[2]*7.5) ) )
        xSpeed -= 4;
    }
    else
    {
      if(rightPressed && xSpeed < 14 )
        xSpeed += 2;
      if(leftPressed && xSpeed > -14 )
        xSpeed -= 2;
    }
      
    if(!boosted)
      xSpeed /= 1.1;
    
    if(!webbed)
      x+=xSpeed;
    else
      x+=xSpeed/5;
    
    progress = x;
    
    if( onPlatform() != -1 )
    {
      if( y+size/2 != plats.get(onPlatform()).y - plats.get(onPlatform()).size/16 && !platformSnap )
      {
        y = plats.get(onPlatform()).y - plats.get(onPlatform()).size/16 - size/2;
        platformSnap = true;
      }
    }
    
    if(onPlatform()>=0 || onGround() )
    {
      if( abs( xSpeed ) < 4 )
        mode=DrawMode.STILL;
      else if( xSpeed > 0 )
        mode=DrawMode.RUN_RIGHT;
      else
        mode=DrawMode.RUN_LEFT;
    }
    else if(jumping || abs( ySpeed ) > 1 )
    {
      if( xSpeed > 0 )
        mode=DrawMode.JUMP_RIGHT;
      else
        mode=DrawMode.JUMP_LEFT;
    }
    else
      mode = DrawMode.STILL;
      
    for(Flyer f: flyers)
    {
      if( dist( width/2, y, f.x-f.offset, f.y ) < 50 ) 
      {
        flyerBumpSound.play();
        xSpeed = -150;
        //f.x+=70;
        if(!f.recentlyStolen)
        {
          f.justStole();
          dropCrystal();
        }
      }
    }
      
    if(speedBoostTimer <= 0)
      boosted = false;
    else
      speedBoostTimer--;
  }
  
  public void drawJumper()
  {
    rotation += 0.3;
    if(rotation > 2*PI)
      rotation-=2*PI;
      
    noStroke();
    switch(mode)
    {
      case RUN_RIGHT:
        drawFoot(false);
        fill(0,0,200);
        ellipse(width/2,y,size,size);
        drawEye();
        drawFoot(true);
        break;
      case RUN_LEFT:
        drawFoot(false);
        fill(0,0,200);
        ellipse(width/2,y,size,size);
        drawEye();
        drawFoot(true);
        break;
      case JUMP_RIGHT:
        drawFoot(false);
        fill(0,0,200);
        ellipse(width/2,y,size,size);
        drawEye();
        drawFoot(true);
        break;
      case JUMP_LEFT:
        drawFoot(false);
        fill(0,0,200);
        ellipse(width/2,y,size,size);
        drawEye();
        drawFoot(true);
        break;
      default:
        fill(0,0,200);
        ellipse(width/2,y,size,size);
        drawEye();
        drawFoot(true);
        break;
    }
  }
  
  void drawEye()
  {
    fill(255);
    if(facingRight)
      ellipse(width/2+size/3,y,17,25);
    else
      ellipse(width/2-size/3,y,17,25);
    fill(0);
    if(facingRight)
      ellipse(width/2+size/3,y,10,12);
    else
      ellipse(width/2-size/3,y,10,12);      
  }
  
  void drawFoot( boolean front )
  {
    noStroke();
    fill(100,80,40);
    switch(mode)
    {
      case RUN_RIGHT:
        translate(width/2-10,y+10);
        if(front)
          rotate(rotation);
        else
          rotate(rotation+PI);
        ellipse(min(abs(xSpeed*1.5),25),0,20,20);
        if(front)
          rotate(-rotation);
        else
          rotate(-(rotation+PI));
        translate(-(width/2-10),-(y+10));
        break;
        
      case RUN_LEFT:
        translate(width/2+10,y+10);
        if(front)
          rotate(-rotation);
        else
          rotate(-(rotation+PI));
        ellipse(min(abs(xSpeed*1.5),25),0,20,20);
        if(front)
          rotate(rotation);
        else
          rotate(rotation+PI);
        translate(-(width/2+10),-(y+10));
        break;
        
      case JUMP_RIGHT:
        translate(width/2-20,y);
        if(front)
          ellipse(0,20,20,20);
        else
          ellipse(10,20,20,20);
        translate(-(width/2-20),-y);
        break;
        
      case JUMP_LEFT:
        translate(width/2+20,y);
        if(front)
          ellipse(0,20,20,20);
        else
          ellipse(-10,20,20,20);
        translate(-(width/2+20),-y);
        break;
      
      case STILL:
        ellipse(width/2+15,y+20,20,15);
        ellipse(width/2-15,y+20,20,15);
        break;
    }
  }
  
  void boost()
  {
    speedBoostTimer = 200+display.powerLevel[2]*100;
    boosted = true;
  }
  
  void boost( float timer )
  {
    speedBoostTimer = timer;
    boosted = true;
  }
  
  void dropCrystal()
  {
    if( blings[0] > 0
     || blings[1] > 0
     || blings[2] > 0
     || blings[3] > 0
     || blings[4] > 0 )
    {
      int choice = int(random(0,5));
      while( blings[choice] == 0 ) //should not be infinte if the preceeding if worked right
      {
        choice = int(random(0,5));
      }
      blings[choice]--;
      ghosts.add( new GhostCrystal( width/2, runMan.y, choice ) );
    }
    else if( blings[5] > 0 )
    {
      blings[5]--;
      ghosts.add( new GhostCrystal( width/2, runMan.y, 5 ) );
    }
  }
  
  boolean onGround()
  {
    if( y >= height-100 )
    {
      return true;
    }
    return false;
  }
  
  int onPlatform()
  {
    for( int i = 0; i < plats.size(); i++ )
    {
      if( y+size/5 >= plats.get(i).y-plats.get(i).size/4+30
      && y+size/5 <= plats.get(i).y-plats.get(i).size/4+60
      && width/2+size/2 > plats.get(i).x-plats.get(i).offset-plats.get(i).size/2
      && width/2-size/2 < plats.get(i).x-plats.get(i).offset+plats.get(i).size/2
      && ySpeed >= 0 )
      {
        return i;
      }
    }
    
    platformSnap = false;
    return -1;
  }
}

public enum DrawMode
{
  RUN_RIGHT, RUN_LEFT, JUMP_RIGHT, JUMP_LEFT, STILL
}
