//Shold have made these scalable from the start

class Crystal
{
  float x, y, offset;
  int type;
  
  public Crystal( float x, float y, int t )
  {
    this.x = x;
    this.y = y;
    this.type = t;
  }
    
  void moveCrystal( float amount )
  {
    offset = amount;
  }
  
  public void drawCrystal()
  {
    stroke( colorByType(200) );
    strokeWeight(1);
    fill( colorByType(150) );
    translate(x-offset,y);
    beginShape();
    vertex(-18,-9);
    vertex(-9,-18);
    vertex(9,-18);
    vertex(18,-9);
    vertex(18,9);
    vertex(9,18);
    vertex(-9,18);
    vertex(-18,9);
    vertex(-18,-9);
    endShape();
    fill( colorByType(50) );
    beginShape();
    vertex(-10,-4);
    vertex(-4,-10);
    vertex(4,-10);
    vertex(10,-4);
    vertex(10,4);
    vertex(4,10);
    vertex(-4,10);
    vertex(-10,4);
    vertex(-10,-4);
    endShape();
    line(-18,-9,-10,-4);
    line(-9,-18,-4,-10);
    line(9,-18,4,-10);
    line(18,-9,10,-4);
    line(18,9,10,4);
    line(9,18,4,10);
    line(-9,18,-4,10);
    line(-18,9,-10,4);
    line(-18,-9,-10,-4);
    translate(-(x-offset),-y);
  }
  
  void drawSmallCrystal()
  {
    stroke( colorByType(200) );
    strokeWeight(1);
    fill( colorByType(150) );
    translate(x,y);
    beginShape();
    vertex(-9,-4.5);
    vertex(-4.5,-9);
    vertex(4.5,-9);
    vertex(9,-4.5);
    vertex(9,4.5);
    vertex(4.5,9);
    vertex(-4.5,9);
    vertex(-9,4.5);
    vertex(-9,-4.5);
    endShape();
    fill( colorByType(50) );
    beginShape();
    vertex(-5,-2);
    vertex(-2,-5);
    vertex(2,-5);
    vertex(5,-2);
    vertex(5,2);
    vertex(2,5);
    vertex(-2,5);
    vertex(-5,2);
    vertex(-5,-2);
    endShape();
    line(-9,-4.5,-5,-2);
    line(-4.5,-9,-2,-5);
    line(4.5,-9,2,-5);
    line(9,-4.5,5,-2);
    line(9,4.5,5,2);
    line(4.5,9,2,5);
    line(-4.5,9,-2,5);
    line(-9,4.5,-5,2);
    line(-9,-4.5,-5,-2);
    translate(-(x),-y);
  }
  
  void drawLightBlue( float xPos, float yPos )
  {
    push();
    stroke( 100,255,255,200 );
    strokeWeight(1);
    fill( 100,255,255,150 );
    translate(xPos,yPos);
    beginShape();
    vertex(-9,-4.5);
    vertex(-4.5,-9);
    vertex(4.5,-9);
    vertex(9,-4.5);
    vertex(9,4.5);
    vertex(4.5,9);
    vertex(-4.5,9);
    vertex(-9,4.5);
    vertex(-9,-4.5);
    endShape();
    fill( 100,255,255,50 );
    beginShape();
    vertex(-5,-2);
    vertex(-2,-5);
    vertex(2,-5);
    vertex(5,-2);
    vertex(5,2);
    vertex(2,5);
    vertex(-2,5);
    vertex(-5,2);
    vertex(-5,-2);
    endShape();
    line(-9,-4.5,-5,-2);
    line(-4.5,-9,-2,-5);
    line(4.5,-9,2,-5);
    line(9,-4.5,5,-2);
    line(9,4.5,5,2);
    line(4.5,9,2,5);
    line(-4.5,9,-2,5);
    line(-9,4.5,-5,2);
    line(-9,-4.5,-5,-2);
    pop();
  }
  
  void drawSmallCrystal( float xPos, float yPos, int t)
  {
    stroke( colorByType(t,150) );
    strokeWeight(1);
    fill( colorByType(t,100) );
    translate(xPos,yPos);
    beginShape();
    vertex(-9,-4.5);
    vertex(-4.5,-9);
    vertex(4.5,-9);
    vertex(9,-4.5);
    vertex(9,4.5);
    vertex(4.5,9);
    vertex(-4.5,9);
    vertex(-9,4.5);
    vertex(-9,-4.5);
    endShape();
    fill( colorByType(t,25) );
    beginShape();
    vertex(-5,-2);
    vertex(-2,-5);
    vertex(2,-5);
    vertex(5,-2);
    vertex(5,2);
    vertex(2,5);
    vertex(-2,5);
    vertex(-5,2);
    vertex(-5,-2);
    endShape();
    line(-9,-4.5,-5,-2);
    line(-4.5,-9,-2,-5);
    line(4.5,-9,2,-5);
    line(9,-4.5,5,-2);
    line(9,4.5,5,2);
    line(4.5,9,2,5);
    line(-4.5,9,-2,5);
    line(-9,4.5,-5,2);
    line(-9,-4.5,-5,-2);
    translate(-(xPos),-yPos);
  }
  
  //void coverHealthCrystal()
  //{
  //  translate(x,y);
  //  rotate(PI*1.5);
  //  noStroke();
  //  fill(0);
  //  arc(0,0,50,50,0, ((2*PI)/runMan.maxHealth*(runMan.maxHealth-runMan.health)));
  //  rotate(-(PI*1.5));
  //  translate(-x,-y);
  //}
  
  public color colorByType( int trans )
  {
    switch(type)
    {
      case 0:
        return color(100,100,255,trans);
      case 1:
        return color(255,100,100,trans);
      case 2:
        return color(100,255,100,trans);
      case 3:
        return color(255,255,100,trans);
      case 4:
        return color(255,100,255,trans);
      case 5:
        return color(100,255,225,trans);
      case 99:
        switch( runMan.maxHealth )
        {
          case 4:
            return color(100,100,255,trans);
          case 5:
            return color(255,100,100,trans);
          case 6:
            return color(100,255,100,trans);
          case 7:
            return color(255,255,100,trans);
          case 8:
            return color(255,100,255,trans);
          case 9:
            return color(100,255,225,trans);
        }
      default:
        return color(255,trans);
    }
  }
  
  public color colorByType( int crysType, int trans )
  {
    switch(crysType)
    {
      case 0:
        return color(100,100,255,trans);
      case 1:
        return color(255,100,100,trans);
      case 2:
        return color(100,255,100,trans);
      case 3:
        return color(255,255,100,trans);
      case 4:
        return color(255,100,255,trans);
      case 5:
        return color(100,255,225,trans);
      default:
        return color(255,trans);
    }
  }
}
