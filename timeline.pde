import java.util.*;

JSONObject model;

Frames frames;
JSONObject prefs;
int font_size = 8;
ColorPicker color_picker;
boolean show_spectrum;
boolean editingClient;
boolean editingProject;
TextBox txt1;

void setup() {
  editingClient = false;
  editingProject = false;
  show_spectrum = false;
  colorMode(HSB);

  try {
    prefs = loadJSONObject("data/prefs.json");
    font_size = prefs.getInt("font_size");
  }
  catch (Exception e) {
    prefs = new JSONObject();
    println("no pref file.");
  }

  size(600, 800);
  //pixelDensity(displayDensity());
  surface.setResizable(true);

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
  txt1.setDims(20, 40, 300, 35);
}

void draw() {
  background(40);
  draw_timeline();
  frames.render();
  draw_debug();
  if (editingClient || editingProject){
    txt1.render();
  }
  
  // pick color
  if (show_spectrum) {
    color_picker.render(10, 10, 400, 400);
    Frame f = frames.selection();
    try {
      frames.mapColor(f.client, get(mouseX, mouseY));
    } 
    catch (Exception e) {
    }
  }
}
