class Frames {
  ArrayList<Frame> frames = new ArrayList<Frame>();
  JSONObject colors = new JSONObject();

  Frame selection() {
    Frame sel = null;
    for (int i = 0; i < frames.size(); i++) {
      Frame f = frames.get(i);
      if (f.selected) {
        sel = f;
      }
    }
    return sel;
  }

  void loadColors(String location) {
    try {
    colors = loadJSONObject(location);
    }
    catch (Exception e) {
    }
  }

  void updateColors() {
    for (int i = 0; i < frames.size(); i++) {
      JSONArray hsb = new JSONArray();
      Frame f = frames.get(i);
      hsb.append(f.h);
      hsb.append(f.s);
      hsb.append(f.b);
      colors.setJSONArray(f.client, hsb);
    }
    saveJSONObject(colors, "data/colors.json", "indent=1");
  }

  void saveColors(String location) {
    saveJSONObject(colors, location, "indent=1");
  }

  void mapColor(String client, color col) {
    JSONArray hsb = new JSONArray();
    hsb.append((int)hue(col));
    hsb.append((int)saturation(col));
    hsb.append((int)brightness(col));
    colors.setJSONArray(client, hsb);
  }

  void newFrame(float x1, int y1, float x2, int y2) {
    for (int i = 0; i < frames.size(); i++) {
      frames.get(i).selected = false;
    }
    Frame new_frame = new Frame(x1, y1, x2, y2); 
    frames.add(new_frame);
  }

  void saveJSON(String location) {
    JSONArray model = new JSONArray();

    for (int i = 0; i < frames.size(); i++) {

      Frame f = frames.get(i);
      JSONObject fr = new JSONObject();

      fr.setInt("start", f.start);
      fr.setInt("stop", f.stop);
      fr.setFloat("x1", f.x1);
      fr.setFloat("x2", f.x2);
      fr.setString("client", f.client);
      fr.setString("project", f.project);
      fr.setString("task", f.task);
      fr.setString("uuid", f.uuid);

      model.append(fr);
    }

    saveJSONArray(model, location, "indent=1");
  }

  void loadJSON(String location) {
    JSONArray json = loadJSONArray(location);
    for (int i = 0; i < json.size(); i++) {
      Frame fr = new Frame(json.getJSONObject(i));
      frames.add(fr);
    }
  }

  void deleteSelected() {
    for (int i = 0; i < frames.size(); i++) {
      Frame f = frames.get(i);
      if (f.selected) {
        frames.remove(i);
      }
    }
  }

  void render() {
    for (int i = 0; i < frames.size(); i++) {
      Frame f = frames.get(i);

      // if the frame is within the window, render it:
      if ( px(f.start) > 0 && px(f.stop) < height ) {
        try {
          JSONArray rgb = colors.getJSONArray(f.client);
          f.setColor(rgb.getInt(0), rgb.getInt(1), rgb.getInt(2));
          f.render();
        }
        catch (Exception e) {
          f.render();
        }
      }
    }
  }
}
