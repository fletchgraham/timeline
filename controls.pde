int a, b, d;

Date now = new Date();
int off = (int) (now.getTime() / 1000);

//zoom factor:
float z = 100.00;

//save location
String saveLocation = "data/frames.json";

String dragging = "none";

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
      if (f.over(mouseX, mouseY).equals("none")) {
        f.selected = false;
      } else { 
        f.selected = true;
        dragging = f.over(mouseX, mouseY);
      }
    }
  }
}

void mouseDragged() {
  Frame f = frames.selection();

  if (f==null || mouseButton == CENTER) {
    d=(int)((float)(mouseY-b)*z);
    off = a + d;
  } else if (mouseButton == RIGHT) {
    f.update_corner(mouseX, mouseY);
  } else {
    if (dragging.equals("top")) {
      f.stop = ep(mouseY);
    }
    if (dragging.equals("left")) {
      f.x1 = (float)mouseX/width;
    }
    if (dragging.equals("right")) {
      f.x2 = (float)mouseX/width;
    }
    if (dragging.equals("bottom")) {
      f.start = ep(mouseY);
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < frames.frames.size(); i++) {
    Frame f = frames.frames.get(i);
    f.flipflop();
  }
  if (mouseButton == RIGHT) {
    frames.saveJSON(saveLocation);
  }
  if (mouseButton == LEFT && frames.selection() != null) {
    frames.saveJSON(saveLocation);
  }
}


// zooom:
void mouseWheel(MouseEvent event) {
  int s = event.getCount();
  z = z + s*.1*z;
}

void handleEdits() {

  Frame f = frames.selection();

  if (!(editingClient || editingProject)) {
    editingClient = true;
    txt1.label = "Edit Client:";
    txt1.textbox = f.client;
    first = true;
  } else if (editingClient) {
    editingClient = false;
    frames.selection().client = txt1.textbox;
    frames.saveJSON("data/frames.json");
    txt1.label = "Edit Project:";
    txt1.textbox = f.project;
    editingProject = true;
    first = true;
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

  else if (editingClient || editingProject) {
    if (first) {
       txt1.textbox = "";
       first = false;
    }
    txt1.update(key);
  } else {
    if (key == '=' && em != 32) {
      em++;
    } else if (key == '-' && em != 5) {
      em--;
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
    prefs.setInt("em", em);
    saveJSONObject(prefs, "data/prefs.json", "indent=1");
  }
}
