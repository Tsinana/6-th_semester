import { Slapform } from "./classes/slapform";

function addNewForm(form) {
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    let formData = new FormData(e.target);
    formData;
    Slapform.postFetch(formData);
  });
}

addNewForm(mainForm);
