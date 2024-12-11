document.addEventListener("DOMContentLoaded", function () {
  const deleteButtons = document.querySelectorAll(".btn-delete-comment");

  deleteButtons.forEach((button) => {
    button.addEventListener("click", function (event) {
      const confirmMessage = button.dataset.confirm || "Are you sure you want to delete it?";
      if (!confirm(confirmMessage)) {
        event.preventDefault();
      }
    });
  });
});

