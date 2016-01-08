public class Node {
  float x, y, a;
  
  Node(float xcor, float ycor, float amplitude) {
    x = xcor;
    y = ycor;
    a = amplitude;
  }
  
  void move() {
    x++;
    y = a * sin(radians(2 * x));
  }
  
  void display() {
    fill(0, 100, 255);
    stroke(0, 100, 255);
    ellipse(x, y, 10, 10);
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
}
