class GhostCrystal
{
  float x, y;
  float ySpeed;
  float vanish;
  int type;
  
  public GhostCrystal( float x, float y, int type )
  {
    this.x = x;
    this.y = y;
    this.type = type;
    ySpeed = -10;
    vanish = 255;
  }
  
  void moveGCrystal()
  {
    drawCrystal();
    x-=5;
    y+=ySpeed;
    ySpeed+=.5;
    vanish-=5;
  }
  
  public void drawCrystal()
  {
    stroke( colorByType(type,vanish*.8) );
    strokeWeight(1);
    fill( colorByType(type,vanish*.6) );
    translate(x,y);
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
    fill( colorByType(type,vanish*.2) );
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
    translate(-x,-y);
  }
  
  public color colorByType( int crysType, float trans )
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
