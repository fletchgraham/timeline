class Current {
  // return properties and stats from the selected frame as a string.
  // write data to the selected frame
  
  Frame frame;
  
  void update() {
    frame = frames.selection();
  }
  
  Current() {
    frame = frames.selection();
  }
  
  String get_value(String property) {
    if (property == "Client") {
      return client();
    }
    else if (property == "Project") {
      return project();
    }
    else if (property == "Task") {
      return task();
    }
    else {
      return "";
    }
  }
  
  String client() {
    if (frame != null) {
      return frame.client;
    }
    else {
      return "";
    }
  }
  
  String project() {
    if (frame != null) {
      return frame.project;
    }
    else {
      return "";
    }
  }
  
  String task() {
    if (frame != null) {
      return frame.task;
    }
    else {
      return "";
    }
  }
}
