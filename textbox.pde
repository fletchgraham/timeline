class TextBox {

  float x;
  float y;
  float w;
  String label;
  String textbox;
  int limit = 30;

  void update(char k) {
    if (k != ENTER) {
      if ( k == BACKSPACE && textbox.length() > 0) {
        textbox = textbox.substring(0, textbox.length() - 1);
      } else if (textbox.length() < 30 && k != SHIFT) {
        textbox = textbox + k;
      }
    }
  }

  void render() {
    stroke(255);
    strokeWeight(em/8);
    fill(20);
    rectMode(CENTER);
    rect(x, y, w, em*2);
    textAlign(CENTER, CENTER);
    fill(255);
    text(textbox, x, y - em/4);
    text(label, x, y - em*2);
  }

  void setDims(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
  }

  TextBox (String content) {
    textbox = content;
  }
}
