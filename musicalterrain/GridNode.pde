public class GridNode extends Node {
  float dist;
  
  GridNode(float xcor, float ycor, float zcor, float amplitude, float myangle) {
    super(xcor, ycor, zcor, amplitude, myangle);
    dist = 0;
  }

  void move() {
    z += sin(radians(2 * angle)) * a;
    angle += 30;
  }
  
  void move(float dist) {
    z = 2 * dist * a;
    this.dist = dist;
  }

  void display() {
    stroke(65, 100 * dist + 155, 0);
    stroke(65, 100 * dist + 155, 0);
    pushMatrix();
    translate(x, y, z);
    ellipse(0, 0, 1, 1);
    popMatrix();
  }
}