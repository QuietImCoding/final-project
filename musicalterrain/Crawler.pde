public class Crawler{
 float x, y, z;
 
 Crawler(float x,float y,float z) {
  this.x = x;
  this.y = y;
  this.z = z;
 }
 
 void display() {
   pushMatrix();
   rotateX(PI/2.5);
   translate(x, y, z);
   box(10);
   popMatrix();
 }
 
 void move(float z) {
   
   this.z = z;
 }

 
 int getX() {
   return (int)x;
 }
 
 int getY() {
   return (int)y;
 }
 
 float getZ() {
   return (int)z;
 }
}