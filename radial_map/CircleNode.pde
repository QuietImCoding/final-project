public class CircleNode {
  float radius, zcor, amp, myangle;

  CircleNode(float radius, float zcor, float amplitude, float myangle) {
    this.radius = radius;
    this.zcor = zcor;
    this.amp = amplitude;
    this.myangle = myangle;
  }

  void move() {
    zcor = sin(radians(myangle * 3)) * amp;
    myangle += 1;
  }

  void move(float diff) {
    zcor = diff * amp;
  }


  void display() {
    stroke(sin(radians(radius)), 0, 255 - zcor);
    noFill();
    //fill(radius * zcor, zcor * amp, 255 - zcor);
    pushMatrix();
    translate(width/2, height/2, zcor);
    rect(0, 0, radius, radius);
    popMatrix();
  }
}