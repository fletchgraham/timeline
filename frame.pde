import java.util.UUID; 

class Frame {
  int start, stop;
  float x1, x2;
  boolean selected;
  String client;
  String project;
  String task;
  String uuid;
  int h = 105, s = 0, b = 255;

  Frame(float x1_, int y1_, float x2_, int y2_) {
    x1 = x1_/width;
    start = ep(y1_);
    x2 = x2_/width;
    stop = ep(y2_);
    selected = true;
    client = "Client";
    project = "Project";
    task = "Task";
    UUID myID = UUID.randomUUID();
    uuid = myID.toString();
  }

  Frame(JSONObject json) {
    x1 = json.getFloat("x1");
    x2 = json.getFloat("x2");
    start = json.getInt("start");
    stop = json.getInt("stop");
    client = json.getString("client");
    project = json.getString("project");
    task = json.getString("task");
    if (task == null) {
      task = "";
    }
    selected = false;
  }

  void setColor(int h_, int s_, int b_) {
    h = h_;
    s = s_;
    b = b_;
  }
  
  void setColor(color col) {
    h = (int)hue(col);
    s = (int)saturation(col);
    b = (int)brightness(col);
  }
  
  String over(int x, int y) {
    int thresh = 5;
    if ((x1*width < x && x < x2*width) && (px(stop)-thresh < y && y < px(stop)+thresh)) {
      return "top";
    }
    else if ((x1*width < x && x < x2*width) && (px(start)-thresh < y && y < px(start)+thresh)) {
      return "bottom";
    }
    else if ((x1*width-thresh < x && x < x1*width+thresh) && (px(stop) < y && y < px(start))) {
      return "left";
    }
    else if ((x2*width-thresh < x && x < x2*width+thresh) && (px(stop) < y && y < px(start))) {
      return "right";
    }
    else if ((x1*width < x && x < x2*width) && (px(stop) < y && y < px(start))) {
      return "middle";
    }
    else {
      return "none";
    }
  }

  void flipflop() {
    // make sure x1 < x2 and start < stop
    if (x2 < x1) {
      float tmp = x2;
      x2 = x1;
      x1 = tmp;
    }
    if (stop < start) {
      int tmp = stop;
      stop = start;
      start = tmp;
    }
  }

  void update_corner(float x2_, int y2_) {
    x2 = x2_/width;
    stop = ep(y2_);
  }

  int duration() {
    return stop - start;
  }

  int tall() {
    return px(start) - px(stop);
  }

  float wide() {
    return (x2*width - x1*width);
  }

  void render() {
    float pad = em/2;
    if (selected) {
      stroke(255);
      strokeWeight(1);
    } else {
      noStroke();
    }
    fill(h, s, b);
    rectMode(CORNERS); 
    rect(x1*width, px(start), x2*width, px(stop), em/2);

    if ((tall() > em + pad) || (selected)) {
      fill(255);
      textAlign(LEFT);
      textSize(em);
      text(client + ", " + project + ", " + task, x1 * width + pad, px(start)-pad);
    }
  }
}
