public class Crawler extends Node{
 float x, y, z;
 
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
 
 void moveZ(float z) {
   this.z = z;
 }

 
 //int getX() {
 //  return (int)x;
 //}
 
 //int getY() {
 //  return (int)y;
 //}
 
 //float getZ() {
 //  return (int)z;
 //}
}