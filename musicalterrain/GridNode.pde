public class GridNode extends Node {
  float dist;
  float xcor=x;
  float ycor=y;
  float zcor=z;
  
  GridNode(float xcor, float ycor, float zcor, float amplitude, float myangle) {
    super(xcor, ycor, zcor, amplitude, myangle);
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

  void display() {
    stroke(255 * sin(radians((x + y + z) / 3)), 255 * cos(radians((x + y + z) / 3)), 255 * tan(radians((x + y + z) / 3)));
    fill(255 *sin(radians((x + y + z) / 3 )), 255 * cos(radians((x + y + z) / 3 )), 255 * tan(radians((x + y + z) / 3)));
    pushMatrix();
    //box(5,5,10); this was a test to see the coordinates
    translate(x, y, z);
    ellipse(0, 0, 1, 1);
    xcor=x;
    ycor=y;
    zcor=z;
    popMatrix();
  }
}