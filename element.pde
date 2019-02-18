class Element {
  UI parent;

  float x = 10;
  float y = 10;
  float w = 100;
  float h = 100;

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
      noFill();
    } else {
      fill(80);
    }
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h, em/2);
  }
}

class Title extends Element {
  // like a header above a section of properties.
  String title = "";
  
  Title(UI parent_) {
    super(parent_);
  }
  
  void set_title(String title_) {
    title = title_; 
  }
  
  void render() {
    super.render();
    textAlign(CENTER, CENTER);
    fill(255);
    text(title, x+em, y, w-2*em, h);
  }
}

class Property extends Element {
  // a visual element that displays values of propertys for the current frame.
  String property = "";
  String value = "";
  
  Property(UI parent_, String property_) {
    super(parent_);
    property = property_;
  }
  
  void set_value(String value_) {
    value = value_; 
  }
  
  void render() {
    super.render();
    textAlign(LEFT, CENTER);
    fill(255);
    text(property + ":", x+em, y, w-2*em, h);
    textAlign(RIGHT, CENTER);
    text(value, x+em, y, w-2*em, h);
  }
  
}
