class UI {
  ArrayList<Element> elements = new ArrayList();
  float w;
  float x;
  float y;
  float h;
  float line_height;
  float margin;
  
  void style() {
     margin = 16;
     w = 200;
     x = width - 2*margin - w;
     y = 0;
     line_height = 2*em;
  }

  void render() {
    style();
    for (int i = 0; i < elements.size(); i++) {
      Element elem = elements.get(i);
      elem.place(x + margin, margin + (line_height + margin)*i, w, line_height);
      elem.render();
    }
  }
  
  void push(Element elem) {
    elements.add(elem);
  }
}
