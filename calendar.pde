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

    if (z < 100) {
      // hour text:
      textSize(font_size);
      fill(150);
      text(ft.format(date), 10, px(i));
    }

    if (day) {
      // draw fat line to mark new day:
      strokeWeight(font_size);
      stroke(35);
      line(0, px(i)-font_size/2, width, px(i)-font_size/2);

      // draw skinny line to mark exactly where day begins:
      strokeWeight(1);
      stroke(30);
      line(0, px(i), width, px(i));

      // date text:
      textSize(font_size);
      fill(150);
      text(date.toString().substring(0, 10), 10, px(i));
    }
  }
}
