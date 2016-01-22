public abstract class Node {
  float x, y, z, a;

  Node(float xcor, float ycor, float zcor, float amplitude) {
    x = xcor;
    y = ycor;
    z = zcor;
    a = amplitude;
  }

  abstract void move();
  abstract void display();

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  
  float getZ() {
    return z;
  }
  
  void setZ(float zcor) {
    z = zcor;
  }
}