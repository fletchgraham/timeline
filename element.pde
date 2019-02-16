class Element {
  UI parent;
  int row = 0;
  int col = 0;

  float x = 10;
  float y = 10;
  float w = 100;
  float h = 100;
  
  String label = "";

  Element(UI parent_) {
    parent = parent_;
    parent.push(this);
  }
  
  void place(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  void set_label(String label_) {
    label = label_;
  }

  PVector mouse_over() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      float x_percent = (mouseX - x)/ w;
      float y_percent = (mouseY - y)/ h;
      PVector coords_relative = new PVector(x_percent, y_percent);
      return coords_relative;
    } else {
      return null;
    }
  }

  void render() {

    if (mouse_over() == null) {
      fill(0);
    } else {
      fill(150);
    }
    stroke(255);
    strokeWeight(1);
    rectMode(CORNER);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(255);
    text(label, x, y, w, h);
  }
}
