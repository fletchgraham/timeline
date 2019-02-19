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

  void select_next() {
    if (frame != null) {
      Frame next = null;
      int last_diff = 999999999;
      for (int i=0; i < frames.frames.size(); i++) {
        Frame test = frames.frames.get(i);
        int diff = test.start - frame.start;
        if (diff > 0 && abs(diff) < last_diff) {
          if (test.project.equals(frame.project) && test.client.equals(frame.client)) {
            next = test;
            last_diff = diff;
          }
        }
      }
      if (next != null) {
        frame.selected = false;
        next.selected = true;
        off = next.start;
      }
    }
  }

  void select_previous() {
    if (frame != null) {
      Frame previous = null;
      int last_diff = 999999999;
      for (int i=0; i < frames.frames.size(); i++) {
        Frame test = frames.frames.get(i);
        int diff = frame.start - test.start;
        if (diff > 0 && abs(diff) < last_diff) {
          if (test.project.equals(frame.project) && test.client.equals(frame.client)) {
            previous = test;
            last_diff = diff;
          }
        }
      }
      if (previous != null) {
        frame.selected = false;
        previous.selected = true;
        off = previous.start;
      }
    }
  }
}
