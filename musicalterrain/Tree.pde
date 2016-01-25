public class Tree extends Node{
 float h;
 float[][] treePoints;
 
 Tree(float x,float y,float z,float h) {
  super(x, y, z, h);
 }
 
 void move() {  
 }
 
 void display() {
   strokeWeight(5);
   stroke(255);
   line(x, y, z, x, y, z+50);
   noStroke();
 }
}