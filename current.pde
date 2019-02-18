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

  String tags_string() {
    if (frame != null) {
      return frame.tags.toString();
    } else {
      return "";
    }
  }

  ArrayList<String> tags() {
    ArrayList<String> tags = new ArrayList<String>();
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.project.equals(frame.project) && f.client.equals(frame.client)) {
        for (int j=0; j < f.tags.size(); j++) {
          if (!tags.contains(f.tags.getString(j))) {
            tags.add(f.tags.getString(j));
          }
        }
      }
    }
    return tags;
  }

  String tag_duration(String tag) {
    int duration = 0;
    for (int i = 0; i < frames.frames.size(); i++) {
      Frame f = frames.frames.get(i);
      if (f.project.equals(frame.project) && f.client.equals(frame.client)) {
        for (int j=0; j < f.tags.size(); j++) {
          if (f.tags.getString(j).equals(tag)) {
            duration += f.duration();
          }
        }
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
