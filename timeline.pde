import java.util.*;

JSONObject model;

Frames frames;
JSONObject prefs;
int em = 8;
ColorPicker color_picker;
boolean show_spectrum;
boolean editingClient;
boolean editingProject;
boolean first = true;
TextBox txt1;


// initiate UI:
UI ui;
Element client_indicator;

void setup() {
  size(600, 800);
  //pixelDensity(displayDensity());
  surface.setResizable(true);
  
  editingClient = false;
  editingProject = false;
  show_spectrum = false;
  colorMode(HSB);

  try {
    prefs = loadJSONObject("data/prefs.json");
    em = prefs.getInt("em");
  }
  catch (Exception e) {
    prefs = new JSONObject();
    println("no pref file.");
  }

  frames = new Frames();
  try {
    frames.loadJSON("data/frames.json");
  } 
  catch (Exception e) {
    println("no frames file yet");
  }
  frames.loadColors("data/colors.json");

  color_picker = new ColorPicker();
  
  txt1 = new TextBox("testing");
  
  // create UI:
  ui = new UI();
  client_indicator = new Element(ui);
  client_indicator.place(width - 216, 16, 200, 50);
}

void draw() {
  if (z < 10) {
    z = 10;
  } else if (z > 1200) {
    z = 1200;
  }
  
  background(0);
  draw_timeline();
  frames.render();
  draw_debug();
  if (editingClient || editingProject){
    txt1.setDims(width/2, height/4, width*.8);
    txt1.render();
  }
  
  // render UI:
  client_indicator.place(width - 216, 16, 200, 50);
  Frame f = frames.selection();
  if (f != null) {
    client_indicator.set_label(frames.selection().client);
  ui.render();
  }
  
  // pick color
  if (show_spectrum) {
    color_picker.render(10, 10, 400, 400);
    try {
      frames.mapColor(f.client, get(mouseX, mouseY));
    } 
    catch (Exception e) {
    }
  }
}
