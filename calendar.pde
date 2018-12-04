// drawing the calendar
import java.text.*;

void draw_timeline() {
  textAlign(LEFT);
  // draw the calendar:

  // format for the hour text:
  SimpleDateFormat ft = new SimpleDateFormat ("hh a");

  // main loop for drawing the calendar on the screen:
  for (int i = get_nearest(0); i > get_nearest(height); i -= 3600) {

    // check if the hour mark is also the day mark:
    Date date = new Date((long)i * 1000);
    GregorianCalendar cal = new GregorianCalendar();
    cal.setTimeInMillis(date.getTime());
    boolean day = cal.get(Calendar.HOUR_OF_DAY) == 0;

    if (z < 250) {

      // skinny hour lines:
      strokeWeight(1);
      stroke(35);
      line(0, px(i), width, px(i));
    }

    if (day) {
      Date yesterday = new Date(date.getTime()-1000);
      // draw fat line to mark new day:
      strokeWeight(5);
      stroke(35);
      line(0, px(i), width, px(i));

      // date text:
      textSize(em);
      fill(150);
      textAlign(RIGHT, TOP);
      text(yesterday.toString().substring(0, 10), width-10, px(i));
    }
    
    if (z < 120) {
      // hour text:
      textAlign(LEFT, BASELINE);
      textSize(em*.8);
      fill(150);
      text(ft.format(date), 10, px(i));
    }
  }
}
