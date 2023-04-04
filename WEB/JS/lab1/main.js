import { dateTime } from "./components/dateTime/dateTime.js";
import { createCalendar } from "./components/calender/calendar.js";

const GET_DATA_TIME = (a) => dateTime(a);
const GET_CALENDAR = (a) => createCalendar(a);

let a = 0;
dateTimeBtn.addEventListener("click", () => {
  if (a == 0) {
    GET_DATA_TIME("dateTimeBtn");
    // setInterval(GET_DATA_TIME("dateTimeBtn"), 250);
    a += 1;
  } else {
    document.getElementById("dateTimeBtn").nextSibling.remove();
    a -= 1;
  }
});

let a1 = 0;
calenderBtn.addEventListener("click", () => {
  if (a1 == 0) {
    GET_CALENDAR("calenderBtn");
    a1 += 1;
  } else {
    document.getElementById("calenderBtn").nextSibling.remove();
    a1 -= 1;
  }
});
