document.addEventListener("turbo:load", function () {
  initNotifPopup();
});

document.addEventListener("turbo:render", function () {
  initNotifPopup();
});

function initNotifPopup() {
  const notifBtn = document.querySelector(".btn-notif");
  const notifPopup = document.querySelector(".notif-popup");

  if (notifBtn && notifPopup) {
    notifBtn.removeEventListener("click", handleNotifBtnClick);
    document.removeEventListener("click", handleDocumentClick);

    notifBtn.addEventListener("click", handleNotifBtnClick);
    document.addEventListener("click", handleDocumentClick);
  }
}

function handleNotifBtnClick(event) {
  const notifBtn = document.querySelector(".btn-notif");
  const notifPopup = document.querySelector(".notif-popup");

  if (notifPopup.style.display === "block") {
    notifPopup.style.display = "none";
  } else {
    notifPopup.style.display = "block";
    const rect = notifBtn.getBoundingClientRect();
    notifPopup.style.top = rect.bottom + "px";
    notifPopup.style.left = rect.left - 200 + "px";
  }
}

function handleDocumentClick(event) {
  const notifBtn = document.querySelector(".btn-notif");
  const notifPopup = document.querySelector(".notif-popup");

  if (!notifBtn.contains(event.target) && !notifPopup.contains(event.target)) {
    notifPopup.style.display = "none";
  }
}

