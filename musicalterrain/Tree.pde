public class Tree extends Node{
 float h;
 //float[][] treePoints;
 PShape t;
 
 Tree(float x,float y,float z,float h) {
  super(x, y, z, h);
 }
 
 void move() {  
 }
 
 void display() {
 }
 
 void display(float size) {
   strokeWeight(5);
   stroke(255);
   //line(x, y, z, x, y, z+50);
   pushMatrix();
   scale(1, 1, size);
   translate(2*x,2*y,z+5);
   shape(t,0,0);
   //ellipse( 0,0,1,1);
   popMatrix();
   noStroke();
 }
}