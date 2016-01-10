import ddf.minim.*;

Minim minim;
AudioPlayer groove;
GridNode[][] nodes;
float angle;
float rotx, roty;

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
  groove = minim.loadFile("turkishmarch.mp3", 250);
  //groove.play();
  surface.setResizable(true);
}

void draw() {
  background(50, 50, 255);
  ambientLight(255, 255, 255);
  translate(width/16, height/4, -500 * cos(radians(60)));
  //camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  pushMatrix();
  camera(width - mouseX, height / 2 - mouseY, (height/2) / tan(PI/8), width/2, height/2, 0, 0, 1, 0);
  drawGrid();
  popMatrix();
}

void drawGrid() {
  rotateX(PI/2.5);
  scale(width/100);
  for (int x = 0; x < nodes.length; x++) {
    for (int y = 0; y < nodes[0].length; y++) {
      nodes[x][y].move(groove.mix.get(x + y));
      nodes[x][y].display();     
    }
  }
}


void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
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