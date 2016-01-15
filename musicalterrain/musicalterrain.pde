import ddf.minim.*;

Minim minim;
AudioPlayer groove;
GridNode[][] nodes;
float angle;
float distZ;
boolean pauseDrawing;
Crawler crawl;

void setup() {
  //frameRate(30);
  size(500, 500, P3D);
  nodes = new GridNode[40][40];
  for (int x = 0; x < nodes.length; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      nodes[x][y] = new GridNode(x * 2, y * 2, 0, 60, angle);
      //angle+=5;
    }
  }
  crawl = new Crawler(20, 20, 0);
  pauseDrawing= false;
  minim = new Minim(this);
  groove = minim.loadFile("hello.mp3", 1600);
  groove.loop();
  distZ = (height/2) / tan(PI/8);
  surface.setResizable(true);
}

void draw() {
  background(0);
  lights();
  //ambientLight(255, 255, 255);
  //translate(width/16, height/4, -500 * cos(radians(60)));
  //camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  pushMatrix();
  camera(width - (mouseX * 2), height / 2 - mouseY, distZ, width/2, height/2, 0, 0, 1, 0);
  //scale(2);
  drawGrid();
  println(crawl.getX() + " " + crawl.getY() + " " + crawl.getZ());
  crawl.move(nodes[crawl.getX()][crawl.getY()].z);
  crawl.display();
  popMatrix();
  if (keyPressed) {
    if (key == 'w') {
      distZ-=height/50;
    }
    if (key == 's') {
      distZ+=height/50;
    }
  }
}

void drawGrid() {
  rotateX(PI/2.5);
  scale(width/100);

  for (int x = 0; x < nodes.length; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      if (groove.isPlaying() && ! pauseDrawing) {
        nodes[x][y].move(groove.mix.get(x + y)*.5);
      }
      nodes[x][y].display();
      averageValues();
    }
  }
  //connected them but its hard to tell if its working properly or not
  for (int x=0; x<nodes.length-1; x++) {
    for (int y=0; y<nodes[0].length-1; y++) {
      //stroke(10 * nodes[x][y].z, 120, 0);
      fill(10 * nodes[x][y].z, 120, 0);
      beginShape(TRIANGLE_FAN);
      vertex (nodes[x][y].x, nodes[x][y].y, nodes[x][y].z);
      vertex (nodes[x+1][y].x, nodes[x+1][y].y, nodes[x+1][y].z);
      vertex (nodes[x+1][y+1].x, nodes[x+1][y+1].y, nodes[x+1][y+1].z);
      vertex (nodes[x][y+1].x, nodes[x][y+1].y, nodes[x][y+1].z);
      endShape();
    }
  }
  noStroke();
  drawBorders();
  //drawWater();
  //text("(0,0", 0, 0);
  //text("(0,Max-Y)",nodes[0][0].x,nodes[nodes[0].length-1][nodes[0].length-1].y);
  //text("(Max-X, Max-Y)", nodes[nodes[0].length-1][0].x,nodes[nodes[0].length-1][nodes[0].length-1].y);
  //print (nodes[nodes[0].length-1][0].x);
  //println (nodes[0][nodes.length-1].y);
}

void averageValues() {
  for(int x = 0; x < nodes.length-1; x++) {
    for (int y = 0; y < nodes[x].length - 1; y++) { 
      if(x > 0 && y > 0) {
        nodes[x][y].z = (nodes[x + 1][y].z + nodes[x - 1][y].z + nodes[x][y + 1].z + nodes[x][y - 1].z) / 4;
      }
    }
  }      
}

void drawWater() {
  float alt = highestZ()- ((highestZ() + lowestZ())/2);
  if (highestZ()- lowestZ() > 10) {
    pushMatrix();
    fill(0, 0, 210);
    beginShape();
    vertex(nodes[0][0].x+1, nodes[0][0].y+1, lowestZ()+alt);
    vertex(nodes[0][0].x+1, nodes[nodes[0].length-1][nodes[0].length-1].y-1, lowestZ()+alt);
    vertex(nodes[nodes[0].length-1][nodes[0].length-1].x-1, nodes[nodes[0].length-1][nodes[0].length-1].y+1, lowestZ()+alt);
    vertex(nodes[nodes[0].length-1][nodes[0].length-1].x-1, nodes[0][0].y+1, lowestZ()+alt);
    endShape();
    // IGNORE. DOESNT WORK AS INTENDED
    //beginShape();
    //vertex(nodes[0][0].x+1, nodes[0][0].y+1, lowestZ()+alt);
    //vertex(nodes[0][0].x+1, nodes[0][0].y+1, lowestZ()-alt);
    //vertex(nodes[0][0].x+1, nodes[0][nodes.length-1].y+1, lowestZ()-alt);
    //vertex(nodes[0][0].x+1, nodes[0][nodes.length-1].y+1, lowestZ()+alt);
    //endShape();
    //beginShape();
    //vertex(nodes[0][nodes[0].length-1].x+1, nodes[0][nodes[0].length-1].y-1, lowestZ()+alt);
    //vertex(nodes[0][nodes[0].length-1].x+1, nodes[0][nodes[0].length-1].y-1, lowestZ()-alt);
    //vertex(nodes[0][nodes[0].length-1].x+1, nodes[nodes[0].length-1][nodes[0].length-1].y-1, lowestZ()-alt);
    //vertex(nodes[0][nodes[0].length-1].x+1, nodes[nodes[0].length-1][nodes[0].length-1].y-1, lowestZ()+alt);;
    //endShape();
    popMatrix();
  }
}


void drawBorders() {
  noStroke();
  drawBorder();
  drawBorder2();
  drawBorder3();
}

void drawBorder() {
  beginShape();
  vertex(nodes[0][0].x, nodes[0][0].y, nodes[0][0].z);
  vertex(0, 0, lowestZ()-15);
  vertex(0, nodes[0][nodes[0].length-1].y, lowestZ()-15    );
  vertex(nodes[0][0].x, nodes[0][nodes.length-1].y, nodes[0][nodes[0].length-1].z);
  for (int y=nodes.length-1; y>=0; y--) {
    vertex (nodes[0][y].x, nodes[0][y].y, nodes[0][y].z);
  }
  endShape();
}

void drawBorder2() {
  beginShape();
  vertex(nodes[0][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[nodes[0].length-1][nodes[0].length-1].z);
  vertex(nodes[0][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, lowestZ()-15);
  vertex(nodes[nodes[0].length-1][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, lowestZ()-15);
  vertex(nodes[nodes[0].length-1][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[nodes[0].length-1][nodes[0].length-1].z);
  for (int x=nodes.length-1; x>=0; x--) {
    vertex (nodes[x][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[x][nodes[0].length-1].z);
  }
  endShape();
}

void drawBorder3() {
  beginShape();
  vertex(nodes[nodes.length-1][nodes.length-1].x, nodes[nodes.length-1][nodes.length-1].y, nodes[nodes.length-1][nodes.length-1].z);
  vertex(nodes[nodes.length-1][nodes.length-1].x, nodes[nodes.length-1][nodes.length-1].y, lowestZ()-15);
  vertex(nodes[nodes.length-1][0].x, nodes[nodes.length-1][0].x, lowestZ()-15);
  vertex(nodes[nodes.length-1][0].x, nodes[nodes.length-1][0].y, nodes[nodes.length-1][0].z);
  for (int y=0; y<=nodes.length-1; y++) {
    vertex (nodes[nodes.length-1][y].x, nodes[nodes.length-1][y].y, nodes[nodes.length-1][y].z);
  }
  endShape();
}

void drawBorder4() {
  beginShape();
  vertex(nodes[0][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[nodes[0].length-1][nodes[0].length-1].z);
  vertex(nodes[0][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, lowestZ()-15);
  vertex(nodes[nodes[0].length-1][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, lowestZ()-15);
  vertex(nodes[nodes[0].length-1][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[nodes[0].length-1][nodes[0].length-1].z);
  for (int x=nodes.length-1; x>0; x--) {
    vertex (nodes[x][0].x, nodes[nodes[0].length-1][nodes[0].length-1].y, nodes[x][nodes[0].length-1].z);
  }
  endShape();
}


float lowestZ() {
  float lowest= nodes[0][0].z;
  for (int x=0; x<nodes.length-1; x++) {
    for (int y=0; y<nodes[0].length-1; y++) {
      if (nodes[x][y].z < lowest) {
        lowest = nodes[x][y].z;
      }
    }
  }
  return lowest;
}

float highestZ() {
  float highest= nodes[0][0].z;
  for (int x=0; x<nodes.length-1; x++) {
    for (int y=0; y<nodes[0].length-1; y++) {
      if (nodes[x][y].z > highest) {
        highest = nodes[x][y].z;
      }
    }
  }
  return highest;
}

//void gridBlur() {
//  for (int x = 0; x < nodes.length - 2; x++) {
//    for (int y = 0; y < nodes[0].length; y++) {
//      nodes[x][y].setZ((nodes[x][y].getZ() + nodes[x+1][y].getZ() + nodes[x+1][y].getZ()) / 3);
//    }
//  }
//}

void keyPressed() {
  if (key == ' ') {
    if (groove.isPlaying()) {
      groove.pause();
    } else {
      groove.play();
    }
  }
  if (key == 'c') {
    if (pauseDrawing) {
      pauseDrawing = false;
    } else {
      pauseDrawing = true;
    }
  }
}