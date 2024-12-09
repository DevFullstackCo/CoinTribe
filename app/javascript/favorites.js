function showPopUp(popupElement) {
  popupElement.style.display="flex";
}

function hidePopUp(popupElement) {
  popupElement.style.display="none";
}

function initializePopUp() {
  const btnFavorites = document.getElementById("open-favorite-popup");
  const popup = document.getElementById("popup-favorite");
  const closeBtn = document.getElementById("close");

  if (btnFavorites) {
    btnFavorites.addEventListener("click", function() {
      showPopUp(popup);
    });
  }

  if (closeBtn) {
    closeBtn.addEventListener("click", function() {
      hidePopUp(popup);
    });
  }
}
document.addEventListener("DOMContentLoaded", initializePopUp);


