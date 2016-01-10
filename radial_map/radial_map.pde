ArrayList<RadialNode> nodes;
RadialNode[][] radial;

void setup() {
  size(500,500,P3D);
  frameRate(90);
  radial = new RadialNode[360][40];
  for (int a = 0; a < radial.length; a++) {
    for (int r = 0; r < radial[0].length; r++) {
      radial[a][r] = new RadialNode(a, r*4, 0, 20, r*10);
    }
  }
  /*
  nodes = new ArrayList<RadialNode>();
  for (int a = 0; a < 360; a++) {
    for (int r = 0; r < 40; r++) {
      nodes.add(new RadialNode(a, r * 4, 0, 20, r*10));
    }
  }*/
}

void draw() {
  lights();
  background(255);
  camera(width - mouseX, mouseY/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  rotateX(PI/4);
  /*for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).move(.5);
      nodes.get(i).display();
  }*/
  for (int a = 0; a < radial.length; a++) {
    for (int r = 0; r < radial[0].length; r++) {
      radial[a][r].move();
      radial[a][r].display();
    }
  }
}