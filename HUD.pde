//Upgrade tracker ended up in the HUD class
//not the best place for it

class HUD
{
  int reds, yellows, greens, blues, pinks, cyans;
  Crystal HUDCrystal = new Crystal(30,25,99);
  int upgradeChoice = 0;
  Crystal smallCrystal = new Crystal(1030, 865, upgradeChoice);
  int [] powerLevel = {0,0,0};
  //two levels per upgrade. once all have been taken, adds extra lives
  //1 - lasers per crystal
  //2 - distance warped
  //3 - duration and speed
  boolean upgradesFinished = false;
  
  void drawHUD()
  {
    //Draw Crystals collected
    HUDCrystal.drawCrystal();
    textSize(15);
    noStroke();
    fill(100,100,255,100);
    ellipse(30,60,10,10);
    ellipse(30,60,15,15);
    ellipse(30,60,20,20);
    fill(255);
    text(": " + runMan.blings[0],43,65);
    
    fill(255,100,100,100);
    ellipse(30,85,10,10);
    ellipse(30,85,15,15);
    ellipse(30,85,20,20);
    fill(255);
    text(": " + runMan.blings[1],43,90);
    
    fill(100,255,100,100);
    ellipse(30,110,10,10);
    ellipse(30,110,15,15);
    ellipse(30,110,20,20);
    fill(255);
    text(": " + runMan.blings[2],43,115);
    
    fill(255,255,100,100);
    ellipse(30,135,10,10);
    ellipse(30,135,15,15);
    ellipse(30,135,20,20);
    fill(255);
    text(": " + runMan.blings[3],43,140);
    
    fill(255,100,255,100);
    ellipse(30,160,10,10);
    ellipse(30,160,15,15);
    ellipse(30,160,20,20);
    fill(255);
    text(": " + runMan.blings[4],43,165);
    
    fill(100,255,255,100);
    ellipse(30,185,10,10);
    ellipse(30,185,15,15);
    ellipse(30,185,20,20);
    fill(255);
    text(": " + runMan.blings[5],43,190);
    
    //Draw powers with assigned keys
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(10,845,width-20,40);
    
    textSize(30);
    if(runMan.blings[0]>0)
    {
      fill(100,100,255);
      text("A - Laser", 15, 875);
      if(powerLevel[0]>0)
        smallCrystal.drawSmallCrystal(185,857,0);
      if(powerLevel[0]>1)
        smallCrystal.drawSmallCrystal(167,872,0);
      //185,855, 170,870
    }
    if(runMan.blings[1]>0)
    {
      fill(255,100,100);
      text("S - Warp", 215, 875);
      if(powerLevel[1]>0)
        smallCrystal.drawSmallCrystal(385,857,1);
      if(powerLevel[1]>1)
        smallCrystal.drawSmallCrystal(367,872,1);
      //385,855, 370,870
    }
    if(runMan.blings[2]>0)
    {
      fill(100,255,100);
      text("D - Boost", 415, 875);
      if(powerLevel[2]>0)
        smallCrystal.drawSmallCrystal(585,857,2);
      if(powerLevel[2]>1)
        smallCrystal.drawSmallCrystal(567,872,2);
    }
    if(runMan.blings[3]>0)
    {
      fill(255,255,100);
      text("F - Supply", 615, 875);
    }
    if(runMan.blings[4]>0)
    {
      fill(255,100,255);
      text("G - Upgrade", 815, 875);
      smallCrystal.drawSmallCrystal();
      drawIndicatorArrow(upgradeChoice);
      fill(255);
      textSize(12);
      text(":V",1043,870);
    }
    if(runMan.blings[5]>0)
    {
      //textSize(30);
      //fill(100,255,255);
      //text("Lives: "+runMan.blings[5], 1100, 875);
      for(int i = 0; i < runMan.blings[5]; i++)
        smallCrystal.drawLightBlue(1100+30*i,865);
    }
    
    //Lines between power prompts
    stroke(120);
    strokeWeight(3);
    if( runMan.blings[0]>0 && runMan.blings[1]>0 ) line(200,850,200,880);
    if( runMan.blings[1]>0 && runMan.blings[2]>0 ) line(400,850,400,880);
    if( runMan.blings[2]>0 && runMan.blings[3]>0 ) line(600,850,600,880);
    if( runMan.blings[3]>0 && runMan.blings[4]>0 ) line(800,850,800,880);
    if( runMan.blings[4]>0 && runMan.blings[5]>0 ) line(1075,850,1075,880);
    
    //Boss threat level
    textSize(25);
    fill(255);
    text("Score: "+ int(progress-500)/100,width-400,30);
    text("Distance from Chomper: "+ int((dist(runMan.x+625,runMan.y,chomp.x,chomp.y))),width-400,60);
  }
  
  void cycleUpgradeChoice()
  {
    if( powerLevel[0]==2 && powerLevel[1]==2 && powerLevel[2]==2 )
    {
      upgradeChoice = 5;
      upgradesFinished=true;
    }
    else
    {
      upgradeChoice++;
      while( upgradeChoice > 2 || powerLevel[upgradeChoice] == 2 ) //should not be infinte if the preceeding if() works
      {
        upgradeChoice++;
        if(upgradeChoice>2)
          upgradeChoice=0;
      }
    }
    smallCrystal.type = upgradeChoice;
  }
  
  void drawIndicatorArrow( int choice )
  {
    noStroke();
    fill(255,100,255,40);
    int mid = 100+choice*200;
    triangle(mid,840,mid-40,810,mid+40,810);
    triangle(mid,840,mid-34,815,mid+34,815);
    triangle(mid,840,mid-27,820,mid+27,820);
    triangle(mid,840,mid-21,825,mid+21,825);
    triangle(mid,840,mid-14,830,mid+14,830);
    //ellipse(100+choice*200,825,40,40);
  }
  
  boolean fullyUpgraded()
  {
    if( powerLevel[0]==2 && powerLevel[1]==2 && powerLevel[2]==2 && runMan.blings[5]>=5 )
      return true;
    return false;
  }
}
