int a, b, d;

Date now = new Date();
int off = (int) (now.getTime() / 1000);

//zoom factor:
float z = 100.00;

//save location
String saveLocation = "data/frames.json";

// grab navigation:
void mousePressed() {
  if (editingClient || editingProject) {
   editingClient = false;
   editingProject = false;
  }
  if (mouseButton == RIGHT) {
    frames.newFrame(mouseX, mouseY, mouseX, mouseY);
  } else {
    b=mouseY;
    a = off;
  }
  if (mouseButton == LEFT) {
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.over(mouseX, mouseY)) {
        f.selected = true;
      } else { 
        f.selected = false;
      }
    }
  }
}

void mouseDragged() {

  if (mouseButton == RIGHT) {
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.selected)
        f.update_corner(mouseX, mouseY);
    }
  } else {
    d=(int)((float)(mouseY-b)*z);
    off = a + d;
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.selected) {
        f.flipflop();
      }
    }
    frames.saveJSON(saveLocation);
  }
}


// zooom:
void mouseWheel(MouseEvent event) {
  int s = event.getCount();

  // scrolling up = zooming in:
  if (s < 0 && z > 10) {
    z = z * .9;
  } 
  // scrolling down = zooming out:
  else if (s >= 0 && z < 1200) {
    z = z * 1.1;
  }
}

void handleEdits() {
  
  Frame f = frames.selection();
  
  if (!(editingClient || editingProject)){
    editingClient = true;
    txt1.label = "Edit Client:";
    txt1.textbox = f.client;
  } else if (editingClient) {
    editingClient = false;
    frames.selection().client = txt1.textbox;
    frames.saveJSON("data/frames.json");
    txt1.label = "Edit Project:";
    txt1.textbox = f.project;
    editingProject = true;
  } else if (editingProject) {
    editingProject = false;
    f.project = txt1.textbox;
    frames.saveJSON("data/frames.json");
  }
}

void keyPressed() {

  if (key == ENTER && frames.selection() != null) {
    handleEdits();
  }

  if (editingClient || editingProject) {
    txt1.update(key);
  } else {
    if (key == '=' && font_size != 32) {
      font_size++;
    } else if (key == '-' && font_size != 5) {
      font_size--;
    } else if (key == DELETE || key == BACKSPACE) {
      frames.deleteSelected();
      frames.saveJSON(saveLocation);
    } else if (keyCode == 17) {
      show_spectrum = true;
    }
  }
}

void keyReleased() {
  if (keyCode == 17) {
    frames.saveColors("data/colors.json");
    show_spectrum = false;
  }
  if (key == '=' || key == '-') {
    prefs.setInt("font_size", font_size);
    saveJSONObject(prefs, "data/prefs.json", "indent=1");
  }
}
