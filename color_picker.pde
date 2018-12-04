class ColorPicker {   
  void render(int x1, int y1, int x2, int y2) {
    //colorMode(HSB);
    for (int y = y1; y < y2; y++) {
      for (int x = x1; x < x2; x++) {
        int h = 255 * (x - x1) / (x2 - x1);
        int s = 255 * (y - y1) / (y2/2 - y1);
        int b = 255 * (y - y2) / (y1 - y2/2);
        try {
        set(x, y, color(h, s, b));
        }
        catch (Exception e) {
        }
      }
    }
  }
}
