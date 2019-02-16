class UI {
  ArrayList<Element> elements = new ArrayList();

  void render() {
    for (Element elem : elements) {
      elem.render();
    }
  }
  
  void push(Element elem) {
    elements.add(elem);
  }

  void draw_loop() {
    render();
  }
}
