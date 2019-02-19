class UI {
  ArrayList<Element> elements = new ArrayList();
  float w;
  float x;
  float y;
  float h;
  float line_height;
  float margin;
  Frame active_frame;
  
  void style() {
     margin = 16;
     w = width * 3/8;
     x = width - w - margin;
     y = height - h - margin;
     line_height = 1.5*em;
  }

  void render() {
    h = (margin + line_height) * elements.size() + margin;
    style();
    rectMode(CORNER);
    fill(20);
    strokeWeight(1);
    stroke(255);
    rect(x, y, w, h, em/2);
    for (int i = 0; i < elements.size(); i++) {
      Element elem = elements.get(i);
      elem.place(x + margin, y + margin + (line_height + margin)*i, w-2*margin, line_height);
      elem.render();
    }
  }
  
  void push(Element elem) {
    elements.add(elem);
  }
}
