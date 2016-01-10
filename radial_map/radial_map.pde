RadialNode[][] nodes;
float angle;
float distZ;
float look;

void setup() {
  size(500, 500, P3D);
  //frameRate(40);
  look = 0;
  angle = 0;
  nodes = new RadialNode[60][50];
  for (int a = 0; a < nodes.length; a++) {
    for (int r = 0; r < nodes[0].length; r++) {
      nodes[a][r] = new RadialNode(a * 6, r , 0, 100, angle);
      angle += 2;
    }
  }
  distZ = (height/2) / tan(PI/8);
  //surface.setResizable(true);
}

void draw() {
  background(255);
  ambientLight(255, 255, 255);
  //translate(width/16, height/4, -500 * cos(radians(60)));
  pushMatrix();
  camera(width/2 - mouseX, height / 2, distZ, width/2 + look, height - mouseY, 0, 0, 1, 0);
  drawGrid();
  popMatrix();
  if (keyPressed) {
    if (key == 'w') {
      distZ-=height/50;
    }
    if (key == 's') {
      distZ+=height/50;
    }
    if (key == 'a') {
      look-=width/50;
    }
    if (key == 'd') {
      look+=width/50;
    }
  }
}

void drawGrid() {
  //rotateX(PI/2.5);
  scale(2);
  for (int a = 0; a < nodes.length; a++) {
    for (int r = 0; r < nodes[0].length; r++) {
      nodes[a][r].move();
      nodes[a][r].display();
    }
  }
}