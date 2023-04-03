import { dateTime } from "./components/dateTime/dateTime.js";
import { createCalendar } from "./components/calender/calendar.js";

const GET_DATA_TIME = (a) => dateTime(a);
const GET_CALENDAR = (a) => createCalendar(a);

// setInterval(GET_DATA_TIME("IDDateTime"), 250);
GET_DATA_TIME("dateTimeBtn");
GET_CALENDAR("calenderBtn");
