import { Calendar } from "./components/calendar/calendar.js";
import { Form } from "./components/form/form.js";

let a = 0;
calendarBtn.addEventListener("click", () => {
  if (a == 0) {
    const calendarContainer = document.getElementById("calendar");
    const calendar = new Calendar(calendarContainer);
    calendar.render();
    a += 1;
  } else {
    document.getElementById("calendar").firstElementChild.remove();
    a -= 1;
  }
});

let button_switch_for_task3 = 0;
task3Btn.addEventListener("click", () => {
  if (button_switch_for_task3 == 0) {
    const task3Table = document.createElement("div");
    const emptyEl1 = document.createElement("div");
    const emptyEl2 = document.createElement("div");
    task3Table.append(emptyEl1);
    task3Table.append(emptyEl2);
    const emptyElements = task3Table.querySelectorAll("div:empty");
    task3Table.textContent = emptyElements.length;
    task3.append(task3Table);
    button_switch_for_task3 += 1;
  } else {
    document.getElementById("task3").firstElementChild.remove();
    button_switch_for_task3 -= 1;
  }
});

let button_switch_for_task4 = 0;
let intervalId = null;
task4Btn.addEventListener("click", () => {
  if (button_switch_for_task4 == 0) {
    const task4Table = document.createElement("div");
    task4Table.classList.add("flex-container-row");
    const block1 = document.createElement("div");
    const block2 = document.createElement("div");
    const block3 = document.createElement("div");
    block1.classList.add("block");
    block2.classList.add("block");
    block3.classList.add("block");
    task4Table.append(block1);
    task4Table.append(block2);
    task4Table.append(block3);
    task4.append(task4Table);
    intervalId = setInterval(() => {
      displayImage();
    }, 100);
    button_switch_for_task4 += 1;
  } else {
    clearInterval(intervalId);
    document.getElementById("task4").firstElementChild.remove();
    button_switch_for_task4 -= 1;
  }
});

function displayImage() {
  const blocks = document.querySelectorAll(".block");
  const randomIndex = Math.floor(Math.random() * blocks.length);
  const randomBlock = blocks[randomIndex];

  blocks.forEach((block) => {
    const image = block.querySelector("img");
    if (image) {
      image.remove();
    }
  });

  // создаем новый элемент img и добавляем его в выбранный блок
  const img = document.createElement("img");
  img.classList.add("block");
  img.src = "/images/icon.ico";
  randomBlock.appendChild(img);
}

//
// task 5
//

let button_switch_for_task5 = 0;
task5Btn.addEventListener("click", () => {
  if (button_switch_for_task5 == 0) {
    const task5Table = document.createElement("div");

    let listItem;
    let lastListItem = task5Table;
    let margin = 0;

    while (true) {
      const content = prompt("Введите содержимое элемента списка");
      if (content === null || content.trim() === "") {
        break;
      }

      listItem = document.createElement("li");
      listItem.textContent = content;
      listItem.style.marginLeft = `${margin}px`;
      margin += 10;
      lastListItem.append(listItem);
      lastListItem = listItem;
    }

    task5Table.addEventListener("click", (event) => {
      const clickedItem = event.target;

      if (clickedItem.tagName === "LI") {
        const confirmed = confirm(
          `Вы уверены, что хотите удалить элемент "${clickedItem.textContent}"?`
        );

        if (confirmed) {
          clickedItem.remove();
          alert(`Элемент "${clickedItem.textContent}" успешно удален.`);
        }
      }
    });
    task5.append(task5Table);
    button_switch_for_task5 += 1;
  } else {
    document.getElementById("task5").firstElementChild.remove();
    button_switch_for_task5 -= 1;
  }
});

//
// task 6
//

let button_switch_for_task6 = 0;
task6Btn.addEventListener("click", () => {
  if (button_switch_for_task6 == 0) {
    const task6Table = document.createElement("div");
    task6Table.classList.add("flex-container-row");
    const block1 = document.createElement("img");
    const block2 = document.createElement("img");
    const block3 = document.createElement("img");
    block1.classList.add("image", "1");
    block2.classList.add("image", "1");
    block3.classList.add("image", "1");
    block1.src = "/images/icon.ico";
    block2.src = "/images/icon.ico";
    block3.src = "/images/icon.ico";
    task6Table.append(block1);
    task6Table.append(block2);
    task6Table.append(block3);

    task6.append(task6Table);
    button_switch_for_task6 += 1;

    task6Table.addEventListener("mouseover", (event) => {
      if (event.target.classList.contains("image")) {
        event.target.image.classList.add("active");
      }
    });

    task6Table.addEventListener("mouseout", (event) => {
      if (event.target.classList.contains("image")) {
        event.target.image.classList.remove("active");
      }
    });
  } else {
    document.getElementById("task6").firstElementChild.remove();
    button_switch_for_task6 -= 1;
  }
});

//
// task 7
//

let button_switch_for_task7 = 0;
task7Btn.addEventListener("click", () => {
  if (button_switch_for_task7 == 0) {
    const task7Table = document.createElement("div");
    const listHeader = document.createElement("h1");
    const list1 = document.createElement("li");
    const list2 = document.createElement("li");
    const list3 = document.createElement("li");
    listHeader.textContent = "Здесь сладости!";
    list1.textContent = "Пироженное";
    list2.textContent = "Мед";
    list3.textContent = "Конфета";
    task7Table.append(listHeader);
    task7Table.append(list1);
    task7Table.append(list2);
    task7Table.append(list3);
    task7Table.style.color = "purple";

    function clickHandler(event) {
      const clickedItem = event.target;
      fadeOut(clickedItem);
      if (task7Table.childNodes.length === 1) {
        const el = document.createElement("h1");
        el.textContent = "Сладкого больше нет";
        task7Table.style.color = "red";
        task7Table.append(el);
        task7Table.removeEventListener("click", clickHandler); // Удаление обработчика
      }
    }

    task7Table.addEventListener("click", clickHandler);

    task7.append(task7Table);
    button_switch_for_task7 += 1;
  } else {
    document.getElementById("task7").firstElementChild.remove();
    button_switch_for_task7 -= 1;
  }
});

function fadeOut(element) {
  let opacity = 1;

  const interval = setInterval(() => {
    if (opacity > 0) {
      opacity -= 0.1;
      element.style.opacity = opacity;
    } else {
      clearInterval(interval);
      element.remove();
    }
  }, 50);
}

//
// task 8
//

let button_switch_for_task8 = 0;
task8Btn.addEventListener("click", () => {
  if (button_switch_for_task8 == 0) {
    const task8Table = document.createElement("div");
    task8Table.classList.add("container8");
    const divTask8 = document.createElement("div");
    const imgTask8 = document.createElement("img");
    divTask8.classList.add("text8");
    imgTask8.classList.add("image8");
    divTask8.textContent = "Text";
    imgTask8.src = "/images/icon.ico";

    imgTask8.addEventListener("mouseover", () => {
      fadeOut8(imgTask8);
    });

    imgTask8.addEventListener("mouseout", () => {
      fadeIn8(imgTask8);
    });

    task8Table.append(divTask8);
    task8Table.append(imgTask8);
    task8.append(task8Table);
    button_switch_for_task8 += 1;
  } else {
    document.getElementById("task8").firstElementChild.remove();
    button_switch_for_task8 -= 1;
  }
});

function fadeOut8(element) {
  let opacity = 1;

  const interval = setInterval(() => {
    if (opacity > 0) {
      opacity -= 0.1;
      element.style.opacity = opacity;
    } else {
      clearInterval(interval);
    }
  }, 50);
}

function fadeIn8(element) {
  let opacity = 0;

  const interval = setInterval(() => {
    if (opacity < 1) {
      opacity += 0.1;
      element.style.opacity = opacity;
    } else {
      clearInterval(interval);
    }
  }, 50);
}

//
// task 9-10
//

let button_switch_for_task9 = 0;
task9Btn.addEventListener("click", () => {
  if (button_switch_for_task9 == 0) {
    const formContainer = document.getElementById("task9");
    const form = new Form(formContainer);

    form.render();

    $(document).ready(function () {
      $("#my-form").submit(function (event) {
        event.preventDefault();

        var name = $("#name").val();
        var email = $("#email").val();

        if (name == "") {
          alert("Please enter your name.");
          return false;
        }
        if (email == "") {
          alert("Please enter your email address.");
          return false;
        }
      });
    });

    button_switch_for_task9 += 1;
  } else {
    document.getElementById("task9").firstElementChild.remove();
    button_switch_for_task9 -= 1;
  }
});
