import ddf.minim.*;

ArrayList<Tree> trees;
Minim minim;
AudioPlayer groove;
GridNode[][] nodes;
float angle;
float distZ;
boolean pauseDrawing;
Crawler crawl;
int avg = 0;
float moveX;
float moveY;

void setup() { 
  //frameRate(30);
  trees = new ArrayList<Tree>();
  size(500, 500, P3D);
  nodes = new GridNode[40][40];
  crawl = new Crawler(0, 0, 0,0);
  float moveX = crawl.getX();
  float moveY = crawl.getY();
  crawl.moveXY(40,40);
  for (int x = 0; x < nodes.length; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      nodes[x][y] = new GridNode(x * 2, y * 2, 0, 60);
    }
  }
  for (int i = 0; i < 10; i++) {
    trees.add(new Tree(random(40), random(40), 0, 10));
  }
    pauseDrawing= false;
    minim = new Minim(this);
    groove = minim.loadFile("insideout.mp3", 1600);
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
  camera(width - (mouseX *  2), height / 2 - mouseY, distZ, width/2, height/2, 0, 0, 1, 0);
  //scale(2);;
  drawGrid();
  text(0,nodes[0][0].x,nodes[0][0].y,nodes[0][0].z);
  text(1,nodes[nodes.length-1][nodes.length-1].x,nodes[nodes.length-1][nodes.length-1].y,nodes[nodes.length-1][nodes.length-1].z);
  text("-x",-25,0,0);
  text("-y",0,-25,0);
  moveTrees();
  //moveCrawler();
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

void moveCrawler(){
  int randRangeX = -1 + (int)(Math.random() * ((1 - (-1)) + 1));
  int randRangeY = -1 + (int)(Math.random() * ((1 - (-1)) + 1));
  crawl.display();
  if (moveX > nodes[0][0].x || moveX < nodes[nodes.length-1][nodes.length-1].x || moveY > nodes[0][0].y || moveY < nodes[nodes.length-1][nodes.length-1].y){ 
    moveX += randRangeX;
    moveY += randRangeY;
    crawl.moveXY(randRangeX,randRangeY);
    println("moveX:" + moveX + "," + "MoveY:" + moveY);
    //println("ok");
  }
  else{
    println("not ok");
  }
  crawl.moveZ(nodes[(int)crawl.getX()][(int)crawl.getY()].z);
 // println("("+ crawl.getX() + "," + crawl.getY() + ")");
}

void moveTrees() {
  for (int i = 0; i < trees.size(); i++) {
    trees.get(i).setZ(nodes[(int)(trees.get(i).x)][(int)(trees.get(i).y)].z);
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
    }
  }
  //averageValues();
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
  moveCrawler();
  noStroke();
  drawBorders();
  //drawWater();
}

void averageValues() {
  GridNode[][] temp = new GridNode[nodes.length][];
  for (int x=0; x<nodes.length; x++) {
    temp[x]=nodes[x].clone();
  }
  for (int x = 0; x < (nodes.length) - 1; x++) {
    for (int y = 0; y < (nodes[x].length) - 1; y++) { 
      if (x > 0 && y > 0) {
        nodes[x][y].z = (temp[x][y].z + ((temp[x + 1][y].z + temp[x - 1][y].z + temp[x][y + 1].z + temp[x][y - 1].z) / 4))/2;
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


void keyPressed() {
  if (key == ' ') {
    if (groove.isPlaying()) {
      groove.pause();
      // WORKS BUT NO ANIMATION
      for (int x=0; x<20; x++){
      averageValues();
      }
    } else {
      groove.play();
    }
  }
  if (key == 'c') {
    if (pauseDrawing) {
      pauseDrawing = false;
    } else {
      pauseDrawing = true;
            for (int x=0; x<20; x++){
      averageValues();
      }
    }
  }
}