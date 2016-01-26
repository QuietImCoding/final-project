public class Crawler extends Node{
 float x, y, z;
 float moveX;
 float moveY;
 float id; 
 PShape s;
 
 Crawler(float x,float y,float z, float amp, float id) {
  super(x,y,z,amp);
 }
 
 void display() { 
   fill(127 + sin(radians(id*id)),127 + tan(radians(id * id)), 127 + cos(radians(id * id))); 
   pushMatrix();
   translate(x, y, z);
   //box(5);
   shape(s,0,0);
   popMatrix();
   ;
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