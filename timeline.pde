import java.util.*;

JSONObject model;

Frames frames;
JSONObject prefs;
int em = 8;
ColorPicker color_picker;
boolean show_spectrum;
boolean editingClient;
boolean editingProject;
String active_property;
boolean first = true;
TextBox txt1;


// initiate UI:
UI ui;
Property client_indicator;
Property project_indicator;
Property task_indicator;

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
  client_indicator = new Property(ui, "Client");
  project_indicator = new Property(ui, "Project");
  task_indicator = new Property(ui, "Task");
}

void draw() {
  if (z < 10) {
    z = 10;
  } else if (z > 1200) {
    z = 1200;
  }
  
  background(20);
  draw_timeline();
  frames.render();
  draw_debug();
  if (editingClient || editingProject){
    txt1.setDims(width/2, height/4, width*.8);
    txt1.render();
  }
  
  // render UI:
  
  Frame f = frames.selection();
  
  if (f != null) {
    ui.render();
  }
  
  // pick color
  if (show_spectrum) {
    color_picker.render(10, 10, 400, 400);
    if (f != null) {
      frames.mapColor(f.client, get(mouseX, mouseY));
    } 
  }
}
