document.addEventListener("input", function (event) {
  if (event.target.tagName === "TEXTAREA") {
    event.target.style.height = "auto";
    event.target.style.height = `${event.target.scrollHeight}px`;
  }
});
