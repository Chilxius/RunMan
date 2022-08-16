/****************************************
* Bennett Ritchie                       *
* Run Man: Escape the Chomper           *
*                                       *
* This is an endless runner where you   *
* flee from the chomper for as long as  *
* you can.                              *
*                                       *
* The chomper's speed is based on the   *
* amount of time the game has been      *
* running. Therefore, it will catch you *
* eventually.                           *
****************************************/

import processing.sound.*;

PrintWriter output;

ArrayList<GhostCrystal> ghosts = new ArrayList<GhostCrystal>();
ArrayList<WarpTrail> trails = new ArrayList<WarpTrail>();
ArrayList<Explosion> booms = new ArrayList<Explosion>();
ArrayList<Platform> plats = new ArrayList<Platform>();
ArrayList<Crystal> bling = new ArrayList<Crystal>();
ArrayList<Flyer> flyers = new ArrayList<Flyer>();
ArrayList<Laser> beams = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Web> webs = new ArrayList<Web>();

Jumper runMan;
Chomper chomp;
HUD display;
GhostWords text;

public SoundFile jumpSound, flyerBumpSound, crystalSound, laserSound, speedSound, upgradeSound, biteSound, clickSound, popSound;
float progress, nextWeb, nextPlat, nextStar, nextFlyer, nextCrystal;
int nextCrystalType = 0;

void setup()
{
  size(1250,900);
  progress = 0;
  nextPlat = progress+random(150,500);
  nextStar = progress+random(20,50);
  nextFlyer = progress+random(10000,20000);
  nextCrystal = 1;
  nextWeb = 10;
  
  runMan = new Jumper(500,800);
  chomp = new Chomper();
  display = new HUD();
  
  for(int i = 0; i < 50; i++)
    stars.add( new Star( random(width*2), random(height-100) ) );
    
  setupSounds();
  
  text = new GhostWords("Run!");
  
  //output = createWriter("highscore.txt");
}
 
void draw()
{
  handleBackground();
      
  handleStars();
  drawFloor();
  handlePlatforms();
  handleJumper();
  handleCrystals();
  handleWebs();
  handleFlyers();
  handleLasers();
  handleExplosions();
  handleWarpTrails();
  handleGhostCrystals();
  handleChomper();
  display.drawHUD();
  if(text.active)
    text.displayText();
}

void handleBackground()
{
  if(runMan.boosted)
  {
    noStroke();
    rectMode(CORNER);
    fill(0,75);
    rect(0,0,width,height);
  }
  else
    background(0);
}

void handleStars()
{
  for(Star s: stars)
  {
    s.moveStar(progress);
    if(!s.isPlanet)
      s.drawStar();
  }
  for(Star s: stars)
    if(s.isPlanet)
      s.drawStar(); 
    
  if(progress>=nextStar)
  {
    nextStar = progress+random(20,50);
    stars.add( new Star() );
  }  
  
  for( int i = 0; i < stars.size(); i++)
  {
    if( stars.get(i).goneTooFar() )
    {
      stars.remove(i);
      i--;
    }
  }
}

void drawFloor()
{
  rectMode(CORNER);
  fill(120);
  rect(0,height-100,width,100);
}

void handlePlatforms()
{
  for(Platform p: plats)
  {
    p.movePlatform(progress);
    p.drawPlatform();
  }
    
  if(progress>=nextPlat)
  {
    float randY = random(100, height-150);
    nextPlat = progress+random(150,600);
    nextCrystal--;
    nextWeb--;
    plats.add( new Platform(progress+width+300,randY,random(250,400)) );
    if(nextCrystal<=0)
    {
      //Old version: random crystal, more likely to be lower numbered (rolls with disadvantage)
      //bling.add( new Crystal(progress+width+300,randY-75, min( int(random(6)),int(random(6)) ) ) );
      
      //New version: advances to next color unless collected, in which case the sequence resets
      bling.add( new Crystal( progress+width+300, randY-75, nextCrystalType ) );
      
      nextCrystalType++; //Advance next crystal to next type
      if( ( nextCrystalType>=5 && runMan.blings[5] >= 5 )
       || nextCrystalType>=6
       || nextCrystalType>=4 && display.fullyUpgraded() ) //Cycle back to blue
        nextCrystalType=0;
        
      nextCrystal = random(10,min(10,25-runMan.blings[5]*3));
    }
    if(nextWeb<=0)
    {
      webs.add( new Web( progress+width+300, randY+plats.get(plats.size()-1).size/2, plats.get(plats.size()-1).size*.45 ) );
      nextWeb = random(5,max(10,(50-millis()/5000)));
      println("WEB: " + nextWeb);
    }
  }
  
  for( int i = 0; i < plats.size(); i++)
  {
    if( plats.get(i).goneTooFar() )
    {
      plats.remove(i);
      i--;
    }
  }
}

void handleJumper()
{
  runMan.drawJumper();
  runMan.moveJumper();
}

void handleCrystals()
{
  for(Crystal c: bling)
  {
    c.moveCrystal(progress);
    c.drawCrystal();
  }
  
  collectCrystal();
}

void handleWebs()
{
  for(int i = 0; i < webs.size(); i++)
  {
    webs.get(i).drawWeb();
    webs.get(i).moveWeb(progress);
  }
  if(playerInAWeb())
    runMan.webbed = true;
  else
    runMan.webbed = false;
}

void handleFlyers()
{
  for(Flyer f: flyers)
  {
    f.drawFlyer();
    f.moveFlyer(progress);
    if(f.recentlyStolen)
      f.thiefReset();
  }
  
  for(int i = 0; i < flyers.size(); i++)
  {
    if( flyers.get(i).active == false )
    {
      flyers.remove(i);
      i--;
    }
  }
    
  if(progress>=nextFlyer)
  {
    nextFlyer = progress+random(3000,max(4000,20000-millis()/5000));
    flyers.add( new Flyer(progress+width+100, random(height/2), 50 ) );
    println("FLYER: " + nextFlyer);
  }
}

void handleLasers()
{
  for( int i = 0; i < beams.size(); i++ )
  {
    for( int j = 0; j < flyers.size(); j++ )
    {
      //right-facing laser
      if( beams.get(i).shotRight && flyers.get(j).x-flyers.get(j).offset > width/2 && dist( 0, beams.get(i).y, 0, flyers.get(j).y ) < beams.get(i).laserTimer/2+display.powerLevel[0]*20 )
      {
        booms.add( new Explosion( flyers.get(j).x-flyers.get(j).offset, flyers.get(j).y ) );
        flyers.remove(j);
        j--;
      }
      //left-facing laser
      else if( !beams.get(i).shotRight && flyers.get(j).x-flyers.get(j).offset < width/2 && dist( 0, beams.get(i).y, 0, flyers.get(j).y ) < beams.get(i).laserTimer/2+display.powerLevel[0]*20 )
      {
        booms.add( new Explosion( flyers.get(j).x-flyers.get(j).offset, flyers.get(j).y ) );
        flyers.remove(j);
        j--;
      }
    }
    if(beams.get(i).drawLaser())
    {
      beams.remove(i);
      i--;
    }
  }
}

void handleExplosions()
{
  for( int i = 0; i < booms.size(); i++ )
  {
    if( booms.get(i).drawExplosion() )
    {
      booms.remove(i);
      i--;
    }
  }
}

void handleWarpTrails()
{
  for(int i = 0; i < trails.size(); i++)
  {
    if(trails.get(i).drawTrail(progress))
    {
      trails.remove(i);
      i--;
    }
  }
}

void handleGhostCrystals()
{
  for( int i = 0; i < ghosts.size(); i++ )
  {
    ghosts.get(i).moveGCrystal();
    if( ghosts.get(i).vanish <= 0 )
    {
      ghosts.remove(i);
      i--;
    }
  }
}

void handleChomper()
{
  chomp.moveChomper(progress);
  chomp.drawChomper();
  
  if( (dist(runMan.x+width/2,runMan.y,chomp.x,chomp.y) <= 100) || runMan.x+width/2 < chomp.x )
  {
    biteSound.play();
    noLoop();
  }
}

boolean playerInAWeb()
{
  for( Web w: webs )
  {
    if( w.playerStuck() )
      return true;
  }
  return false;
}
 
void collectCrystal()
{
  for(int i = 0; i < bling.size(); i++)
  {
    if( dist( width/2, runMan.y, bling.get(i).x-bling.get(i).offset, bling.get(i).y ) < 50 )
    {
      crystalSound.play();
      runMan.blings[bling.get(i).type]++;
      if(bling.get(i).type == 5)
        text = new GhostWords(5,0);
      if(bling.get(i).type<3)
        runMan.blings[bling.get(i).type] += display.powerLevel[bling.get(i).type]; //bonus crystals for powerups
      bling.remove(i);
      nextCrystalType = 0; //Reset crystal sequence
    }
  }
}
 
void setupSounds()
{
  jumpSound = new SoundFile(this, "jump.mp3");
  laserSound = new SoundFile(this, "laser.wav");
  speedSound = new SoundFile(this, "speed.wav");
  flyerBumpSound = new SoundFile(this, "bump.mp3");
  crystalSound = new SoundFile(this, "crystal.mp3");
  upgradeSound = new SoundFile(this, "upgrade.wav");
  biteSound = new SoundFile(this, "bite.mp3");
  clickSound = new SoundFile(this, "click.wav");
  popSound = new SoundFile(this, "pop.wav");
  
  jumpSound.amp(0.1);
  laserSound.amp(0.1);
  speedSound.amp(0.1);
  crystalSound.amp(0.1);
  flyerBumpSound.amp(0.1);
  upgradeSound.amp(0.1);
  biteSound.amp(0.5);
  clickSound.amp(0.07);
  popSound.amp(0.1);
}
 
void keyPressed()
{
  if( keyCode == UP )
    runMan.jump(true);
  if( keyCode == RIGHT )
    runMan.runRight(true);
  if( keyCode == LEFT )
    runMan.runLeft(true);
    
  if( ( key == 'a' || key == 'A' ) && runMan.blings[0] > 0 )
  {
    beams.add( new Laser( width/2, runMan.y, runMan.facingRight ) );
    laserSound.play();
    if( !runMan.facingRight && display.powerLevel[0]>0 )
      chomp.slowDown();
    runMan.blings[0]--;
  } 
  
  if( ( key == 's' || key == 'S' ) && runMan.blings[1] > 0 )
  {
    trails.add( new WarpTrail( width/2, runMan.y, 500+display.powerLevel[1]*250 ) );
    runMan.x+=500+display.powerLevel[1]*250;
    runMan.ySpeed = min(0,runMan.ySpeed);
    popSound.play();
    runMan.blings[1]--;
    if(display.powerLevel[1]>0)
      runMan.boost(50*display.powerLevel[1]);
  } 
  
  if( ( ( key == 'd' || key == 'D' ) && !runMan.boosted ) && runMan.blings[2] > 0 )
  {
    runMan.boost();
    runMan.blings[2]--;
    speedSound.play();
  } 
  
  if( ( key == 'f' || key == 'F' ) && runMan.blings[3] > 0 )
  {
    runMan.blings[3]--;
    if(runMan.blings[0]<=runMan.blings[1] && runMan.blings[0]<=runMan.blings[2])
    {
      runMan.blings[0]+=3;
      text = new GhostWords("Lasers replenished!");
    }
    else if( runMan.blings[1] <= runMan.blings[2] )
    {
      runMan.blings[1]+=3;
      text = new GhostWords("Warps replenished!");
    }
    else
    {
      runMan.blings[2]+=3;
      text = new GhostWords("Boosts replenished!");
    }
    crystalSound.play();
  } 
  
  if( ( key == 'g' || key == 'G' ) && runMan.blings[4] > 0 )
  {
    runMan.blings[4]--;
    upgradeSound.play();
    if(!display.upgradesFinished)
      display.powerLevel[display.upgradeChoice]++;
    else
    {
      runMan.blings[5]++;
      text = new GhostWords(5,0);
    }
    if(display.upgradeChoice<3)
      text = new GhostWords(display.upgradeChoice,display.powerLevel[display.upgradeChoice]);
    display.cycleUpgradeChoice();
  }  
  
  if( ( key == 'v' || key == 'V' ) && runMan.blings[4] > 0 )
  {
    clickSound.play();
    display.cycleUpgradeChoice();
  }
}

void keyReleased()
{
  if( keyCode == UP )
    runMan.jump(false);
  if( keyCode == RIGHT )
    runMan.runRight(false);
  if( keyCode == LEFT )
    runMan.runLeft(false);
}

void mousePressed()
{
  println(mouseX+" "+mouseY);
}

//File I/O examples for highscore - currently not implemented
/*
void draw() {
  point(mouseX, mouseY);
  output.println(mouseX + "\t" + mouseY); // Write the coordinate to the file
}

void keyPressed() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}



void setup() {
  size(100, 100);
  parseFile();
}

void parseFile() {
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("highscore.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, TAB);
      int x = int(pieces[0]);
      int y = int(pieces[1]);
      point(x, y);
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
} 
*/
