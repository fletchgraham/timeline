// write debug info to the screen.

void draw_debug() {
  
  int margin = 20;
  fill(255);
  textAlign(RIGHT);
  //text("zoom: " + z, width-margin, height - font_size * 4);
  //text("offset: " + off, width-margin, height - font_size * 3);
  //text("mouse timestamp: " + ep(mouseY), width-margin, height - font_size * 2);
  text("Project Duration: " + frames.projectHours(), width-margin, height - font_size * 2); 
  
  Date mouse = new Date((long)ep(mouseY) * 1000);
  text("Mouse Datetime: " + mouse.toString(), width-margin, height - font_size);
}
