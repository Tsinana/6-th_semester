//Date and time //var 8-6-4

export function dateTime(element_id) {
  const elem = document.getElementById(element_id);

  let date_now = new Date();

  const date = formatDate(date_now);
  const time = formatTime(date_now);

  let div = document.createElement("div");
  div.className = "DateTime";
  div.insertAdjacentHTML("afterBegin", `<div>${date}</div><div>${time}</div>`);

  elem.after(div);
}

function formatTime(date) {
  let hh = date.getHours();
  let ampm = hh >= 12 ? "pm" : "am";
  hh = hh % 13;
  if (hh < 10) hh = "0" + hh;

  let mm = date.getMinutes();
  if (mm < 10) mm = "0" + mm;

  let ss = date.getSeconds();
  if (ss < 10) ss = "0" + ss;

  return hh + ":" + mm + ":" + ss + " " + ampm;
}

function formatDate(date) {
  let day = getDictDays(date.getDay()).toUpperCase();
  let yyyy = date.getFullYear();
  let mm = getDictMonth(date.getMonth()).toUpperCase();

  let dd = date.getDate();
  if (dd < 10) dd = "0" + dd;

  return day + ", " + yyyy + " " + dd + " " + mm;
}

function getDictDays(day) {
  let dict = {
    0: "Воскресенье",
    1: "Понедельник",
    2: "Вторник",
    3: "Среда",
    4: "Четверг",
    5: "Пятница",
    6: "Суббота",
  };
  return dict[day];
}

function getDictMonth(month) {
  let dict = {
    0: "января",
    1: "февраля",
    2: "марта",
    3: "апреля",
    4: "мая",
    5: "июня",
    6: "июля",
    7: "августа",
    8: "сентября",
    9: "октября",
    10: "ноября",
    11: "декабря",
  };
  return dict[month];
}
