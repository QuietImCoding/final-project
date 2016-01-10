public abstract class Node {
  float x, y, z, a, angle;

  Node(float xcor, float ycor, float zcor, float amplitude, float myangle) {
    x = xcor;
    y = ycor;
    z = zcor;
    a = amplitude;
    angle = myangle;
  }

  abstract void move();
  abstract void display();

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
}