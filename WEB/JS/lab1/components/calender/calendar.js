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
  date_now.setDate(1);
  const day_name = date_now.getDay();

  monthName.innerHTML = `${mm}`;

  for (
    let i = 1;
    i <= 42;
    i++ // Цикл для заполнения таблицы.
  ) {
    calender.insertAdjacentHTML("beforeend", "<div>" + i + "</div>");
    // Выводим ячейку календаря.
  }

  shell.insertAdjacentElement("afterBegin", calender);
  shell.insertAdjacentElement("afterBegin", monthName);
  elem.after(shell);
  // Закрываем теги элементов ‹table›.
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
