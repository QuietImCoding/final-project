public class Crawler extends Node{
 float x, y, z;
 float moveX;
 float moveY;
 
 Crawler(float x,float y,float z, float amp) {
  super(x,y,z,amp);
 }
 
 void display() { 
   pushMatrix();
   translate(x, y, z);
   box(5);
   popMatrix();
 }
 
 void move() {
 }
 
 void moveXY(float xcor, float ycor){
   x +=xcor;
   y +=ycor;
 }
 
 void moveZ(float z) {
   this.z = z;
 }
}