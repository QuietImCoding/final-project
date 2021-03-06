public class GridNode extends Node implements Cloneable {
  float dist;

  GridNode(float xcor, float ycor, float zcor, float amplitude) {
    super(xcor, ycor, zcor, amplitude);
    dist = 0;
  }

  void move() {
    z += sin(radians(2 * angle)) * a;
    angle += 10;

  }

  void move(float dist) {
    z = 2 * dist * a;
    this.dist = dist;
  }

  protected Object clone() throws CloneNotSupportedException {
    return super.clone();
  }
  
  void display() {
    //stroke(255 * sin(radians((x + y + z) / 3)), 255 * cos(radians((x + y + z) / 3)), 255 * tan(radians((x + y + z) / 3)));
    //fill(255 *sin(radians((x + y + z) / 3 )), 255 * cos(radians((x + y + z) / 3 )), 255 * tan(radians((x + y + z) / 3)));
    fill(0, 210, 0); 
    pushMatrix();
    //box(5,5,10); this was a test to see the coordinates
    translate(x, y, z);
    popMatrix();
  }
}