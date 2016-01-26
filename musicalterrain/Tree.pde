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
   strokeWeight(5);
   stroke(255);
   fill(0,255,0);
   //line(x, y, z, x, y, z+50);
   pushMatrix();
   translate(2*x,2*y,z+5);
   shape(t,0,0);
   //ellipse( 0,0,1,1);
   popMatrix();
   noStroke();
 }
}