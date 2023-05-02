export class Form {
  constructor(container) {
    this.container = container;
  }
  render() {
    let form = document.createElement("form");
    form.classList.add("form");
    form.id = "my-form";
    form.insertAdjacentHTML(
      "beforeend",
      `
      <label for="name">Name:</label>
  <input type="text" id="name" name="name" required>
  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required>
  <button type="submit">Submit</button>`
    );

    this.container.append(form);
  }
}
