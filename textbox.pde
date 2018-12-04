class TextBox {

  int x;
  int y;
  int w;
  int h;
  String label;
  String textbox;
  int limit = 30;

  void update(char k) {
    if (k != ENTER) {
      if ( k == BACKSPACE && textbox.length() > 0) {
        textbox = textbox.substring(0, textbox.length() - 1);
      } else if (textbox.length() < 30) {
        textbox = textbox + k;
      }
    }
  }

  void render() {
    stroke(255);
    strokeWeight(font_size/8);
    fill(20);
    rectMode(CORNER);
    rect(x, y, w, font_size*2);
    textAlign(TOP);
    fill(255);
    text(textbox, x+20, y+20);
    text(label, x, y - 10);
  }

  void setDims(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  TextBox (String content) {
    textbox = content;
  }
}
