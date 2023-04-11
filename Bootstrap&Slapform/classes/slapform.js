export class Slapform {


  static postFetch(dataObject) {
    fetch("https://formcarry.com/s/dle9beudYj", {
      method: "POST",
      headers: {
        "Content-Type": "application/json", //-
        Accept: "application/json", //-
      },
      body: JSON.stringify(dataObject).then((resp) => resp.json()),
    })
      .then(function (response) {
        console.log("Success", response);
      })
      .catch(function (e) {
        console.error("Fail", e);
      });
  }
}

// const controller = new AbortController();

// // 5 second timeout:

// const timeoutId = setTimeout(() => controller.abort(), 5000);

// fetch("https://api.slapform.com/bLGLWxVHX", {+
//   body: JSON.stringify({+
//     signal: controller.signal,
//     lineTextField: "test",
//     email: "test@",
//     date: "",
//     textArea: "testArea",
//     select: "A",
//     multySelect: "AA",
//     radio1: "r1",
//     radio2: "r2",
//     cb: "cd",
//   }),
// })
//   .then(function (response) {
//     console.log("Success", response);
//   })
//   .catch(function (e) {
//     console.error("Fail", e);
//   });
