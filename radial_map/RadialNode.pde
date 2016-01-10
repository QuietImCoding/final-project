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
    zcor = sin(radians(myangle * 3)) * amp;
    myangle += 30;
  }

  void move(float diff) {
    zcor = diff * amp;
  }


  void display() {
    stroke(sin(radians(angle)) * radius, cos(radians(radius)) * angle, zcor % 255);
    fill(sin(radians(angle)), cos(radians(radius)), zcor);
    pushMatrix();
    translate(width/2 + cos(radians(angle))*radius, height/2 + sin(radians(angle))*radius, zcor);
    ellipse(0, 0, 1, 1);
    popMatrix();
  }
}