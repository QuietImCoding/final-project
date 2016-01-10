//ArrayList<RadialNode> nodes;
//RadialNode[][] radial;
import ddf.minim.*;

Minim minim;
AudioPlayer groove;
CircleNode[] circles;

void setup() {
  fullScreen(P3D);
  //size(500,500,P3D);
  rectMode(CENTER);
  minim = new Minim(this);
  groove = minim.loadFile("hello.mp3", width/4);
  groove.loop();
  circles = new CircleNode[width/4];
  for (int r = 0; r < circles.length; r++) {
    circles[r] = new CircleNode(r * 4, 0, width/16, r * 10);
  }
   /* Uses 2d array of RadialNodes
  radial = new RadialNode[360][40];
  for (int a = 0; a < radial.length; a++) {
    for (int r = 0; r < radial[0].length; r++) {
      radial[a][r] = new RadialNode(a, r*4, 0, 10, r*10);
    }
  }*/
  /* Uses ArrayList of RadialNodes
  nodes = new ArrayList<RadialNode>();
  for (int a = 0; a < 360; a++) {
    for (int r = 0; r < 40; r++) {
      nodes.add(new RadialNode(a, r * 4, 0, 10, r*10));
    }
  }*/
}

void draw() {
  lights();
  background(100 * groove.mix.get(groove.bufferSize()/2), 0, 50);
  //background(0);
  camera(width - mouseX, mouseY/2, (height/2) / tan(PI/8), width/2, height/2, 0, 0, 1, 0);
  rotateX(PI/4);
  /* Uses ArrayList of RadialNodes
  for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).move(.5);
      nodes.get(i).display();
  }                                        */
  /* Uses 2d array of RadialNodes
  for (int a = 0; a < radial.length; a++) {
    for (int r = 0; r < radial[0].length; r++) {
      radial[a][r].move();
      radial[a][r].display();
    }
  }                                        */
  for (int r = 0; r < circles.length; r++) {
    circles[r].move(groove.mix.get(r));
    circles[r].display();
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