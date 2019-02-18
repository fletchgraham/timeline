import java.util.*;

JSONObject model;

Frames frames;
JSONObject prefs;
int em = 8;
ColorPicker color_picker;
boolean show_spectrum;
boolean editingClient;
boolean editingProject;
boolean editingTask;
String active_property;
boolean first = true;
TextBox txt1;

Current current;

// initilize UI:
UI ui;
Title report_header;
Property report_duration;

void setup() {
  size(800, 1000);
  //pixelDensity(displayDensity());
  surface.setResizable(true);
  
  editingClient = false;
  editingProject = false;
  editingTask = false;
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
  
  current = new Current();
  
  // create UI:
  ui = new UI();
}

void draw() {
  if (z < 10) {
    z = 10;
  } else if (z > 1200) {
    z = 1200;
  }
  
  background(20);
  draw_timeline();
  current.update();
  frames.render();
  draw_debug();
  if (editingClient || editingProject || editingTask){
    txt1.setDims(width/2, height/4, width*.8);
    txt1.render();
  }
  
  // render UI:
  ui.elements.clear();
  if (current.frame != null) {
    report_header = new Title(ui);
    report_duration = new Property(ui, "Total Duration");
    report_header.set_title(current.client() + " " + current.project() + " Report");
    for (String task : current.tasks()) {
      Property report_task = new Property(ui, task);
      report_task.set_value(current.task_duration(task));
    }
    report_duration.set_value(current.project_duration());
    ui.render();
  }
  
  // pick color
  if (show_spectrum) {
    color_picker.render(10, 10, 400, 400);
    if (current.frame != null) {
      frames.mapColor(current.client(), get(mouseX, mouseY));
    } 
  }
}
