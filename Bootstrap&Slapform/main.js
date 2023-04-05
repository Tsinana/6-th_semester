fetch("https://api.slapform.com/{form_id}", {
  body: JSON.stringify({
    // The data you want submitted and emailed to you
    name: "Jon Snow",
    message: "Hello World!",
  }),
})
  .then(function (response) {
    // This function runs only on success
    console.log("Success!", response);
  })
  .catch(function (response) {
    // This function runs only on error
    console.log("Fail!", response);
  })
  .finally(function () {
    // This function runs regardless of success or error
    console.log("This always runs!");
  });
