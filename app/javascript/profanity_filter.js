document.addEventListener("turbo:load", () => {
  const textarea = document.querySelector("#post_content, #comment_content");

  if (textarea) {
    textarea.addEventListener("input", () => {
      const forbiddenWords = ["badword1", "badword2"];
      const content = textarea.value;
      const regex = new RegExp(`\\b(${forbiddenWords.join("|")})\\b`, "gi");

      if (regex.test(content)) {
        alert("Your message contains inappropriate language.");
        textarea.style.borderColor = "red";
      } else {
        textarea.style.borderColor = "";
      }
    });
  }
});

