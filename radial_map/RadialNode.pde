public class RadialNode {
  float angle, radius, zcor, amp, myangle;
  
  RadialNode(float angle, float radius, float zcor, float amplitude, float myangle) {
    this.angle = angle;
    this.radius = radius;
    this.zcor = zcor;
    this.amp = amplitude;
    this.myangle = myangle;
  }

  void move() {
    zcor = sin(radians(angle)) * amp;
    angle += 5;
  }
  

  void display() {
    stroke(0, 0, 1  * zcor);
    stroke(0, 0, 1  * zcor);
    pushMatrix();
    translate(height/2 + cos(radians(angle))*radius,height/2 + sin(radians(angle))*radius, zcor);
    ellipse(0, 0, 1, 1);
    popMatrix();
  }
}