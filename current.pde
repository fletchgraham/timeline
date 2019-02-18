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

  String client() {
    if (frame != null) {
      return frame.client;
    } else {
      return "";
    }
  }

  String project() {
    if (frame != null) {
      return frame.project;
    } else {
      return "";
    }
  }

  String task() {
    if (frame != null) {
      return frame.task;
    } else {
      return "";
    }
  }

  ArrayList<String> tasks() {
    ArrayList<String> tasks = new ArrayList<String>();
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.project.equals(frame.project) && f.client.equals(frame.client) && !(tasks.contains(f.task))) {
        tasks.add(f.task);
      }
    }
    return tasks;
  }
  
  String task_duration(String task) {
    int duration = 0;
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.project.equals(frame.project) && f.client.equals(frame.client) && f.task.equals(task)) {
        duration += f.duration();
      }
    }
    return String.valueOf(((float)duration)/3600);
  }

  String project_duration() {
    int pdur = 0;
    if (frame != null) {
      for (int i = 0; i < frames.frames.size(); i++) {
        Frame f = frames.frames.get(i);
        if (f.project.equals(frame.project) && f.client.equals(frame.client)) {
          pdur += f.duration();
        }
      }
      return String.valueOf(((float)pdur)/3600);
    } else {
      return "";
    }
  }
}
