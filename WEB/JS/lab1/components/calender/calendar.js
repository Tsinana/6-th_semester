export function createCalendar(element_id) {
  const elem = document.getElementById(element_id);

  let shell = document.createElement("div");
  let calender = document.createElement("div");
  let monthName = document.createElement("div");
  calender.className = "calender";
  shell.className = "shell";
  monthName.className = "monthName";

  const date = getDate();
  for (const val in date) {
    calender.insertAdjacentHTML("beforeend", "<div>" + date[val] + "</div>");
  }

  let date_now = new Date();
  const mm = getNameMonth(date_now.getMonth());
  const curDate = date_now.getDate();

  monthName.insertAdjacentHTML(
    "afterBegin",
    "<div> <div value='<-' id='calendarBtnL'>s</dib>" +
      mm +
      "<div value='->' id='calendarBtnR'></dib></div>"
  );
  const countDaysLastMonth = getCountDaysLastMonth(date_now);
  const countDaysCurMonth = getCountDaysCurMonth(date_now);
  const day_name = getDayName(date_now);

  if (day_name == 0) day_name = 7;

  for (let i = 2 - day_name; i <= 43 - day_name; i++) {
    if (i > 0 && i <= countDaysCurMonth)
      calender.insertAdjacentHTML("beforeend", "<div >" + i + "</div>");
    else if (i <= 0)
      calender.insertAdjacentHTML(
        "beforeend",
        '<div class="notDayInMonth">' + (countDaysLastMonth + i) + "</div>"
      );
    else
      calender.insertAdjacentHTML(
        "beforeend",
        '<div class="notDayInMonth">' + (i - countDaysCurMonth) + "</div>"
      );
  }

  let l = calender.querySelectorAll("div");
  l[curDate + 5 + day_name].classList.add("currentDate");
  for (let index = 0; index < l.length; index++) {
    if (index % 7 == 5 || index % 7 == 6) l[index].classList.add("weekend");
  }

  shell.insertAdjacentElement("afterBegin", calender);
  shell.insertAdjacentElement("afterBegin", monthName);
  elem.after(shell);
}

function getDayName(date) {
  const keepDate = date.getDate();
  date.setDate(1);
  const ans = date.getDay();
  date.setDate(keepDate);
  return ans;
}

function getCountDaysLastMonth(date) {
  const keepDate = date.getDate();
  date.setDate(0);
  const ans = date.getDate();
  date.setDate(keepDate + date.getDate());
  return ans;
}

function getCountDaysCurMonth(date) {
  const keepDate = date.getDate();
  date.setMonth(date.getMonth() + 1);
  date.setDate(0);
  const ans = date.getDate();
  date.setDate(keepDate);
  return ans;
}

function getDate() {
  return ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
}

function getNameMonth(month) {
  let dict = {
    0: "январь",
    1: "февраль",
    2: "март",
    3: "апрель",
    4: "май",
    5: "июнь",
    6: "июль",
    7: "август",
    8: "сентябрь",
    9: "октябрь",
    10: "ноябрь",
    11: "декабрь",
  };
  return dict[month].toUpperCase();
}
