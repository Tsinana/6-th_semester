export class Calendar {
  constructor(container) {
    this.container = container;
    this.date = new Date();
  }

  render() {
    const calendarTable = document.createElement("div");
    calendarTable.classList.add("calender");

    // Создаем заголовок календаря
    const calendarHeader = document.createElement("div");
    calendarHeader.classList.add("calendarHeader");

    const prevMonthButton = document.createElement("button");
    prevMonthButton.textContent = "<<";
    prevMonthButton.addEventListener("click", this.prevMonth.bind(this));
    prevMonthButton.classList.add("Monthbutton");
    calendarHeader.append(prevMonthButton);

    const monthName = document.createElement("span");
    monthName.classList.add("monthName");
    monthName.textContent =
      this.getMonthName(this.date.getMonth()) + " " + this.date.getFullYear();
    calendarHeader.append(monthName);

    const nextMonthButton = document.createElement("button");
    nextMonthButton.textContent = ">>";
    nextMonthButton.addEventListener("click", this.nextMonth.bind(this));
    nextMonthButton.classList.add("Monthbutton");
    calendarHeader.append(nextMonthButton);

    calendarTable.append(calendarHeader);

    // Создаем тело календаря
    const calendarBody = document.createElement("div");
    calendarBody.classList.add("calendarBody");

    this.getWeekDays().forEach((element) => {
      const cell = document.createElement("div");
      cell.textContent = element;
      cell.classList.add("weekDays");
      calendarBody.append(cell);
    });

    const daysInMonth = this.getDaysInMonth(
      this.date.getMonth(),
      this.date.getFullYear()
    );
    console.log(this.date.getDay());
    let dayCounter = 1;
    for (let i = 0; i < 6; i++) {
      for (let j = 0; j < 7; j++) {
        const cell = document.createElement("div");
        if (i === 0 && j < this.date.getDay()) {
          // Если ячейка принадлежит предыдущему месяцу
          const prevMonthDays = this.getDaysInMonth(
            this.date.getMonth() - 1,
            this.date.getFullYear()
          );
          cell.textContent = prevMonthDays - (this.date.getDay() - j - 1);
          cell.classList.add("prevMonth", "monthDay");
        } else if (dayCounter > daysInMonth) {
          // Если мы прошли все дни этого месяца
          cell.textContent = dayCounter - daysInMonth;
          cell.classList.add("nextMonth", "monthDay");
          dayCounter++;
        } else {
          // Эта ячейка принадлежит текущему месяцу
          cell.textContent = dayCounter;
          cell.classList.add("currentMonth", "monthDay");
          dayCounter++;
        }
        calendarBody.append(cell);
      }
    }

    // let l = calendarBody.querySelectorAll("div");
    // l[curDate + 5 + day_name].classList.add("currentDay");
    // for (let index = 0; index < l.length; index++) {
    //   if (index % 7 == 5 || index % 7 == 6) l[index].classList.add("weekend");
    // }

    calendarTable.append(calendarBody);
    this.container.append(calendarTable);
  }

  getWeekDays() {
    return ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  }

  prevMonth() {
    // Переключаемся на предыдущий месяц
    this.date = new Date(this.date.getFullYear(), this.date.getMonth() - 1, 1);
    this.container.innerHTML = "";
    this.render();
  }

  nextMonth() {
    // Переключаемся на следующий месяц
    this.date = new Date(this.date.getFullYear(), this.date.getMonth() + 1, 1);
    this.container.innerHTML = "";
    this.render();
  }

  getMonthName(monthNumber) {
    const monthNames = [
      "Январь",
      "Февраль",
      "Март",
      "Апрель",
      "Май",
      "Июнь",
      "Июль",
      "Август",
      "Сентябрь",
      "Октябрь",
      "Ноябрь",
      "Декабрь",
    ];

    return monthNames[monthNumber];
  }

  getDaysInMonth(month, year) {
    return new Date(year, month + 1, 0).getDate();
  }

  padZero(number) {
    if (number < 10) {
      return "0" + number;
    } else {
      return number;
    }
  }
}
