// write debug info to the screen.

void draw_debug() {
  
  int margin = 20;
  fill(255);
  textSize(em);
  textAlign(RIGHT);
  text("zoom: " + z, width-margin, height - em * 4);
  //text("offset: " + off, width-margin, height - em * 3);
  //text("mouse timestamp: " + ep(mouseY), width-margin, height - em * 2);
  text("Project Duration: " + nf(frames.projectHours(), 1, 2), width-margin, height - em * 2); 
  
  Date mouse = new Date((long)ep(mouseY) * 1000);
  text("Cursor: " + mouse.toString().substring(4,16), width-margin, height - em);
}
