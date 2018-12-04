// converting and working with coordinate systems.

int get_nearest(int px) {
 // return the timestamp of the nearest whole hour to a given pixel value.
 
 int ep = ep(px);
 GregorianCalendar cal = new GregorianCalendar();
 cal.setTimeInMillis((long)ep * 1000);
 cal.set(Calendar.MINUTE, 0);
 cal.set(Calendar.SECOND, 0);
 ep = (int)(cal.getTimeInMillis()/1000);
 return ep;
}

int ep(int px) {
  // convert a screen Y coordinate to an epoch
  
  // 1) undo the translation to the center of the window.
  // 2) flip everything and undo the zoom.
  // 3) undo the offset
  
  int ep = (int)(-(float)(px - height/2) * z + off);
  return ep;
}

int px(int ep) {
  // convert an epoch in seconds to standard processing Y value.
  
  // 1) translate everything using offset global variable
  // 2) flip everything and divide by the zoom value to get a managable scale.
  // 3) translate by half the window height to move the focus to center
  
  int px;
  px = (int)(-(float)(ep - off) / z) + height/2;
  return px;
}
