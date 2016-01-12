import ddf.minim.*;

Minim minim;
AudioPlayer groove;
GridNode[][] nodes;
float angle;
float distZ;

void setup() {
  size(500, 500, P3D);
  nodes = new GridNode[50][50];
  for (int x = 0; x < nodes.length; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      nodes[x][y] = new GridNode(x * 2, y * 2, 0, 10, angle);
      //angle+=5;
    }
  }
  minim = new Minim(this);
  groove = minim.loadFile("hello.mp3", 250);
  groove.loop();
  distZ = (height/2) / tan(PI/8);
  surface.setResizable(true);
}

void draw() {
  background(0);
  //ambientLight(255, 255, 255);
  //translate(width/16, height/4, -500 * cos(radians(60)));
  //camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  pushMatrix();
  camera(width - (mouseX * 2), height / 2 - mouseY, distZ, width/2, height/2, 0, 0, 1, 0);
  drawGrid();
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
      nodes[x][y].move(groove.mix.get(x + y)*3);
      gridBlur();
      nodes[x][y].display();
    }
  }
  //connected them but its hard to tell if its working properly or not
  for (int x=0; x<nodes.length-1;x++){
   for (int y=0; y<nodes[0].length-1;y++){
     beginShape();
     vertex (nodes[x][y].x,nodes[x][y].y,nodes[x][y].z);
     vertex (nodes[x+1][y].x, nodes[x+1][y].y,nodes[x+1][y].z);
     vertex (nodes[x+1][y+1].x, nodes[x+1][y+1].y, nodes[x+1][y+1].z);
     vertex (nodes[x][y+1].x,nodes[x][y+1].y,nodes[x][y+1].z);
     endShape();
   } 
  }
}

void gridBlur() {
  for (int x = 0; x < nodes.length - 2; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      nodes[x][y].setZ((nodes[x][y].getZ() + nodes[x+1][y].getZ() + nodes[x+1][y].getZ()) / 3);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    if (groove.isPlaying()) {
      groove.pause();
    } else {
      groove.play();
    }
  }
}