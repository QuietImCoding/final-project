ArrayList<Node> river;

void setup() {
  size(500,500);
  background(40, 150, 5);
  river = new ArrayList<Node>();
}

void draw() {
   river.add(new Node(0, 500, 250));
   for ( int i = 0; i < river.size(); i++) {
     river.get(i).display();
     river.get(i).move();
     if (river.get(i).getX() > width) {
       river.remove(i);
     }
   }
}
